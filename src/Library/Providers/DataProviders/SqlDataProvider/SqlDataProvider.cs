using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Configuration.Provider;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using System.IO;
using System.Linq;
using System.Text;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.Providers.DataProviders
{
    /// <summary>
    /// 
    /// </summary>
    public partial class SqlDataProvider : DataProvider
    {
        /*** DELEGATE ***/
        private delegate void GenerateListFromReader<T>(SqlDataReader returnData, ref List<T> tempList);
        private static readonly ILog Log = LogManager.GetLogger(typeof(SqlDataProvider));
        private string _connectionString = string.Empty;
        private string _providerPath = string.Empty;
        private string _mappedProviderPath = string.Empty;

        /// <summary>
        /// Initializes the specified name.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="config">The configuration</param>
        public override void Initialize(string name, NameValueCollection config)
        {
            base.Initialize(name, config);

            var str = config["connectionStringName"];

            if (config["providerPath"] != null)
                _providerPath = config["providerPath"];

            _connectionString = ConfigurationManager.ConnectionStrings[str].ConnectionString;

            if (string.IsNullOrEmpty(str))
                throw new ProviderException("connectionStringName value not specified in web.config for SqlDataProvider");

            if (string.IsNullOrEmpty(_connectionString))
                throw new ProviderException("connectionString value not specified in web.config");

            if (string.IsNullOrEmpty(_providerPath))
                throw new ProviderException("providerPath folder value not specified in web.config for SqlDataProvider");

        }

        #region Private Constants

        /// <summary>
        /// Stored Procedure Constants
        /// </summary>
        private const string SP_PROJECT_CREATE = "BugNet_Project_CreateNewProject";
        private const string SP_PROJECT_DELETE = "BugNet_Project_DeleteProject";
        private const string SP_PROJECT_GETALLPROJECTS = "BugNet_Project_GetAllProjects";
        private const string SP_PROJECT_GETPUBLICPROJECTS = "BugNet_Project_GetPublicProjects";
        private const string SP_PROJECT_GETPROJECTBYID = "BugNet_Project_GetProjectById";
        private const string SP_PROJECT_UPDATE = "BugNet_Project_UpdateProject";
        private const string SP_PROJECT_ADDUSERTOPROJECT = "BugNet_Project_AddUserToProject";
        private const string SP_PROJECT_REMOVEUSERFROMPROJECT = "BugNet_Project_RemoveUserFromProject";
        private const string SP_PROJECT_GETPROJECTSBYMEMBERUSERNAME = "BugNet_Project_GetProjectsByMemberUserName";
        private const string SP_PROJECT_GETPROJECTBYCODE = "BugNet_Project_GetProjectByCode";
        private const string SP_PROJECT_CLONEPROJECT = "BugNet_Project_CloneProject";
        private const string SP_PROJECT_GETROADMAP = "BugNet_Project_GetRoadMap";
        private const string SP_PROJECT_GETROADMAPPROGRESS = "BugNet_Project_GetRoadMapProgress";
        private const string SP_PROJECT_GETCHANGELOG = "BugNet_Project_GetChangeLog";

        private const string SP_PROJECT_ISUSERPROJECTMEMBER = "BugNet_Project_IsUserProjectMember";

        private const string SP_PROJECTMAILBOX_GETPROJECTBYMAILBOX = "BugNet_ProjectMailbox_GetProjectByMailbox";
        private const string SP_PROJECTMAILBOX_GETMAILBOXBYID = "BugNet_ProjectMailbox_GetMailboxById";
        private const string SP_PROJECTMAILBOX_GETMAILBYPROJECTID = "BugNet_ProjectMailbox_GetMailboxByProjectId";
        private const string SP_PROJECTMAILBOX_CREATEPROJECTMAILBOX = "BugNet_ProjectMailbox_CreateProjectMailbox";
        private const string SP_PROJECTMAILBOX_DELETEPROJECTMAILBOX = "BugNet_ProjectMailbox_DeleteProjectMailbox";
        private const string SP_PROJECTMAILBOX_UPDATEPROJECTMAILBOX = "BugNet_ProjectMailbox_UpdateProjectMailbox";

        //User - Role Stored Procs
        private const string SP_USER_GETUSERSBYPROJECTID = "BugNet_User_GetUsersByProjectId";
        private const string SP_PROJECT_GETMEMBERROLESBYPROJECTID = "BugNET_Project_GetMemberRolesByProjectId";

        private const string SP_PERMISSION_GETALLPERMISSIONS = "BugNet_Permission_GetAllPermissions";
        private const string SP_PERMISSION_GETROLEPERMISSIONS = "BugNet_Permission_GetRolePermission";
        private const string SP_PERMISSION_GETPERMISSIONSBYROLE = "BugNet_Permission_GetPermissionsByRole";
        private const string SP_PERMISSION_DELETEROLEPERMISSION = "BugNet_Permission_DeleteRolePermission";
        private const string SP_PERMISSION_ADDROLEPERMISSION = "BugNet_Permission_AddRolePermission";

        private const string SP_ROLE_GETPROJECTROLESBYUSER = "BugNet_Role_GetProjectRolesByUser";
        private const string SP_ROLE_GETROLESBYUSER = "BugNet_Role_GetRolesByUser";
        private const string SP_ROLE_GETROLEBYID = "BugNet_Role_GetRoleById";
        private const string SP_ROLE_GETROLESBYPROJECT = "BugNet_Role_GetRolesByProject";
        private const string SP_ROLE_ROLEEXISTS = "BugNet_Role_RoleExists";
        private const string SP_ROLE_GETALLROLES = "BugNet_Role_GetAllRoles";
        private const string SP_ROLE_DELETEROLE = "BugNet_Role_DeleteRole";
        private const string SP_ROLE_REMOVEUSERFROMROLE = "BugNet_Role_RemoveUserFromRole";
        private const string SP_ROLE_ADDUSERTOROLE = "BugNet_Role_AddUserToRole";
        private const string SP_ROLE_UPDATEROLE = "BugNet_Role_UpdateRole";
        private const string SP_ROLE_CREATE = "BugNet_Role_CreateNewRole";

        //Issue Stored Procs
        private const string SP_ISSUE_CREATE = "BugNet_Issue_CreateNewIssue";
        private const string SP_ISSUE_UPDATE = "BugNet_Issue_UpdateIssue";
        private const string SP_ISSUE_DELETE = "BugNet_Issue_Delete";
        private const string SP_ISSUE_GETISSUEBYID = "BugNet_Issue_GetIssueById";
        private const string SP_ISSUE_GETISSUESBYRELEVANCY = "BugNet_Issue_GetIssuesByRelevancy";
        private const string SP_ISSUE_GETISSUESBYASSIGNEDUSERNAME = "BugNet_Issue_GetIssuesByAssignedUserName";
        private const string SP_ISSUE_GETISSUESBYCREATORUSERNAME = "BugNet_Issue_GetIssuesByCreatorUserName";
        private const string SP_ISSUE_GETISSUESBYOWNERUSERNAME = "BugNet_Issue_GetIssuesByOwnerUserName";
        private const string SP_ISSUE_GETMONITOREDISSUESBYUSERNAME = "BugNet_Issue_GetMonitoredIssuesByUserName";
        private const string SP_ISSUE_GETISSUESBYPROJECTID = "BugNet_Issue_GetIssuesByProjectId";

        private const string SP_ISSUE_GETISSUEMILESTONECOUNTBYPROJECT = "BugNet_Issue_GetIssueMilestoneCountByProject";

        private const string SP_ISSUE_GETISSUESTATUSCOUNTBYPROJECT = "BugNet_Issue_GetIssueStatusCountByProject";
        private const string SP_ISSUE_GETISSUEPRIORITYCOUNTBYPROJECT = "BugNet_Issue_GetIssuePriorityCountByProject";
        private const string SP_ISSUE_GETISSUEUSERCOUNTBYPROJECT = "BugNet_Issue_GetIssueUserCountByProject";
        private const string SP_ISSUE_GETISSUEUNASSIGNEDCOUNTBYPROJECT = "BugNet_Issue_GetIssueUnassignedCountByProject";
        private const string SP_ISSUE_GETISSUEUNSCHEDULEDMILESTONECOUNTBYPROJECT = "BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject";
        private const string SP_ISSUE_GETISSUETYPECOUNTBYPROJECT = "BugNet_Issue_GetIssueTypeCountByProject";
        private const string SP_ISSUE_GETISSUECATEGORYCOUNTBYPROJECT = "BugNet_Issue_GetIssueCategoryCountByProject";
        private const string SP_ISSUE_GETOPENISSUES = "BugNet_Issue_GetOpenIssues";

        private const string SP_QUERY_GETQUERIESBYUSERNAME = "BugNet_Query_GetQueriesByUsername";
        private const string SP_QUERY_SAVEQUERY = "BugNet_Query_SaveQuery";
        private const string SP_QUERY_UPDATEQUERY = "BugNet_Query_UpdateQuery";
        private const string SP_QUERY_SAVEQUERYCLAUSE = "BugNet_Query_SaveQueryClause";
        private const string SP_QUERY_GETSAVEDQUERY = "BugNet_Query_GetSavedQuery";
        private const string SP_QUERY_DELETEQUERY = "BugNet_Query_DeleteQuery";
        private const string SP_QUERY_GETQUERYBYID = "BugNet_Query_GetQueryById";

        //Related Issue Stored Procs
        private const string SP_RELATEDISSUE_GETRELATEDISSUES = "BugNet_RelatedIssue_GetRelatedIssues";
        private const string SP_RELATEDISSUE_CREATENEWRELATEDISSUE = "BugNet_RelatedIssue_CreateNewRelatedIssue";
        private const string SP_RELATEDISSUE_DELETERELATEDISSUE = "BugNet_RelatedIssue_DeleteRelatedIssue";
        private const string SP_RELATEDISSUE_CREATENEWPARENTISSUE = "BugNet_RelatedIssue_CreateNewParentIssue";
        private const string SP_RELATEDISSUE_CREATENEWCHILDISSUE = "BugNet_RelatedIssue_CreateNewChildIssue";
        private const string SP_RELATEDISSUE_DELETECHILDISSUE = "BugNet_RelatedIssue_DeleteChildIssue";
        private const string SP_RELATEDISSUE_DELETEPARENTISSUE = "BugNet_RelatedIssue_DeleteParentIssue";
        private const string SP_RELATEDISSUE_GETPARENTISSUES = "BugNet_RelatedIssue_GetParentIssues";
        private const string SP_RELATEDISSUE_GETCHILDISSUES = "BugNet_RelatedIssue_GetChildIssues";

        //Attachment Stored Procs
        private const string SP_ISSUEATTACHMENT_CREATE = "BugNet_IssueAttachment_CreateNewIssueAttachment";
        private const string SP_ISSUEATTACHMENT_GETATTACHMENTBYID = "BugNet_IssueAttachment_GetIssueAttachmentById";
        private const string SP_ISSUEATTACHMENT_GETATTACHMENTSBYISSUEID = "BugNet_IssueAttachment_GetIssueAttachmentsByIssueId";
        private const string SP_ISSUEATTACHMENT_DELETEATTACHMENT = "BugNet_IssueAttachment_DeleteIssueAttachment";

        //Comment Stored Procs
        private const string SP_ISSUECOMMENT_CREATE = "BugNet_IssueComment_CreateNewIssueComment";
        private const string SP_ISSUECOMMENT_GETISSUECOMMENTBYID = "BugNet_IssueComment_GetIssueCommentById";
        private const string SP_ISSUECOMMENT_GETISSUECOMMENTSBYISSUEID = "BugNet_IssueComment_GetIssueCommentsByIssueId";
        private const string SP_ISSUECOMMENT_DELETE = "BugNet_IssueComment_DeleteIssueComment";
        private const string SP_ISSUECOMMENT_UPDATE = "BugNet_IssueComment_UpdateIssueComment";

        //Issue Revisions
        private const string SP_ISSUEREVISION_CREATE = "BugNet_IssueRevision_CreateNewIssueRevision";
        private const string SP_ISSUEREVISION_GETISSUEREVISIONSBYISSUEID = "BugNet_IssueRevision_GetIssueRevisionsByIssueId";
        private const string SP_ISSUEREVISION_DELETE = "BugNet_IssueRevision_DeleteIssueRevision";

        //Issue Votes
        private const string SP_ISSUEVOTE_CREATE = "BugNet_IssueVote_CreateNewIssueVote";
        private const string SP_ISSUEVOTE_HASUSERVOTED = "BugNet_IssueVote_HasUserVoted";

        //History Stored Procs
        private const string SP_ISSUEHISTORY_CREATENEWISSUEHISTORY = "BugNet_IssueHistory_CreateNewIssueHistory";
        private const string SP_ISSUEHISTORY_GETISSUEHISTORYBYISSUEID = "BugNet_IssueHistory_GetIssueHistoryByIssueId";

        //Milestone Stored Procs
        private const string SP_MILESTONE_CREATE = "BugNet_ProjectMilestones_CreateNewMilestone";
        private const string SP_MILESTONE_GETMILESTONEBYPROJECTID = "BugNet_ProjectMilestones_GetMilestonesByProjectId";
        private const string SP_MILESTONE_DELETE = "BugNet_ProjectMilestones_DeleteMilestone";
        private const string SP_MILESTONE_GETMILESTONEBYID = "BugNet_ProjectMilestones_GetMilestoneById";
        private const string SP_MILESTONE_UPDATE = "BugNet_ProjectMilestones_UpdateMilestone";
        private const string SP_MILESTONE_CANDELETE = "BugNet_ProjectMilestones_CanDeleteMilestone";
        
        //Category Stored Procs
        private const string SP_CATEGORY_CREATE = "BugNet_ProjectCategories_CreateNewCategory";
        private const string SP_CATEGORY_UPDATE = "BugNet_ProjectCategories_UpdateCategory";
        private const string SP_CATEGORY_DELETE = "BugNet_ProjectCategories_DeleteCategory";
        private const string SP_CATEGORY_GETCATEGORIESBYPROJECTID = "BugNet_ProjectCategories_GetCategoriesByProjectId";
        private const string SP_CATEGORY_GETCATEGORYBYID = "BugNet_ProjectCategories_GetCategoryById";
        private const string SP_CATEGORY_GETROOTCATEGORIESBYPROJECTID = "BugNet_ProjectCategories_GetRootCategoriesByProjectId";
        private const string SP_CATEGORY_GETCHILDCATEGORIESBYCATEGORYID = "BugNet_ProjectCategories_GetChildCategoriesByCategoryId";

        //Status
        private const string SP_STATUS_GETSTATUSBYPROJECTID = "BugNet_ProjectStatus_GetStatusByProjectId";
        private const string SP_STATUS_CREATE = "BugNet_ProjectStatus_CreateNewStatus";
        private const string SP_STATUS_UPDATE = "BugNet_ProjectStatus_UpdateStatus";
        private const string SP_STATUS_GETSTATUSBYID = "BugNet_ProjectStatus_GetStatusById";
        private const string SP_STATUS_DELETE = "BugNet_ProjectStatus_DeleteStatus";
        private const string SP_STATUS_CANDELETE = "BugNet_ProjectStatus_CanDeleteStatus";

        //Issue Type Stored Procs
        private const string SP_ISSUETYPE_GETISSUETYPEBYID = "BugNet_ProjectIssueTypes_GetIssueTypeById";
        private const string SP_ISSUETYPE_GETISSUETYPESBYPROJECTID = "BugNet_ProjectIssueTypes_GetIssueTypesByProjectId";
        private const string SP_ISSUETYPE_CREATE = "BugNet_ProjectIssueTypes_CreateNewIssueType";
        private const string SP_ISSUETYPE_DELETE = "BugNet_ProjectIssueTypes_DeleteIssueType";
        private const string SP_ISSUETYPE_UPDATE = "BugNet_ProjectIssueTypes_UpdateIssueType";
        private const string SP_ISSUETYPE_CANDELETE = "BugNet_ProjectIssueTypes_CanDeleteIssueType";

        //Resolution Stored Procs
        private const string SP_RESOLUTION_GETRESOLUTIONBYID = "BugNet_ProjectResolutions_GetResolutionById";
        private const string SP_RESOLUTION_GETRESOLUTIONSBYPROJECTID = "BugNet_ProjectResolutions_GetResolutionsByProjectId";
        private const string SP_RESOLUTION_CREATE = "BugNet_ProjectResolutions_CreateNewResolution";
        private const string SP_RESOLUTION_DELETE = "BugNet_ProjectResolutions_DeleteResolution";
        private const string SP_RESOLUTION_UPDATE = "BugNet_ProjectResolutions_UpdateResolution";
        private const string SP_RESOLUTION_CANDELETE = "BugNet_ProjectResolutions_CanDeleteResolution";

        //Priority Stored Procs
        private const string SP_PRIORITY_GETPRIORITYBYID = "BugNet_ProjectPriorities_GetPriorityById";
        private const string SP_PRIORITY_GETPRIORITIESBYPROJECTID = "BugNet_ProjectPriorities_GetPrioritiesByProjectId";
        private const string SP_PRIORITY_CREATE = "BugNet_ProjectPriorities_CreateNewPriority";
        private const string SP_PRIORITY_DELETE = "BugNet_ProjectPriorities_DeletePriority";
        private const string SP_PRIORITY_UPDATE = "BugNet_ProjectPriorities_UpdatePriority";
        private const string SP_PRIORITY_CANDELETE = "BugNet_ProjectPriorities_CanDeletePriority";

        //Notification Stored Procs
        private const string SP_ISSUENOTIFICATION_CREATE = "BugNet_IssueNotification_CreateNewIssueNotification";
        private const string SP_ISSUENOTIFICATION_DELETE = "BugNet_IssueNotification_DeleteIssueNotification";
        private const string SP_ISSUENOTIFICATION_GETISSUENOTIFICATIONSBYISSUEID = "BugNet_IssueNotification_GetIssueNotificationsByIssueId";

        //Project Notification
        private const string SP_PROJECTNOTIFICATION_CREATE = "BugNet_ProjectNotification_CreateNewProjectNotification";
        private const string SP_PROJECTNOTIFICATION_DELETE = "BugNet_ProjectNotification_DeleteProjectNotification";
        private const string SP_PROJECTNOTIFICATION_GETPROJECTNOTIFICATIONSBYPROJECTID = "BugNet_ProjectNotification_GetProjectNotificationsByProjectId";
        private const string SP_PROJECTNOTIFICATION_GETPROJECTNOTIFICATIONSBYUSERNAME = "BugNet_ProjectNotification_GetProjectNotificationsByUsername";

        private const string SP_HOSTSETTING_GETHOSTSETTINGS = "BugNet_HostSetting_GetHostSettings";
        private const string SP_HOSTSETTING_UPDATEHOSTSETTING = "BugNet_HostSetting_UpdateHostSetting";

        private const string SP_ISSUEWORKREPORT_CREATE = "BugNet_IssueWorkReport_CreateNewIssueWorkReport";
        private const string SP_ISSUEWORKREPORT_DELETE = "BugNet_IssueWorkReport_DeleteIssueWorkReport";
        private const string SP_ISSUEWORKREPORT_GETBYISSUEWORKREPORTSBYISSUEID = "BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId";
        private const string SP_ISSUEWORKREPORT_GETISSUEWORKREPORTBYPROJECTID = "BugNet_IssueWorkReport_GetIssueWorkReportByProjectId";
        private const string SP_ISSUEWORKREPORT_GETISSUEWORKREPORTBYPROJECTMEMBER = "BugNet_TimeEntry_GetProjectWorkerWorkReport";

        private const string SP_APPLICATIONLOG_GETLOG = "BugNet_ApplicationLog_GetLog";
        private const string SP_APPLICATIONLOG_CLEARLOG = "BugNet_ApplicationLog_ClearLog";

        private const string SP_CUSTOMFIELD_GETCUSTOMFIELDBYID = "BugNet_ProjectCustomField_GetCustomFieldById";
        private const string SP_CUSTOMFIELD_GETCUSTOMFIELDSBYPROJECTID = "BugNet_ProjectCustomField_GetCustomFieldsByProjectId";
        private const string SP_CUSTOMFIELD_GETCUSTOMFIELDSBYISSUEID = "BugNet_ProjectCustomField_GetCustomFieldsByIssueId";
        private const string SP_CUSTOMFIELD_CREATE = "BugNet_ProjectCustomField_CreateNewCustomField";
        private const string SP_CUSTOMFIELD_UPDATE = "BugNet_ProjectCustomField_UpdateCustomField";
        private const string SP_CUSTOMFIELD_DELETE = "BugNet_ProjectCustomField_DeleteCustomField";
        private const string SP_CUSTOMFIELD_SAVECUSTOMFIELDVALUE = "BugNet_ProjectCustomField_SaveCustomFieldValue";

        private const string SP_CUSTOMFIELDSELECTION_CREATE = "BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection";
        private const string SP_CUSTOMFIELDSELECTION_DELETE = "BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection";
        private const string SP_CUSTOMFIELDSELECTION_GETCUSTOMFIELDSELECTIONSBYCUSTOMFIELDID = "BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId";
        private const string SP_CUSTOMFIELDSELECTION_GETCUSTOMFIELDSELECTIONBYID = "BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById";
        private const string SP_CUSTOMFIELDSELECTION_UPDATE = "BugNet_ProjectCustomFieldSelection_Update";
        //private const string SP_CUSTOMFIELDSELECTION_GETCUSTOMFIELDSELECTION = "BugNet_ProjectCustomFieldSelection_GetCustomFieldSelection";

        private const string SP_REQUIREDFIELDS_GETFIELDLIST = "BugNet_RequiredField_GetRequiredFieldListForIssues";
        private const string SP_ISSUE_BYPROJECTIDANDCUSTOMFIELDVIEW = "BugNet_GetIssuesByProjectIdAndCustomFieldView";

        //String Resources
        private const string SP_LANGUAGES_GETINSTALLEDLANGUAGES = "BugNet_Languages_GetInstalledLanguages";

        private const string SP_GETSELECTEDISSUECOLUMNS = "BugNet_GetProjectSelectedColumnsWithUserIdAndProjectId";
        private const string SP_SETSELECTEDISSUECOLUMNS = "BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId";
        #endregion

        /// <summary>
        /// Gets a value indicating whether [supports project cloning].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [supports project cloning]; otherwise, <c>false</c>.
        /// </value>
        public override bool SupportsProjectCloning
        {
            get { return true; }
        }

        #region Issue methods
        /// <summary>
        /// Deletes the issue.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override bool DeleteIssue(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            try
            {
                using(var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issues by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByProjectId(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESBYPROJECTID);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;
            }
        }

        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override Issue GetIssueById(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEBYID);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList.Count > 0 ? issueList[0] : null;  
            }
        }

        /// <summary>
        /// Updates the issue.
        /// </summary>
        /// <param name="issueToUpdate">The issue to update.</param>
        /// <returns></returns>
        public override bool UpdateIssue(Issue issueToUpdate)
        {
            if (issueToUpdate == null) throw (new ArgumentNullException("issueToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, issueToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@IssueTitle", SqlDbType.NVarChar, 500, ParameterDirection.Input, issueToUpdate.Title);
                AddParamToSqlCmd(sqlCmd, "@IssueCategoryId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.CategoryId == 0) ? DBNull.Value : (object)issueToUpdate.CategoryId);
                AddParamToSqlCmd(sqlCmd, "@IssueStatusId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.StatusId == 0) ? DBNull.Value : (object)issueToUpdate.StatusId);
                AddParamToSqlCmd(sqlCmd, "@IssuePriorityId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.PriorityId == 0) ? DBNull.Value : (object)issueToUpdate.PriorityId);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, issueToUpdate.IssueTypeId == 0 ? DBNull.Value : (object)issueToUpdate.IssueTypeId);
                AddParamToSqlCmd(sqlCmd, "@IssueResolutionId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.ResolutionId == 0) ? DBNull.Value : (object)issueToUpdate.ResolutionId);
                AddParamToSqlCmd(sqlCmd, "@IssueMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.MilestoneId == 0) ? DBNull.Value : (object)issueToUpdate.MilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueAffectedMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, (issueToUpdate.AffectedMilestoneId == 0) ? DBNull.Value : (object)issueToUpdate.AffectedMilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueAssignedUserName", SqlDbType.NText, 255, ParameterDirection.Input, (issueToUpdate.AssignedUserName == string.Empty) ? DBNull.Value : (object)issueToUpdate.AssignedUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueOwnerUserName", SqlDbType.NText, 255, ParameterDirection.Input, (issueToUpdate.OwnerUserName == string.Empty) ? DBNull.Value : (object)issueToUpdate.OwnerUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueCreatorUserName", SqlDbType.NText, 255, ParameterDirection.Input, issueToUpdate.CreatorUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueDueDate", SqlDbType.DateTime, 0, ParameterDirection.Input, (issueToUpdate.DueDate == DateTime.MinValue) ? DBNull.Value : (object)issueToUpdate.DueDate);
                AddParamToSqlCmd(sqlCmd, "@IssueEstimation", SqlDbType.Decimal, 0, ParameterDirection.Input, issueToUpdate.Estimation);
                AddParamToSqlCmd(sqlCmd, "@IssueVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, issueToUpdate.Visibility);
                AddParamToSqlCmd(sqlCmd, "@IssueDescription", SqlDbType.NText, 0, ParameterDirection.Input, issueToUpdate.Description);
                AddParamToSqlCmd(sqlCmd, "@IssueProgress", SqlDbType.Int, 0, ParameterDirection.Input, issueToUpdate.Progress);
                AddParamToSqlCmd(sqlCmd, "@LastUpdateUserName", SqlDbType.NText, 255, ParameterDirection.Input, issueToUpdate.LastUpdateUserName);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Creates the new issue.
        /// </summary>
        /// <param name="newIssue">The issue to create.</param>
        /// <returns></returns>
        public override int CreateNewIssue(Issue newIssue)
        {
            // Validate Parameters
            if (newIssue == null) throw (new ArgumentNullException("newIssue"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newIssue.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@IssueTitle", SqlDbType.NVarChar, 255, ParameterDirection.Input, newIssue.Title);
                AddParamToSqlCmd(sqlCmd, "@IssueDescription", SqlDbType.NVarChar, 0, ParameterDirection.Input, newIssue.Description);
                AddParamToSqlCmd(sqlCmd, "@IssueCategoryId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.CategoryId == 0) ? DBNull.Value : (object)newIssue.CategoryId);
                AddParamToSqlCmd(sqlCmd, "@IssueStatusId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.StatusId == 0) ? DBNull.Value : (object)newIssue.StatusId);
                AddParamToSqlCmd(sqlCmd, "@IssuePriorityId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.PriorityId == 0) ? DBNull.Value : (object)newIssue.PriorityId);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.IssueTypeId == 0) ? DBNull.Value : (object)newIssue.IssueTypeId);
                AddParamToSqlCmd(sqlCmd, "@IssueResolutionId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.ResolutionId == 0) ? DBNull.Value : (object)newIssue.ResolutionId);
                AddParamToSqlCmd(sqlCmd, "@IssueMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.MilestoneId == 0) ? DBNull.Value : (object)newIssue.MilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueAffectedMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, (newIssue.AffectedMilestoneId == 0) ? DBNull.Value : (object)newIssue.AffectedMilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueAssignedUserName", SqlDbType.NText, 255, ParameterDirection.Input, (newIssue.AssignedUserName == string.Empty) ? DBNull.Value : (object)newIssue.AssignedUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueOwnerUserName", SqlDbType.NText, 255, ParameterDirection.Input, (newIssue.OwnerUserName == string.Empty) ? DBNull.Value : (object)newIssue.OwnerUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueCreatorUserName", SqlDbType.NText, 255, ParameterDirection.Input, newIssue.CreatorUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueDueDate", SqlDbType.DateTime, 0, ParameterDirection.Input, (newIssue.DueDate == DateTime.MinValue) ? DBNull.Value : (object)newIssue.DueDate);
                AddParamToSqlCmd(sqlCmd, "@IssueEstimation", SqlDbType.Decimal, 0, ParameterDirection.Input, newIssue.Estimation);
                AddParamToSqlCmd(sqlCmd, "@IssueVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, newIssue.Visibility);
                AddParamToSqlCmd(sqlCmd, "@IssueProgress", SqlDbType.Int, 0, ParameterDirection.Input, newIssue.Progress);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Gets the issues by relevancy.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="userName">The userName.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByRelevancy(int projectId, string userName)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESBYRELEVANCY);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the name of the issues by assigned user.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="assignedUserName">Name of the assigned user.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByAssignedUserName(int projectId, string assignedUserName)
        {
            if (assignedUserName == null) throw (new ArgumentNullException("assignedUserName"));
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, assignedUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESBYASSIGNEDUSERNAME);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the open issues.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Issue> GetOpenIssues(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETOPENISSUES);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the name of the issues by creator user.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByCreatorUserName(int projectId, string userName)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESBYCREATORUSERNAME);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the name of the issues by owner user.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByOwnerUserName(int projectId, string userName)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESBYOWNERUSERNAME);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the name of the monitored issues by user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="excludeClosedStatus">if set to <c>true</c> [exclude closed status].</param>
        /// <returns></returns>
        public override List<Issue> GetMonitoredIssuesByUserName(string userName, bool excludeClosedStatus)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ExcludeClosedStatus", SqlDbType.Bit, 0, ParameterDirection.Input, excludeClosedStatus);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETMONITOREDISSUESBYUSERNAME);

                var issueList = new List<Issue>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;   
            }
        }

        /// <summary>
        /// Gets the issue status count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueCount> GetIssueStatusCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUESTATUSCOUNTBYPROJECT);
                    var issueCountList = new List<IssueCount>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCountListFromReader, ref issueCountList);
                    return issueCountList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueCount> GetIssueMilestoneCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEMILESTONECOUNTBYPROJECT);
                    var issueCountList = new List<IssueCount>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCountListFromReader, ref issueCountList);
                    return issueCountList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue user count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueCount> GetIssueUserCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEUSERCOUNTBYPROJECT);
                    var issueCountList = new List<IssueCount>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCountListFromReader, ref issueCountList);
                    return issueCountList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue unassigned count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override int GetIssueUnassignedCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEUNASSIGNEDCOUNTBYPROJECT);
                    return (int)ExecuteScalarCmd(sqlCmd);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }

        /// <summary>
        /// Gets the issue unscheduled milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override int GetIssueUnscheduledMilestoneCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEUNSCHEDULEDMILESTONECOUNTBYPROJECT);
                    return (int)ExecuteScalarCmd(sqlCmd);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue count by project and category.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public override int GetIssueCountByProjectAndCategory(int projectId, int categoryId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    if (categoryId == 0)
                        AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, DBNull.Value);
                    else
                        AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, categoryId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUECATEGORYCOUNTBYPROJECT);
                    return (int)ExecuteScalarCmd(sqlCmd);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue type count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueCount> GetIssueTypeCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUETYPECOUNTBYPROJECT);
                    var issueCountList = new List<IssueCount>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCountListFromReader, ref issueCountList);
                    return issueCountList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue priority count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueCount> GetIssuePriorityCountByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_GETISSUEPRIORITYCOUNTBYPROJECT);
                    var issueCountList = new List<IssueCount>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCountListFromReader, ref issueCountList);
                    return issueCountList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        #endregion

        /// <summary>
        /// Gets the issue columns for a user for a specific project
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override string GetSelectedIssueColumnsByUserName(string userName, int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentNullException("projectId"));
            if (string.IsNullOrEmpty(userName))
                throw (new ArgumentNullException("userName"));
            try
            {
                // Execute SQL Command
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_GETSELECTEDISSUECOLUMNS);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.NVarChar, 255, ParameterDirection.Output, null);

                ExecuteScalarCmd(sqlCmd);
                return ((string)sqlCmd.Parameters["@ReturnValue"].Value.ToString());
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }


        /// <summary>
        /// Sets the issue columns for a user for a specific project
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="columns">The columns selected to be displayed for specific project.</param>
        /// <returns></returns>
        public override void SetSelectedIssueColumnsByUserName(string userName, int projectId, string columns)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentNullException("projectId"));
            if (string.IsNullOrEmpty(userName))
                throw (new ArgumentNullException("userName"));
            if (string.IsNullOrEmpty(columns))
                columns = "";
            try
            {
                // Execute SQL Command
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_SETSELECTEDISSUECOLUMNS);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@Columns", SqlDbType.NVarChar, 255, ParameterDirection.Input, columns);

                ExecuteScalarCmd(sqlCmd);
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        #region Issue history methods
        /// <summary>
        /// Creates the new issue history.
        /// </summary>
        /// <param name="newHistory">The new history.</param>
        /// <returns></returns>
        public override int CreateNewIssueHistory(IssueHistory newHistory)
        {
            // Validate Parameters
            if (newHistory == null) throw (new ArgumentNullException("newHistory"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newHistory.IssueId);
                AddParamToSqlCmd(sqlCmd, "@CreatedUserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, newHistory.CreatedUserName);
                AddParamToSqlCmd(sqlCmd, "@FieldChanged", SqlDbType.NVarChar, 50, ParameterDirection.Input, newHistory.FieldChanged);
                AddParamToSqlCmd(sqlCmd, "@OldValue", SqlDbType.NVarChar, 50, ParameterDirection.Input, newHistory.OldValue);
                AddParamToSqlCmd(sqlCmd, "@NewValue", SqlDbType.NVarChar, 50, ParameterDirection.Input, newHistory.NewValue);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEHISTORY_CREATENEWISSUEHISTORY);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Gets the issue history by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueHistory> GetIssueHistoryByIssueId(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEHISTORY_GETISSUEHISTORYBYISSUEID);

                var issueHistoryList = new List<IssueHistory>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueHistoryListFromReader, ref issueHistoryList);

                return issueHistoryList;   
            }
        }

        #endregion

        #region Issue notification methods
        /// <summary>
        /// Creates the new issue notification.
        /// </summary>
        /// <param name="newNotification">The new notification.</param>
        /// <returns></returns>
        public override int CreateNewIssueNotification(IssueNotification newNotification)
        {
            // Validate Parameters
            if (newNotification == null) throw (new ArgumentNullException("newNotification"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newNotification.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@NotificationUserName", SqlDbType.NText, 255, ParameterDirection.Input, newNotification.NotificationUsername);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUENOTIFICATION_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue notifications by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueNotification> GetIssueNotificationsByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUENOTIFICATION_GETISSUENOTIFICATIONSBYISSUEID);

                var issueNotificationList = new List<IssueNotification>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueNotificationListFromReader, ref issueNotificationList);

                return issueNotificationList;   
            }
        }

        /// <summary>
        /// Deletes the issue notification.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public override bool DeleteIssueNotification(int issueId, string userName)
        {
            // Validate Parameters
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));
            if (userName == String.Empty) throw (new ArgumentOutOfRangeException("userName"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                    AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUENOTIFICATION_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        #region Issue comment methods
        /// <summary>
        /// Creates the new issue comment.
        /// </summary>
        /// <param name="newComment">The new comment.</param>
        /// <returns></returns>
        public override int CreateNewIssueComment(IssueComment newComment)
        {
            // Validate Parameters
            if (newComment == null) throw (new ArgumentNullException("newComment"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newComment.IssueId);
                AddParamToSqlCmd(sqlCmd, "@CreatorUserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, newComment.CreatorUserName);
                AddParamToSqlCmd(sqlCmd, "@Comment", SqlDbType.NText, 0, ParameterDirection.Input, newComment.Comment);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUECOMMENT_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Gets the issue comments by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueComment> GetIssueCommentsByIssueId(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUECOMMENT_GETISSUECOMMENTSBYISSUEID);

                    var issueCommentList = new List<IssueComment>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCommentListFromReader, ref issueCommentList);

                    return issueCommentList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue comment by id.
        /// </summary>
        /// <param name="issueCommentId">The issue comment id.</param>
        /// <returns></returns>
        public override IssueComment GetIssueCommentById(int issueCommentId)
        {
            if (issueCommentId <= 0) throw (new ArgumentOutOfRangeException("issueCommentId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@IssueCommentId", SqlDbType.Int, 0, ParameterDirection.Input, issueCommentId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUECOMMENT_GETISSUECOMMENTBYID);

                    var issueCommentList = new List<IssueComment>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueCommentListFromReader, ref issueCommentList);

                    return issueCommentList.Count > 0 ? issueCommentList[0] : null;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Updates the issue comment.
        /// </summary>
        /// <param name="issueCommentToUpdate">The issue comment to update.</param>
        /// <returns></returns>
        public override bool UpdateIssueComment(IssueComment issueCommentToUpdate)
        {
            // Validate Parameters
            if (issueCommentToUpdate == null) throw (new ArgumentNullException("issueCommentToUpdate"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueCommentId", SqlDbType.Int, 0, ParameterDirection.Input, issueCommentToUpdate.Id);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueCommentToUpdate.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@CreatorUserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, issueCommentToUpdate.CreatorUserName);
                    AddParamToSqlCmd(sqlCmd, "@Comment", SqlDbType.NText, 0, ParameterDirection.Input, issueCommentToUpdate.Comment);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUECOMMENT_UPDATE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the issue comment by id.
        /// </summary>
        /// <param name="commentId">The comment id.</param>
        /// <returns></returns>
        public override bool DeleteIssueCommentById(int commentId)
        {
            if (commentId <= 0) throw new ArgumentOutOfRangeException("commentId");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueCommentId", SqlDbType.Int, 0, ParameterDirection.Input, commentId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUECOMMENT_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        #region Host setting methods
        /// <summary>
        /// Gets the host settings.
        /// </summary>
        /// <returns>A list of host setting objects.</returns>
        public override List<HostSetting> GetHostSettings()
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_HOSTSETTING_GETHOSTSETTINGS);

                var hostSettingList = new List<HostSetting>();
                ExecuteReaderCmd(sqlCmd, GenerateHostSettingListFromReader, ref hostSettingList);

                return hostSettingList;   
            }
        }

        /// <summary>
        /// Updates the host setting.
        /// </summary>
        /// <param name="settingName">Name of the setting.</param>
        /// <param name="settingValue">The setting value.</param>
        /// <returns></returns>
        public override bool UpdateHostSetting(string settingName, string settingValue)
        {
            if (string.IsNullOrEmpty(settingName)) throw new ArgumentNullException("settingName");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@SettingName", SqlDbType.NVarChar, 0, ParameterDirection.Input, settingName);
                AddParamToSqlCmd(sqlCmd, "@SettingValue", SqlDbType.NVarChar, 0, ParameterDirection.Input, settingValue);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_HOSTSETTING_UPDATEHOSTSETTING);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }
        #endregion

        #region Role methods
        /// <summary>
        /// Gets all roles.
        /// </summary>
        /// <returns></returns>
        public override List<Role> GetAllRoles()
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_GETALLROLES);
                var roleList = new List<Role>();
                ExecuteReaderCmd(sqlCmd, GenerateRoleListFromReader, ref roleList);
                return roleList;   
            }
        }

        /// <summary>
        /// Updates the role.
        /// </summary>
        /// <param name="roleToUpdate">The role to update.</param>
        /// <returns></returns>
        public override bool UpdateRole(Role roleToUpdate)
        {
            // Validate Parameters
            if (roleToUpdate == null) throw (new ArgumentNullException("roleToUpdate"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleToUpdate.Id);
                    AddParamToSqlCmd(sqlCmd, "@RoleName", SqlDbType.NText, 256, ParameterDirection.Input, roleToUpdate.Name);
                    AddParamToSqlCmd(sqlCmd, "@RoleDescription", SqlDbType.NText, 1000, ParameterDirection.Input, roleToUpdate.Description);
                    AddParamToSqlCmd(sqlCmd, "@AutoAssign", SqlDbType.Bit, 0, ParameterDirection.Input, roleToUpdate.AutoAssign);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, roleToUpdate.ProjectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_UPDATEROLE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Creates the new role.
        /// </summary>
        /// <param name="newRole">The new role.</param>
        /// <returns></returns>
        public override int CreateNewRole(Role newRole)
        {
            // Validate Parameters
            if (newRole == null) throw (new ArgumentNullException("newRole"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleName", SqlDbType.NText, 256, ParameterDirection.Input, newRole.Name);
                    AddParamToSqlCmd(sqlCmd, "@RoleDescription", SqlDbType.NText, 1000, ParameterDirection.Input, newRole.Description);
                    AddParamToSqlCmd(sqlCmd, "@AutoAssign", SqlDbType.Bit, 0, ParameterDirection.Input, newRole.AutoAssign);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newRole.ProjectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Roles the exists.
        /// </summary>
        /// <param name="roleName">Name of the role.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override bool RoleExists(string roleName, int projectId)
        {
            if (string.IsNullOrEmpty(roleName)) throw new ArgumentNullException("roleName");
            if (projectId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("projectId");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleName", SqlDbType.NText, 256, ParameterDirection.Input, roleName);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_ROLEEXISTS);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 1);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the name of the roles by user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Role> GetRolesByUserName(string userName, int projectId)
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_GETPROJECTROLESBYUSER);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);

                var roleList = new List<Role>();
                ExecuteReaderCmd(sqlCmd, GenerateRoleListFromReader, ref roleList);
                return roleList;   
            }
        }

        /// <summary>
        /// Removes the user from role.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public override bool RemoveUserFromRole(string userName, int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));
            if (string.IsNullOrEmpty(userName)) throw (new ArgumentNullException("userName"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_REMOVEUSERFROMROLE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Adds the user to role.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public override bool AddUserToRole(string userName, int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));
            if (string.IsNullOrEmpty(userName)) throw (new ArgumentNullException("userName"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                    AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_ADDUSERTOROLE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the role.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public override bool DeleteRole(int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_DELETEROLE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the role by id.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public override Role GetRoleById(int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_GETROLEBYID);

                    var roleList = new List<Role>();
                    ExecuteReaderCmd(sqlCmd, GenerateRoleListFromReader, ref roleList);
                    return roleList.Count > 0 ? roleList[0] : null;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the roles by userName.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public override List<Role> GetRolesByUserName(string userName)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_GETROLESBYUSER);

                var roleList = new List<Role>();
                ExecuteReaderCmd(sqlCmd, GenerateRoleListFromReader, ref roleList);

                return roleList;   
            }
        }

        /// <summary>
        /// Gets the roles by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Role> GetRolesByProject(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentNullException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ROLE_GETROLESBYPROJECT);

                var roleList = new List<Role>();
                ExecuteReaderCmd(sqlCmd, GenerateRoleListFromReader, ref roleList);

                return roleList;   
            }
        }

        /// <summary>
        /// Gets all permissions.
        /// </summary>
        /// <returns></returns>
        public override List<Permission> GetAllPermissions()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PERMISSION_GETALLPERMISSIONS);
                    var permissionList = new List<Permission>();
                    ExecuteReaderCmd(sqlCmd, GeneratePermissionListFromReader, ref permissionList);
                    return permissionList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets all role permissions.
        /// </summary>
        /// <returns></returns>
        public override List<RolePermission> GetRolePermissions()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PERMISSION_GETROLEPERMISSIONS);
                    var rolePermissionList = new List<RolePermission>();
                    ExecuteReaderCmd(sqlCmd, GenerateRolePermissionListFromReader, ref rolePermissionList);
                    return rolePermissionList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the permissions by role id.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public override List<Permission> GetPermissionsByRoleId(int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PERMISSION_GETPERMISSIONSBYROLE);
                    var permissionList = new List<Permission>();
                    ExecuteReaderCmd(sqlCmd, GeneratePermissionListFromReader, ref permissionList);
                    return permissionList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the permission.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <param name="permissionId">The permission id.</param>
        /// <returns></returns>
        public override bool DeletePermission(int roleId, int permissionId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));
            if (permissionId <= Globals.NEW_ID) throw (new ArgumentNullException("permissionId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                    AddParamToSqlCmd(sqlCmd, "@PermissionId", SqlDbType.Int, 0, ParameterDirection.Input, permissionId);
                    AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PERMISSION_DELETEROLEPERMISSION);
                    ExecuteScalarCmd(sqlCmd);
                    var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                    return (resultValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Adds the permission.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <param name="permissionId">The permission id.</param>
        /// <returns></returns>
        public override bool AddPermission(int roleId, int permissionId)
        {
            // Validate Parameters
            if (roleId <= Globals.NEW_ID) throw (new ArgumentNullException("roleId"));
            if (permissionId <= Globals.NEW_ID) throw (new ArgumentNullException("permissionId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@RoleId", SqlDbType.Int, 0, ParameterDirection.Input, roleId);
                AddParamToSqlCmd(sqlCmd, "@PermissionId", SqlDbType.Int, 0, ParameterDirection.Input, permissionId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PERMISSION_ADDROLEPERMISSION);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }
        #endregion

        #region User methods
        /// <summary>
        /// Gets the users by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<ITUser> GetUsersByProjectId(int projectId)
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_USER_GETUSERSBYPROJECTID);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                var userList = new List<ITUser>();
                ExecuteReaderCmd(sqlCmd, GenerateUserListFromReader, ref userList);
                return userList;   
            }
        }
        #endregion

        #region Project methods
        /// <summary>
        /// Creates the new project.
        /// </summary>
        /// <param name="newProject">The new project.</param>
        /// <returns></returns>
        public override int CreateNewProject(Project newProject)
        {
            // Validate Parameters
            if (newProject == null) throw (new ArgumentNullException("newProject"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@AllowAttachments", SqlDbType.Bit, 0, ParameterDirection.Input, newProject.AllowAttachments);
                //AddParamToSQLCmd(sqlCmd, "@Active", SqlDbType.Bit, 0, ParameterDirection.Input, newProject.Active);
                AddParamToSqlCmd(sqlCmd, "@ProjectName", SqlDbType.NText, 256, ParameterDirection.Input, newProject.Name);
                AddParamToSqlCmd(sqlCmd, "@ProjectDescription", SqlDbType.NText, 1000, ParameterDirection.Input, newProject.Description);
                AddParamToSqlCmd(sqlCmd, "@ProjectManagerUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, newProject.ManagerUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectCreatorUserName", SqlDbType.NText, 255, ParameterDirection.Input, newProject.CreatorUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectAccessType", SqlDbType.Int, 0, ParameterDirection.Input, newProject.AccessType);
                AddParamToSqlCmd(sqlCmd, "@AttachmentUploadPath", SqlDbType.NVarChar, 80, ParameterDirection.Input, newProject.UploadPath);
                AddParamToSqlCmd(sqlCmd, "@ProjectCode", SqlDbType.NVarChar, 80, ParameterDirection.Input, newProject.Code);
                AddParamToSqlCmd(sqlCmd, "@AttachmentStorageType", SqlDbType.Int, 1, ParameterDirection.Input, newProject.AttachmentStorageType);
                AddParamToSqlCmd(sqlCmd, "@SvnRepositoryUrl", SqlDbType.NVarChar, 0, ParameterDirection.Input, newProject.SvnRepositoryUrl);
                AddParamToSqlCmd(sqlCmd, "@AllowIssueVoting", SqlDbType.Bit, 0, ParameterDirection.Input, newProject.AllowIssueVoting);
                if (newProject.Image != null)
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileContent", SqlDbType.Binary, 0, ParameterDirection.Input, newProject.Image.ImageContent);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileName", SqlDbType.NVarChar, 150, ParameterDirection.Input, newProject.Image.ImageFileName);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageContentType", SqlDbType.NVarChar, 50, ParameterDirection.Input, newProject.Image.ImageContentType);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileSize", SqlDbType.BigInt, 0, ParameterDirection.Input, newProject.Image.ImageFileLength);
                }
                else
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileContent", SqlDbType.Binary, 0, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileName", SqlDbType.NVarChar, 150, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageContentType", SqlDbType.NVarChar, 50, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileSize", SqlDbType.BigInt, 0, ParameterDirection.Input, DBNull.Value);
                }

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override bool DeleteProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectID"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Gets all projects.
        /// </summary>
        /// <returns></returns>
        public override List<Project> GetAllProjects()
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETALLPROJECTS);

                var projectList = new List<Project>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectListFromReader, ref projectList);

                return projectList;   
            }
        }

        /// <summary>
        /// Gets the project by id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override Project GetProjectById(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentNullException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETPROJECTBYID);

                var projectList = new List<Project>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectListFromReader, ref projectList);

                return projectList.Count > 0 ? projectList[0] : null;   
            }
        }

        /// <summary>
        /// Gets the name of the projects by member user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public override List<Project> GetProjectsByMemberUserName(string userName)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));

            return GetProjectsByMemberUserName(userName, true);
        }

        /// <summary>
        /// Gets the projects by member userName.
        /// </summary>
        /// <param name="userName">The userName.</param>
        /// <param name="activeOnly">if set to <c>true</c> [active only].</param>
        /// <returns></returns>
        public override List<Project> GetProjectsByMemberUserName(string userName, bool activeOnly)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);
                    AddParamToSqlCmd(sqlCmd, "@ActiveOnly", SqlDbType.Bit, 0, ParameterDirection.Input, activeOnly);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETPROJECTSBYMEMBERUSERNAME);

                    var projectList = new List<Project>();
                    ExecuteReaderCmd(sqlCmd, GenerateProjectListFromReader, ref projectList);

                    return projectList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Updates the project.
        /// </summary>
        /// <param name="projectToUpdate">The project to update.</param>
        /// <returns></returns>
        public override bool UpdateProject(Project projectToUpdate)
        {
            if (projectToUpdate == null) throw (new ArgumentNullException("projectToUpdate"));
            if (projectToUpdate.Id <= 0) throw (new ArgumentOutOfRangeException("projectToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@AllowAttachments", SqlDbType.Bit, 0, ParameterDirection.Input, projectToUpdate.AllowAttachments);
                AddParamToSqlCmd(sqlCmd, "@ProjectDisabled", SqlDbType.Bit, 0, ParameterDirection.Input, projectToUpdate.Disabled);
                AddParamToSqlCmd(sqlCmd, "@ProjectName", SqlDbType.NText, 256, ParameterDirection.Input, projectToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@ProjectDescription", SqlDbType.NText, 1000, ParameterDirection.Input, projectToUpdate.Description);
                AddParamToSqlCmd(sqlCmd, "@ProjectManagerUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, projectToUpdate.ManagerUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectAccessType", SqlDbType.Int, 0, ParameterDirection.Input, projectToUpdate.AccessType);
                AddParamToSqlCmd(sqlCmd, "@AttachmentUploadPath", SqlDbType.NVarChar, 80, ParameterDirection.Input, projectToUpdate.UploadPath);
                AddParamToSqlCmd(sqlCmd, "@ProjectCode", SqlDbType.NVarChar, 80, ParameterDirection.Input, projectToUpdate.Code);
                AddParamToSqlCmd(sqlCmd, "@AttachmentStorageType", SqlDbType.Int, 1, ParameterDirection.Input, projectToUpdate.AttachmentStorageType);
                AddParamToSqlCmd(sqlCmd, "@SvnRepositoryUrl", SqlDbType.NVarChar, 0, ParameterDirection.Input, projectToUpdate.SvnRepositoryUrl);
                AddParamToSqlCmd(sqlCmd, "@AllowIssueVoting", SqlDbType.Bit, 0, ParameterDirection.Input, projectToUpdate.AllowIssueVoting);
                if (projectToUpdate.Image == null)
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileContent", SqlDbType.Binary, 0, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileName", SqlDbType.NVarChar, 150, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageContentType", SqlDbType.NVarChar, 50, ParameterDirection.Input, DBNull.Value);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileSize", SqlDbType.BigInt, 0, ParameterDirection.Input, DBNull.Value);
                }
                else
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileContent", SqlDbType.Binary, 0, ParameterDirection.Input, projectToUpdate.Image.ImageContent);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileName", SqlDbType.NVarChar, 150, ParameterDirection.Input, projectToUpdate.Image.ImageFileName);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageContentType", SqlDbType.NVarChar, 50, ParameterDirection.Input, projectToUpdate.Image.ImageContentType);
                    AddParamToSqlCmd(sqlCmd, "@ProjectImageFileSize", SqlDbType.BigInt, 0, ParameterDirection.Input, projectToUpdate.Image.ImageFileLength);
                }

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Adds the user to project.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override bool AddUserToProject(string userName, int projectId)
        {
            if (string.IsNullOrEmpty(userName)) throw new ArgumentNullException("userName");
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NText, 256, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_ADDUSERTOPROJECT);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Removes the user from project.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override bool RemoveUserFromProject(string userName, int projectId)
        {
            if (string.IsNullOrEmpty(userName)) throw new ArgumentNullException("userName");
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NText, 256, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_REMOVEUSERFROMPROJECT);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Clones the project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="projectName">Name of the project.</param>
        /// <returns></returns>
        public override int CloneProject(int projectId, string projectName)
        {
            if (string.IsNullOrEmpty(projectName)) throw new ArgumentNullException("projectName");
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectName", SqlDbType.NText, 256, ParameterDirection.Input, projectName);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_CLONEPROJECT);
                    ExecuteScalarCmd(sqlCmd);
                    return (int)sqlCmd.Parameters["@ReturnValue"].Value;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the project by code.
        /// </summary>
        /// <param name="projectCode">The project code.</param>
        /// <returns></returns>
        public override Project GetProjectByCode(string projectCode)
        {
            if (projectCode == null) throw (new ArgumentNullException("projectCode"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectCode", SqlDbType.NVarChar, 0, ParameterDirection.Input, projectCode);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETPROJECTBYCODE);
                    var projectList = new List<Project>();
                    ExecuteReaderCmd(sqlCmd, GenerateProjectListFromReader, ref projectList);
                    return projectList.Count > 0 ? projectList[0] : null;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the public projects.
        /// </summary>
        /// <returns></returns>
        public override List<Project> GetPublicProjects()
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETPUBLICPROJECTS);

                var projectList = new List<Project>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectListFromReader, ref projectList);

                return projectList;   
            }
        }

        /// <summary>
        /// Determines whether [is user project member] [the specified user name].
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns>
        /// 	<c>true</c> if [is user project member] [the specified user name]; otherwise, <c>false</c>.
        /// </returns>
        public override bool IsUserProjectMember(string userName, int projectId)
        {
            if (userName == null) throw (new ArgumentNullException("userName"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_ISUSERPROJECTMEMBER);
                ExecuteScalarCmd(sqlCmd);

                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Deletes the project image.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override bool DeleteProjectImage(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    const string commandText = "UPDATE BugNet_Projects SET ProjectImageFileContent = NULL, ProjectImageFileName = NULL, ProjectImageContentType = NULL, ProjectImageFileSize = NULL WHERE ProjectId = @ProjectId";

                    SetCommandType(sqlCmd, CommandType.Text, commandText);
                    int retVal;

                    using (var cn = new SqlConnection(_connectionString))
                    {
                        sqlCmd.Connection = cn;
                        cn.Open();
                        retVal = sqlCmd.ExecuteNonQuery();
                    }

                    return retVal != 0;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }


        /// <summary>
        /// Gets the project image by id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override ProjectImage GetProjectImageById(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    sqlCmd.CommandText = "SELECT [ProjectId], [ProjectImageFileContent],[ProjectImageFileName],[ProjectImageContentType],[ProjectImageFileSize] FROM BugNet_Projects WHERE ProjectId = @ProjectId";

                    ProjectImage projectImage = null;

                    using (var cn = new SqlConnection(_connectionString))
                    {
                        sqlCmd.Connection = cn;
                        cn.Open();
                        using (var dtr = sqlCmd.ExecuteReader())
                        {
                            if (dtr.Read())
                            {
                                byte[] attachmentData;

                                if (dtr["ProjectImageFileContent"] != DBNull.Value)
                                    attachmentData = (byte[])dtr["ProjectImageFileContent"];
                                else
                                    return null;

                                projectImage = new ProjectImage((int)dtr["ProjectId"], attachmentData, (string)dtr["ProjectImageFileName"], (long)dtr["ProjectImageFileSize"], (string)dtr["ProjectImageContentType"]);

                            }   
                        }
                    }

                    return projectImage;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets all users and roles by project Id
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns>Generic list of username strings and role strings</returns>
        public override List<MemberRoles> GetProjectMembersRoles(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETMEMBERROLESBYPROJECTID);
                    var projectMemberRoleList = new List<MemberRoles>();
                    ExecuteReaderCmd(sqlCmd, GenerateProjectMemberRoleListFromReader, ref projectMemberRoleList);
                    return projectMemberRoleList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the project roadmap.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<RoadMapIssue> GetProjectRoadmap(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETROADMAP);
                    var issueList = new List<RoadMapIssue>();
                    ExecuteReaderCmd(sqlCmd, GenerateRoadmapIssueListFromReader, ref issueList);
                    return issueList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }


        /// <summary>
        /// Gets the project roadmap progress.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <returns></returns>
        public override int[] GetProjectRoadmapProgress(int projectId, int milestoneId)
        {
            if (projectId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("projectId");
            if (milestoneId < -1) throw new ArgumentOutOfRangeException("milestoneId");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETROADMAPPROGRESS);

                    using (var cn = new SqlConnection(_connectionString))
                    {
                        sqlCmd.Connection = cn;
                        cn.Open();

                        using(var returnData = sqlCmd.ExecuteReader())
                        {
                            var values = new int[2];
                            while (returnData.Read())
                            {
                                values[0] = (int)returnData["ClosedCount"];
                                values[1] = (int)returnData["TotalCount"];
                            }
                            return values;   
                        }
                    }   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }


        /// <summary>
        /// Gets the project change log.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Issue> GetProjectChangeLog(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECT_GETCHANGELOG);
                    var issueList = new List<Issue>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);
                    return issueList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        #region Project notification methods
        /// <summary>
        /// Creates the new project notification.
        /// </summary>
        /// <param name="newProjectNotification">The new project notification.</param>
        /// <returns></returns>
        public override int CreateNewProjectNotification(ProjectNotification newProjectNotification)
        {
            // Validate Parameters
            if (newProjectNotification == null) throw (new ArgumentNullException("newProjectNotification"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newProjectNotification.ProjectId);
                    AddParamToSqlCmd(sqlCmd, "@NotificationUserName", SqlDbType.NText, 255, ParameterDirection.Input, newProjectNotification.NotificationUsername);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTNOTIFICATION_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the project notifications by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<ProjectNotification> GetProjectNotificationsByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTNOTIFICATION_GETPROJECTNOTIFICATIONSBYPROJECTID);

                var projectNotificationList = new List<ProjectNotification>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectNotificationListFromReader, ref projectNotificationList);

                return projectNotificationList;   
            }
        }

        /// <summary>
        /// Deletes the project notification.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public override bool DeleteProjectNotification(int projectId, string username)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (username == String.Empty) throw (new ArgumentOutOfRangeException("username"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, username);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTNOTIFICATION_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the project notifications by username.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public override List<ProjectNotification> GetProjectNotificationsByUsername(string username)
        {
            if (username == String.Empty) throw (new ArgumentOutOfRangeException("username"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@Username", SqlDbType.NVarChar, 255, ParameterDirection.Input, username);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTNOTIFICATION_GETPROJECTNOTIFICATIONSBYUSERNAME);

                var projectNotificationList = new List<ProjectNotification>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectNotificationListFromReader, ref projectNotificationList);

                return projectNotificationList;   
            }
        }
        #endregion

        #region Category methods
        /// <summary>
        /// Creates the new category.
        /// </summary>
        /// <param name="newCategory">The new category.</param>
        /// <returns></returns>
        public override int CreateNewCategory(Category newCategory)
        {
            if (newCategory == null) throw (new ArgumentNullException("newCategory"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newCategory.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@CategoryName", SqlDbType.NText, 255, ParameterDirection.Input, newCategory.Name);
                AddParamToSqlCmd(sqlCmd, "@ParentCategoryId", SqlDbType.Int, 0, ParameterDirection.Input, newCategory.ParentCategoryId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_CREATE);
                ExecuteScalarCmd(sqlCmd);

                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the category.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public override bool DeleteCategory(int categoryId)
        {
            // Validate Parameters
            if (categoryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("categoryId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 4, ParameterDirection.Input, categoryId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Updates the category.
        /// </summary>
        /// <param name="categoryToUpdate">The category to update.</param>
        /// <returns></returns>
        public override bool UpdateCategory(Category categoryToUpdate)
        {
            var sqlCmd = new SqlCommand();

            AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
            AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, categoryToUpdate.Id);
            AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, categoryToUpdate.ProjectId);
            AddParamToSqlCmd(sqlCmd, "@CategoryName", SqlDbType.NText, 255, ParameterDirection.Input, categoryToUpdate.Name);
            AddParamToSqlCmd(sqlCmd, "@ParentCategoryId", SqlDbType.Int, 0, ParameterDirection.Input, categoryToUpdate.ParentCategoryId);

            SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_UPDATE);
            ExecuteScalarCmd(sqlCmd);

            var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
            return (returnValue == 0);
        }

        /// <summary>
        /// Gets the categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Category> GetCategoriesByProjectId(int projectId)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_GETCATEGORIESBYPROJECTID);
                var categoryList = new List<Category>();
                ExecuteReaderCmd(sqlCmd, GenerateCategoryListFromReader, ref categoryList);

                return categoryList;   
            }
        }

        /// <summary>
        /// Gets the root categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Category> GetRootCategoriesByProjectId(int projectId)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_GETROOTCATEGORIESBYPROJECTID);
                var categoryList = new List<Category>();
                ExecuteReaderCmd(sqlCmd, GenerateCategoryListFromReader, ref categoryList);

                return categoryList;   
            }
        }

        /// <summary>
        /// Gets the child categories by category id.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public override List<Category> GetChildCategoriesByCategoryId(int categoryId)
        {
            // Validate Parameters
            if (categoryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("categoryId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, categoryId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_GETCHILDCATEGORIESBYCATEGORYID);
                var categoryList = new List<Category>();
                ExecuteReaderCmd(sqlCmd, GenerateCategoryListFromReader, ref categoryList);

                return categoryList;   
            }
        }

        /// <summary>
        /// Gets the category by id.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public override Category GetCategoryById(int categoryId)
        {
            // Validate Parameters
            if (categoryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("categoryId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, categoryId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CATEGORY_GETCATEGORYBYID);
                var categoryList = new List<Category>();
                ExecuteReaderCmd(sqlCmd, GenerateCategoryListFromReader, ref categoryList);

                return categoryList.Count > 0 ? categoryList[0] : null;   
            }
        }
        #endregion

        #region Issue attachment methods
        /// <summary>
        /// Creates the new issue attachment.
        /// </summary>
        /// <param name="newAttachment">The new attachment.</param>
        /// <returns></returns>
        public override int CreateNewIssueAttachment(IssueAttachment newAttachment)
        {
            // Validate Parameters
            if (newAttachment == null) throw (new ArgumentNullException("newAttachment"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newAttachment.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@CreatorUserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, newAttachment.CreatorUserName);
                    AddParamToSqlCmd(sqlCmd, "@FileName", SqlDbType.NVarChar, 250, ParameterDirection.Input, newAttachment.FileName);
                    AddParamToSqlCmd(sqlCmd, "@FileSize", SqlDbType.Int, 0, ParameterDirection.Input, newAttachment.Size);
                    AddParamToSqlCmd(sqlCmd, "@ContentType", SqlDbType.NVarChar, 80, ParameterDirection.Input, newAttachment.ContentType);
                    AddParamToSqlCmd(sqlCmd, "@Description", SqlDbType.NVarChar, 80, ParameterDirection.Input, newAttachment.Description);
                    if (newAttachment.Attachment != null)
                        AddParamToSqlCmd(sqlCmd, "@Attachment", SqlDbType.Image, newAttachment.Attachment.Length, ParameterDirection.Input, newAttachment.Attachment);
                    else
                        AddParamToSqlCmd(sqlCmd, "@Attachment", SqlDbType.Image, 0, ParameterDirection.Input, DBNull.Value);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEATTACHMENT_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue attachments by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueAttachment> GetIssueAttachmentsByIssueId(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEATTACHMENT_GETATTACHMENTSBYISSUEID);

                var issueAttachmentList = new List<IssueAttachment>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueAttachmentListFromReader, ref issueAttachmentList);

                return issueAttachmentList;   
            }
        }

        /// <summary>
        /// Gets the issue attachment by id.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <returns></returns>
        public override IssueAttachment GetIssueAttachmentById(int attachmentId)
        {
            if (attachmentId <= 0) throw (new ArgumentOutOfRangeException("attachmentId"));

            IssueAttachment attachment = null;

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@IssueAttachmentId", SqlDbType.Int, 0, ParameterDirection.Input, attachmentId);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEATTACHMENT_GETATTACHMENTBYID);

                    // Execute Reader
                    if (_connectionString == string.Empty) throw (new ArgumentException("Connection string cannot be null or empty"));

                    using (var cn = new SqlConnection(_connectionString))
                    {
                        sqlCmd.Connection = cn;
                        cn.Open();
                        using (var rdr = sqlCmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                byte[] attachmentData = null;

                                if (rdr["Attachment"] != DBNull.Value)
                                    attachmentData = (byte[])rdr["Attachment"];

                                attachment = new IssueAttachment
                                {
                                    Id = rdr.GetInt32(rdr.GetOrdinal("IssueAttachmentId")),
                                    Attachment = attachmentData,
                                    Description = rdr.GetString(rdr.GetOrdinal("Description")),
                                    DateCreated = rdr.GetDateTime(rdr.GetOrdinal("DateCreated")),
                                    ContentType = rdr.GetString(rdr.GetOrdinal("ContentType")),
                                    CreatorDisplayName = rdr.GetString(rdr.GetOrdinal("CreatorDisplayName")),
                                    CreatorUserName = rdr.GetString(rdr.GetOrdinal("CreatorUsername")),
                                    FileName = rdr.GetString(rdr.GetOrdinal("FileName")),
                                    IssueId = rdr.GetInt32(rdr.GetOrdinal("IssueId")),
                                    Size = rdr.GetInt32(rdr.GetOrdinal("FileSize"))
                                };
                            }
                        }
                    }   
                }

                return attachment;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the issue attachment.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <returns></returns>
        public override bool DeleteIssueAttachment(int attachmentId)
        {
            if (attachmentId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("attachmentId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueAttachmentId", SqlDbType.Int, 0, ParameterDirection.Input, attachmentId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEATTACHMENT_DELETEATTACHMENT);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        #region Query methods
        /// <summary>
        /// Gets the required fields for issues.
        /// </summary>
        /// <returns></returns>
        public override List<RequiredField> GetRequiredFieldsForIssues()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REQUIREDFIELDS_GETFIELDLIST);
                    var requiredFieldList = new List<RequiredField>();
                    ExecuteReaderCmd(sqlCmd, GenerateRequiredFieldListFromReader, ref requiredFieldList);
                    return requiredFieldList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }

        /// <summary>
        /// Gets the name of the queries by user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Query> GetQueriesByUserName(string userName, int projectId)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETQUERIESBYUSERNAME);
                var queryList = new List<Query>();
                ExecuteReaderCmd(sqlCmd, GenerateQueryListFromReader, ref queryList);
                return queryList;   
            }
        }

        /// <summary>
        /// Saves the query.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryName">Name of the query.</param>
        /// <param name="isPublic"></param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public override bool SaveQuery(string userName, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses)
        {
            if (string.IsNullOrEmpty(queryName)) throw (new ArgumentOutOfRangeException("queryName"));
            if (queryClauses.Count == 0) throw (new ArgumentOutOfRangeException("queryClauses"));

            using (var sqlCmd = new SqlCommand())
            {
                var intPublic = isPublic ? 1 : 0;

                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@Username", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName == string.Empty ? DBNull.Value : (object)userName);
                AddParamToSqlCmd(sqlCmd, "@projectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@QueryName", SqlDbType.NText, 50, ParameterDirection.Input, queryName);
                AddParamToSqlCmd(sqlCmd, "@IsPublic", SqlDbType.Bit, 0, ParameterDirection.Input, intPublic);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_SAVEQUERY);

                // Create Save Query Clause Command
                var cmdClause = new SqlCommand();

                cmdClause.Parameters.Add("@QueryId", SqlDbType.Int);
                cmdClause.Parameters.Add("@BooleanOperator", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@FieldName", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@ComparisonOperator", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@FieldValue", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@DataType", SqlDbType.Int);
                cmdClause.Parameters.Add("@IsCustomField", SqlDbType.Bit);

                SetCommandType(cmdClause, CommandType.StoredProcedure, SP_QUERY_SAVEQUERYCLAUSE);

                ExecuteScalarCmd(sqlCmd);

                var queryId = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                if (queryId == 0)
                    return false;

                // Save Query Clauses
                foreach (var clause in queryClauses)
                {
                    cmdClause.Parameters["@QueryId"].Value = queryId;
                    cmdClause.Parameters["@BooleanOperator"].Value = clause.BooleanOperator;
                    cmdClause.Parameters["@FieldName"].Value = clause.FieldName;
                    cmdClause.Parameters["@ComparisonOperator"].Value = clause.ComparisonOperator;
                    cmdClause.Parameters["@FieldValue"].Value = clause.FieldValue;
                    cmdClause.Parameters["@DataType"].Value = clause.DataType;
                    cmdClause.Parameters["@IsCustomField"].Value = clause.CustomFieldQuery;
                    ExecuteScalarCmd(cmdClause);
                }

                return true;   
            }
        }

        /// <summary>
        /// Updates the query.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryName">Name of the query.</param>
        /// <param name="isPublic">if set to <c>true</c> [is public].</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public override bool UpdateQuery(int queryId, string userName, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses)
        {
            if (queryId <= 0) throw new ArgumentOutOfRangeException("queryId");
            if (string.IsNullOrEmpty(queryName)) throw (new ArgumentOutOfRangeException("queryName"));
            if (queryClauses.Count == 0) throw (new ArgumentOutOfRangeException("queryClauses"));

            using (var sqlCmd = new SqlCommand())
            {
                var intPublic = isPublic ? 1 : 0;

                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);
                AddParamToSqlCmd(sqlCmd, "@Username", SqlDbType.NVarChar, 255, ParameterDirection.Input, userName == string.Empty ? DBNull.Value : (object)userName);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@QueryName", SqlDbType.NText, 50, ParameterDirection.Input, queryName);
                AddParamToSqlCmd(sqlCmd, "@IsPublic", SqlDbType.Bit, 0, ParameterDirection.Input, intPublic);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_UPDATEQUERY);

                // Create Save Query Clause Command
                var cmdClause = new SqlCommand();

                cmdClause.Parameters.Add("@QueryId", SqlDbType.Int);
                cmdClause.Parameters.Add("@BooleanOperator", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@FieldName", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@ComparisonOperator", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@FieldValue", SqlDbType.NVarChar, 50);
                cmdClause.Parameters.Add("@DataType", SqlDbType.Int);
                cmdClause.Parameters.Add("@IsCustomField", SqlDbType.Bit);

                ExecuteScalarCmd(sqlCmd);

                SetCommandType(cmdClause, CommandType.StoredProcedure, SP_QUERY_SAVEQUERYCLAUSE);
                // Save Query Clauses
                foreach (var clause in queryClauses)
                {
                    cmdClause.Parameters["@QueryId"].Value = queryId;
                    cmdClause.Parameters["@BooleanOperator"].Value = clause.BooleanOperator;
                    cmdClause.Parameters["@FieldName"].Value = clause.FieldName;
                    cmdClause.Parameters["@ComparisonOperator"].Value = clause.ComparisonOperator;
                    cmdClause.Parameters["@FieldValue"].Value = clause.FieldValue;
                    cmdClause.Parameters["@DataType"].Value = clause.DataType;
                    cmdClause.Parameters["@IsCustomField"].Value = clause.CustomFieldQuery;
                    ExecuteScalarCmd(cmdClause);
                }

                return true;   
            }
        }

        /// <summary>
        /// Combined Perform Custom Query Method
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public override List<Issue> PerformQuery(int projectId, List<QueryClause> queryClauses)
        {
            // Validate Parameters
            int queryClauseCount;

            //assign the queryClauses Count to our variable and then check the result.
            if ((queryClauseCount = queryClauses.Count) == 0) throw (new ArgumentOutOfRangeException("queryClauses"));

            try
            {
                // Build Command Text
                var commandBuilder = new StringBuilder();
                //'DSS customfields in the same query   
                commandBuilder.Append(projectId != 0
                                          ? "SELECT DISTINCT * FROM BugNet_GetIssuesByProjectIdAndCustomFieldView WHERE ProjectId=@ProjectId AND (Disabled = 0 AND ProjectDisabled = 0) AND IssueId IN (SELECT IssueId FROM BugNet_Issues WHERE 1=1 "
                                          : "SELECT DISTINCT * FROM BugNet_GetIssuesByProjectIdAndCustomFieldView WHERE (Disabled = 0 AND ProjectDisabled = 0) AND IssueId IN (SELECT IssueId FROM BugNet_Issues WHERE 1=1 ");

                var i = 0;

                //RW check for Standard Query
                foreach (var qc in queryClauses)
                {
                    if (!qc.CustomFieldQuery)
                    {
                        if (qc.BooleanOperator.Trim().Equals(")"))
                            commandBuilder.AppendFormat(" {0}", qc.BooleanOperator);
                        else if (string.IsNullOrEmpty(qc.FieldValue))
                        {
                            commandBuilder.AppendFormat(" {0} {1} {2} NULL", qc.BooleanOperator, qc.FieldName, qc.ComparisonOperator);
                        }
                        else if(qc.DataType == SqlDbType.DateTime)
                        {
                            commandBuilder.AppendFormat(" {0} datediff(day, {1}, @p{3}) {2} 0", qc.BooleanOperator, qc.FieldName, qc.ComparisonOperator, i);
                        }
                        else
                        {
                            commandBuilder.AppendFormat(" {0} {1} {2} @p{3}", qc.BooleanOperator, qc.FieldName, qc.ComparisonOperator, i);
                        }
                        i++;
                    }
                    else
                    {
                        //'DSS customfields in the same query
                        commandBuilder.AppendFormat(" {0} {1} {2} {3} {4} @p{5}", qc.BooleanOperator, "CustomFieldName=", "'" + qc.FieldName + "'", " AND CustomFieldValue ", qc.ComparisonOperator, i);
                        i += 1;
                    }
                }
                commandBuilder.Append(") ORDER BY IssueId DESC");

                using (var sqlCmd = new SqlCommand())
                {
                    sqlCmd.CommandText = commandBuilder.ToString();

                    // Build Parameter List
                    if (projectId != 0)
                        sqlCmd.Parameters.Add("@projectId", SqlDbType.Int).Value = projectId;

                    i = 0; //RW counter for parameters

                    //RW loop thru and add non custom field queries parameters.
                    foreach (var qc in queryClauses)
                    {
                        if (!qc.CustomFieldQuery) //RW not a custom field query
                        {
                            //skip if value null
                            if (!string.IsNullOrEmpty(qc.FieldValue))
                            {
                                sqlCmd.Parameters.Add("@p" + i.ToString(), qc.DataType).Value = qc.FieldValue;
                            }
                            i++;
                            //sqlCmd.Parameters.Add("@p" + i.ToString(), qc.DataType).Value = qc.FieldValue;
                            //i++;
                        }
                        else
                        {
                            //DSS customfields in the same query
                            sqlCmd.Parameters.Add("@p" + i.ToString(), qc.DataType).Value = qc.FieldValue;
                            i += 1;
                        }
                    }

                    //RW create a new issue collection here
                    var issueList = new List<Issue>();

                    //more queries, but they are not custom.
                    //So, populate the collection with what we have.
                    if (i > 0 && i <= queryClauseCount)
                    {
                        ExecuteReaderCmd(sqlCmd, GenerateIssueListFromReader, ref issueList);
                    }

                    //return distinct issues
                    var distinctIssueList = issueList.Distinct(new DistinctIssueComparer()).ToList();
                    return distinctIssueList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }

        /// <summary>
        /// Performs the saved query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public override List<Issue> PerformSavedQuery(int projectId, int queryId)
        {
            // Validate Parameters
            if (queryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("queryId"));
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETSAVEDQUERY);

                var queryClauses = new List<QueryClause>();
                ExecuteReaderCmd(sqlCmd, GenerateQueryClauseListFromReader, ref queryClauses);

                return PerformQuery(projectId, queryClauses);   
            }
        }

        /// <summary>
        /// Performs the query against any generic List&lt;T/&gtl;
        /// Added SMOSS 11-May-2009
        /// Modified 13-April-2010
        /// </summary>
        /// <param name="list"></param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <param name="sql"></param>
        /// <param name="orderBy"></param>
        /// <returns></returns>
        public override void PerformGenericQuery<T>(ref List<T> list, List<QueryClause> queryClauses, string sql, string orderBy)
        {
            GenerateListFromReader<T> gcfr = null;

            // ---------------------------------------------------------------
            //
            // The following Regular Expression yields the lines out of this provider file.
            // 
            // TGenerate\w*FromReader\<T\>\(SqlDataReader returnData, ref List\<\w*\> *\w* *\w*\) *
            //            
            //TGenerateIssueCountListFromReader<T>(SqlDataReader returnData, ref List<IssueCount> issueCountList)
            //TGenerateProjectMemberRoleListFromReader<T>(SqlDataReader returnData, ref List<MemberRoles> memberRoleList)
            //TGenerateRolePermissionListFromReader<T>(SqlDataReader returnData, ref List<RolePermission> rolePermissionList)
            //TGeneratePermissionListFromReader<T>(SqlDataReader returnData, ref List<Permission> permissionList)
            //GenerateIssueRevisionListFromReader<T>(SqlDataReader returnData, ref List<IssueRevision> revisionList)
            //TGenerateRequiredFieldListFromReader<T>(SqlDataReader returnData, ref List<RequiredField> requiredFieldList)
            //GenerateCategoryListFromReader<T>(SqlDataReader returnData, ref List<Category> categoryList)
            //GenerateHostSettingListFromReader<T>(SqlDataReader returnData, ref List<HostSetting> hostsettingList)
            //TGenerateProjectListFromReader<T>(SqlDataReader returnData, ref List<Project> projectList)
            //TGenerateApplicationLogListFromReader<T>(SqlDataReader returnData, ref List<ApplicationLog> applicationLogList)
            //GenerateIssueNotificationListFromReader<T>(SqlDataReader returnData, ref List<IssueNotification> issueNotificationList)
            //TGenerateProjectNotificationListFromReader<T>(SqlDataReader returnData, ref List<ProjectNotification> projectNotificationList)
            //GenerateRelatedIssueListFromReader<T>(SqlDataReader returnData, ref List<RelatedIssue> relatedIssueList)
            //TGenerateUserListFromReader<T>(SqlDataReader returnData, ref List<ITUser> userList)
            //TGenerateStatusListFromReader<T>(SqlDataReader returnData, ref List<Status> statusList)
            //GenerateMilestoneListFromReader<T>(SqlDataReader returnData, ref List<Milestone> milestoneList)
            //TGeneratePriorityListFromReader<T>(SqlDataReader returnData, ref List<Priority> priorityList)            
            //TGenerateQueryClauseListFromReader<T>(SqlDataReader returnData, ref List<QueryClause> queryClauseList)
            //TGenerateIssueTimeEntryListFromReader<T>(SqlDataReader returnData, ref List<IssueWorkReport> issueWorkReportList)
            //TGenerateResolutionListFromReader<T>(SqlDataReader returnData, ref List<Resolution> resolutionList)
            //GenerateRoleListFromReader<T>(SqlDataReader returnData, ref List<Role> roleList)
            //TGenerateCustomFieldListFromReader<T>(SqlDataReader returnData, ref List<CustomField> customFieldList)
            //TGenerateCustomFieldSelectionListFromReader<T>(SqlDataReader returnData, ref List<CustomFieldSelection> customFieldSelectionList)
            //GenerateQueryListFromReader<T>(SqlDataReader returnData, ref List<Query> queryList)
            //TGenerateRoadmapIssueListFromReader<T>(SqlDataReader returnData, ref List<RoadMapIssue> issueList)
            //
            // ---------------------------------------------------------------
            var theType = typeof(T);

            // Wont work in a switch statement due to Type

            //if (theType == typeof(ProjectMailbox))
            //{
            //    System.Reflection.MethodInfo mi = this.GetType().GetMethod("GenerateProjectMailboxListFromReader").MakeGenericMethod(new Type[] { typeof(ProjectMailbox) });
            //    gcfr = (TGenerateListFromReader<T>)Delegate.CreateDelegate(typeof(TGenerateListFromReader<ProjectMailbox>), this, mi);
            //}

            if (theType == typeof(IssueHistory))
            {
                var mi = GetType().GetMethod("GenerateIssueHistoryListFromReader").MakeGenericMethod(new[] { typeof(IssueHistory) });
                gcfr = (GenerateListFromReader<T>)Delegate.CreateDelegate(typeof(GenerateListFromReader<IssueHistory>), this, mi);
            }

            //TGenerateIssueTypeListFromReader<T>(SqlDataReader returnData, ref List<IssueType> issueTypeList)
            if (theType == typeof(IssueHistory))
            {
                var mi = GetType().GetMethod("GenerateIssueHistoryListFromReader").MakeGenericMethod(new[] { typeof(IssueHistory) });
                gcfr = (GenerateListFromReader<T>)Delegate.CreateDelegate(typeof(GenerateListFromReader<IssueHistory>), this, mi);
            }

            if (theType == typeof(IssueAttachment))
            {
                var mi = GetType().GetMethod("GenerateIssueAttachmentListFromReader").MakeGenericMethod(new[] { typeof(IssueAttachment) });
                gcfr = (GenerateListFromReader<T>)Delegate.CreateDelegate(typeof(GenerateListFromReader<IssueAttachment>), this, mi);
            }

            if (theType == typeof(Issue))
            {
                var mi = GetType().GetMethod("TGenerateIssueListFromReader").MakeGenericMethod(new[] { typeof(Issue) });
                gcfr = (GenerateListFromReader<T>)Delegate.CreateDelegate(typeof(GenerateListFromReader<Issue>), this, mi);
            }

            if (theType == typeof(IssueComment))
            {
                var mi = GetType().GetMethod("GenerateIssueCommentListFromReader").MakeGenericMethod(new[] { typeof(IssueComment) });
                gcfr = (GenerateListFromReader<T>)Delegate.CreateDelegate(typeof(GenerateListFromReader<IssueComment>), this, mi);
            }

            //assign the queryClauses Count to our variable and then check the result.
            if ((queryClauses.Count) == 0)
                throw (new ArgumentOutOfRangeException("queryClauses", 0, "queryClauses == 0"));

            // Build Command Text
            var commandBuilder = new StringBuilder();
            commandBuilder.Append(sql);

            var i = 0;

            //RW check for Standard Query
            foreach (var qc in queryClauses.Where(qc => !qc.CustomFieldQuery))
            {
                // if Field Value is null or empty do a null comparision
                // But only if the operator is not blank
                // "William Highfield" Method
                if (string.IsNullOrEmpty(qc.FieldValue))
                {
                    commandBuilder.AppendFormat(
                        !string.IsNullOrEmpty(qc.ComparisonOperator) ? " {0} {1} {2} NULL" : " {0} {1} {2}",
                        qc.BooleanOperator, qc.FieldName, qc.ComparisonOperator);
                }
                else
                {
                    commandBuilder.AppendFormat(" {0} {1} {2} @p{3}", qc.BooleanOperator, qc.FieldName, qc.ComparisonOperator, i);
                }
                i++;
            }

            commandBuilder.Append(orderBy);

            using (var sqlCmd = new SqlCommand())
            {
                sqlCmd.CommandText = commandBuilder.ToString();

                // Build Parameter List
                //  sqlCmd.Parameters.Add("@projectId", SqlDbType.Int).Value = projectId;
                i = 0; //RW counter for parameters			

                //RW loop thru and add non custom field queries parameters.
                foreach (var qc in queryClauses)
                {
                    if (qc.CustomFieldQuery) continue;

                    //skip if value null
                    if (!string.IsNullOrEmpty(qc.FieldValue))
                    {
                        sqlCmd.Parameters.Add("@p" + i, qc.DataType).Value = qc.FieldValue;
                    }
                    i++;
                }

                if (gcfr != null)
                {
                    ExecuteReaderCmd(sqlCmd, gcfr, ref list);
                    //note we are passing this methods objects by reference because we want
                    //the collection to be added to. If we don't pass by reference, we lose the collection
                    //when the method returns.
                }   
            }
        } //end PerformGenericQuery

        /// <summary>
        /// Deletes the query.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public override bool DeleteQuery(int queryId)
        {
            if (queryId <= 0) throw new ArgumentOutOfRangeException("queryId");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_DELETEQUERY);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the query clauses by query id.
        /// </summary>
        /// <returns></returns>
        public override List<QueryClause> GetQueryClausesByQueryId(int queryId)
        {
            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETSAVEDQUERY);

                var queryClauses = new List<QueryClause>();
                ExecuteReaderCmd(sqlCmd, GenerateQueryClauseListFromReader, ref queryClauses);
                return queryClauses;   
            }
        }

        /// <summary>
        /// Gets the query by id.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public override Query GetQueryById(int queryId)
        {
            // Validate Parameters
            if (queryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("queryId"));

            Query query;

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETQUERYBYID);

                var queryList = new List<Query>();
                ExecuteReaderCmd(sqlCmd, GenerateQueryListFromReader, ref queryList);

                query = queryList[0];

                if(query != null) query.Clauses = new List<QueryClause>();
            }

            if (query != null)
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETSAVEDQUERY);

                    var queryClauses = new List<QueryClause>();
                    ExecuteReaderCmd(sqlCmd, GenerateQueryClauseListFromReader, ref queryClauses);
                    query.Clauses = queryClauses;
                }   
            }

            return query;
        }
        #endregion

        #region Related issue methods

        /// <summary>
        /// Gets the child issues.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<RelatedIssue> GetChildIssues(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_GETCHILDISSUES);

                var relatedIssueList = new List<RelatedIssue>();
                ExecuteReaderCmd(sqlCmd, GenerateRelatedIssueListFromReader, ref relatedIssueList);

                return relatedIssueList;   
            }
        }

        /// <summary>
        /// Gets the parent issues.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<RelatedIssue> GetParentIssues(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_GETPARENTISSUES);

                var relatedIssueList = new List<RelatedIssue>();
                ExecuteReaderCmd(sqlCmd, GenerateRelatedIssueListFromReader, ref relatedIssueList);

                return relatedIssueList;   
            }
        }

        /// <summary>
        /// Gets the related issues.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<RelatedIssue> GetRelatedIssues(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.Related);
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_GETRELATEDISSUES);

                    var relatedIssueList = new List<RelatedIssue>();
                    ExecuteReaderCmd(sqlCmd, GenerateRelatedIssueListFromReader, ref relatedIssueList);

                    return relatedIssueList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Creates the new child issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override int CreateNewChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_CREATENEWCHILDISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the child issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override bool DeleteChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_DELETECHILDISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Creates the new parent issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override int CreateNewParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_CREATENEWPARENTISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the parent issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override bool DeleteParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.ParentChild);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_DELETEPARENTISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Creates the new related issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override int CreateNewRelatedIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.Related);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_CREATENEWRELATEDISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the related issue.
        /// </summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public override bool DeleteRelatedIssue(int primaryIssueId, int secondaryIssueId)
        {
            // Validate Parameters
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@PrimaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, primaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@SecondaryIssueId", SqlDbType.Int, 0, ParameterDirection.Input, secondaryIssueId);
                    AddParamToSqlCmd(sqlCmd, "@RelationType", SqlDbType.Int, 0, ParameterDirection.Input, IssueRelationTypes.Related);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RELATEDISSUE_DELETERELATEDISSUE);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        #region Issue revision methods
        /// <summary>
        /// Creates the new issue revision.
        /// </summary>
        /// <param name="newIssueRevision">The new issue revision.</param>
        /// <returns></returns>
        public override int CreateNewIssueRevision(IssueRevision newIssueRevision)
        {
            if (newIssueRevision == null) throw new ArgumentNullException("newIssueRevision");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@Revision", SqlDbType.Int, 0, ParameterDirection.Input, newIssueRevision.Revision);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newIssueRevision.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@Repository", SqlDbType.NVarChar, 400, ParameterDirection.Input, newIssueRevision.Repository);
                    AddParamToSqlCmd(sqlCmd, "@RevisionAuthor", SqlDbType.NVarChar, 100, ParameterDirection.Input, newIssueRevision.Author);
                    AddParamToSqlCmd(sqlCmd, "@RevisionDate", SqlDbType.NVarChar, 100, ParameterDirection.Input, newIssueRevision.RevisionDate);
                    AddParamToSqlCmd(sqlCmd, "@RevisionMessage", SqlDbType.NText, 0, ParameterDirection.Input, newIssueRevision.Message);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEREVISION_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue revisions by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueRevision> GetIssueRevisionsByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("issueId");

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEREVISION_GETISSUEREVISIONSBYISSUEID);
                    var revisionList = new List<IssueRevision>();
                    ExecuteReaderCmd(sqlCmd, GenerateIssueRevisionListFromReader, ref revisionList);
                    return revisionList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Deletes the issue revision.
        /// </summary>
        /// <param name="issueRevisionId">The issue revision id.</param>
        /// <returns></returns>
        public override bool DeleteIssueRevision(int issueRevisionId)
        {
            if (issueRevisionId <= 0) throw (new ArgumentOutOfRangeException("issueRevisionId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueRevisionId", SqlDbType.Int, 0, ParameterDirection.Input, issueRevisionId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEREVISION_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        #endregion

        #region Issue vote methods
        /// <summary>
        /// Creates the new issue vote.
        /// </summary>
        /// <param name="newIssueVote">The new issue vote.</param>
        /// <returns></returns>
        public override int CreateNewIssueVote(IssueVote newIssueVote)
        {
            // Validate Parameters
            if (newIssueVote == null) throw (new ArgumentNullException("newIssueVote"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, newIssueVote.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@VoteUserName", SqlDbType.NText, 255, ParameterDirection.Input, newIssueVote.VoteUsername);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEVOTE_CREATE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Determines whether [has user voted] [the specified issue id].
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="username">The username.</param>
        /// <returns>
        /// 	<c>true</c> if [has user voted] [the specified issue id]; otherwise, <c>false</c>.
        /// </returns>
        public override bool HasUserVoted(int issueId, string username)
        {
            if (issueId <= 0) throw new ArgumentOutOfRangeException("issueId");
            if (username == String.Empty) throw (new ArgumentOutOfRangeException("username"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                    AddParamToSqlCmd(sqlCmd, "@VoteUserName", SqlDbType.NText, 255, ParameterDirection.Input, username);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEVOTE_HASUSERVOTED);
                    ExecuteScalarCmd(sqlCmd);
                    var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                    return (returnValue == 1);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }
        #endregion

        #region Milestone methods
        /// <summary>
        /// Creates the new milestone.
        /// </summary>
        /// <param name="newMileStone">The new mile stone.</param>
        /// <returns></returns>
        public override int CreateNewMilestone(Milestone newMileStone)
        {
            // Validate Parameters
            if (newMileStone == null) throw (new ArgumentNullException("newMileStone"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newMileStone.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneName", SqlDbType.NText, 50, ParameterDirection.Input, newMileStone.Name);
                AddParamToSqlCmd(sqlCmd, "@MilestoneImageUrl", SqlDbType.NText, 255, ParameterDirection.Input, newMileStone.ImageUrl);
                AddParamToSqlCmd(sqlCmd, "@MilestoneCompleted", SqlDbType.Bit, 0, ParameterDirection.Input, newMileStone.IsCompleted);
                AddParamToSqlCmd(sqlCmd, "@MilestoneNotes", SqlDbType.NText, 255, ParameterDirection.Input, newMileStone.Notes);

                //Bypass to AddParamToSQLCmd method which doesn't handle null values properly
                if (newMileStone.DueDate.HasValue)
                    AddParamToSqlCmd(sqlCmd, "@MilestoneDueDate", SqlDbType.DateTime, 0, ParameterDirection.Input, newMileStone.DueDate);
                else
                    sqlCmd.Parameters.AddWithValue("@MilestoneDueDate", DBNull.Value);

                if (newMileStone.ReleaseDate.HasValue)
                    AddParamToSqlCmd(sqlCmd, "@MilestoneReleaseDate", SqlDbType.DateTime, 0, ParameterDirection.Input, newMileStone.ReleaseDate);
                else
                    sqlCmd.Parameters.AddWithValue("@MilestoneReleaseDate", DBNull.Value);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the milestone.
        /// </summary>
        /// <param name="milestoneId">The milestone id.</param>
        /// <returns></returns>
        public override bool DeleteMilestone(int milestoneId)
        {
            // Validate Parameters
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@MilestoneIdToDelete", SqlDbType.Int, 4, ParameterDirection.Input, milestoneId);
                    AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                    return (resultValue == 0);
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Checks if the milestone can be deleted.
        /// </summary>
        /// <param name="milestoneId">The milestone id.</param>
        /// <returns></returns>
        public override bool CanDeleteMilestone(int milestoneId)
        {
            // Validate Parameters
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 4, ParameterDirection.Input, milestoneId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_CANDELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 1);
            }
        }

        /// <summary>
        /// Gets the milestones by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Milestone> GetMilestonesByProjectId(int projectId)
        {
            return GetMilestonesByProjectId(projectId, true);
        }


        /// <summary>
        /// Gets the milestones by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneCompleted">if set to <c>true</c> [milestone completed].</param>
        /// <returns></returns>
        public override List<Milestone> GetMilestonesByProjectId(int projectId, bool milestoneCompleted)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneCompleted", SqlDbType.Bit, 0, ParameterDirection.Input, milestoneCompleted);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_GETMILESTONEBYPROJECTID);
                var milestoneList = new List<Milestone>();
                ExecuteReaderCmd(sqlCmd, GenerateMilestoneListFromReader, ref milestoneList);

                return milestoneList;   
            }
        }

        /// <summary>
        /// Gets the milestone by id.
        /// </summary>
        /// <param name="milestoneId">The milestone id.</param>
        /// <returns></returns>
        public override Milestone GetMilestoneById(int milestoneId)
        {
            // Validate Parameters
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_GETMILESTONEBYID);
                var milestoneList = new List<Milestone>();
                ExecuteReaderCmd(sqlCmd, GenerateMilestoneListFromReader, ref milestoneList);

                return milestoneList.Count > 0 ? milestoneList[0] : null;   
            }
        }

        /// <summary>
        /// Updates the milestone.
        /// </summary>
        /// <param name="milestoneToUpdate">The milestone to update.</param>
        /// <returns></returns>
        public override bool UpdateMilestone(Milestone milestoneToUpdate)
        {
            // Validate Parameters
            if (milestoneToUpdate == null) throw (new ArgumentNullException("milestoneToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@SortOrder", SqlDbType.Int, 0, ParameterDirection.Input, milestoneToUpdate.SortOrder);
                AddParamToSqlCmd(sqlCmd, "@MilestoneName", SqlDbType.NText, 50, ParameterDirection.Input, milestoneToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@MilestoneImageUrl", SqlDbType.NText, 50, ParameterDirection.Input, milestoneToUpdate.ImageUrl);
                AddParamToSqlCmd(sqlCmd, "@MilestoneCompleted", SqlDbType.Bit, 0, ParameterDirection.Input, milestoneToUpdate.IsCompleted);
                AddParamToSqlCmd(sqlCmd, "@MilestoneNotes", SqlDbType.NText, 255, ParameterDirection.Input, milestoneToUpdate.Notes);

                //Bypass to AddParamToSQLCmd method which doesn't handle null values properly
                if (milestoneToUpdate.DueDate.HasValue)
                    AddParamToSqlCmd(sqlCmd, "@MilestoneDueDate", SqlDbType.DateTime, 0, ParameterDirection.Input, milestoneToUpdate.DueDate);
                else
                    sqlCmd.Parameters.AddWithValue("@MilestoneDueDate", DBNull.Value);

                if (milestoneToUpdate.ReleaseDate.HasValue)
                    AddParamToSqlCmd(sqlCmd, "@MilestoneReleaseDate", SqlDbType.DateTime, 0, ParameterDirection.Input, milestoneToUpdate.ReleaseDate);
                else
                    sqlCmd.Parameters.AddWithValue("@MilestoneReleaseDate", DBNull.Value);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_MILESTONE_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }
        #endregion

        #region Priority methods
        /// <summary>
        /// Creates the new priority.
        /// </summary>
        /// <param name="newPriority">The new priority.</param>
        /// <returns></returns>
        public override int CreateNewPriority(Priority newPriority)
        {
            // Validate Parameters
            if (newPriority == null) throw (new ArgumentNullException("newPriority"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newPriority.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@PriorityName", SqlDbType.NText, 50, ParameterDirection.Input, newPriority.Name);
                AddParamToSqlCmd(sqlCmd, "@PriorityImageUrl", SqlDbType.NText, 50, ParameterDirection.Input, newPriority.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the priority.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public override bool DeletePriority(int priorityId)
        {
            // Validate Parameters
            if (priorityId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("priorityId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@PriorityIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, priorityId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Checks if the priority can be deleted.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public override bool CanDeletePriority(int priorityId)
        {
            // Validate Parameters
            if (priorityId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("priorityId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@PriorityId", SqlDbType.Int, 4, ParameterDirection.Input, priorityId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_CANDELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 1);
            }
        }

        /// <summary>
        /// Gets the priorities by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Priority> GetPrioritiesByProjectId(int projectId)
        {
            // Validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_GETPRIORITIESBYPROJECTID);
                var priorityList = new List<Priority>();
                ExecuteReaderCmd(sqlCmd, GeneratePriorityListFromReader, ref priorityList);
                return priorityList;   
            }
        }

        /// <summary>
        /// Gets the priority by id.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public override Priority GetPriorityById(int priorityId)
        {
            // Validate Parameters
            if (priorityId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("priorityId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@PriorityId", SqlDbType.Int, 0, ParameterDirection.Input, priorityId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_GETPRIORITYBYID);
                var priorityList = new List<Priority>();
                ExecuteReaderCmd(sqlCmd, GeneratePriorityListFromReader, ref priorityList);
                return priorityList.Count > 0 ? priorityList[0] : null;   
            }
        }

        /// <summary>
        /// Updates the priority.
        /// </summary>
        /// <param name="priorityToUpdate">The priority to update.</param>
        /// <returns></returns>
        public override bool UpdatePriority(Priority priorityToUpdate)
        {
            // Validate Parameters
            if (priorityToUpdate == null) throw (new ArgumentNullException("priorityToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@PriorityId", SqlDbType.Int, 0, ParameterDirection.Input, priorityToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, priorityToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@SortOrder", SqlDbType.Int, 0, ParameterDirection.Input, priorityToUpdate.SortOrder);
                AddParamToSqlCmd(sqlCmd, "@PriorityName", SqlDbType.NText, 50, ParameterDirection.Input, priorityToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@PriorityImageUrl", SqlDbType.NText, 50, ParameterDirection.Input, priorityToUpdate.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PRIORITY_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }
        #endregion

        #region Project mailbox methods

        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="projectMailboxId">The mailbox id.</param>
        /// <returns></returns>
        public override ProjectMailbox GetProjectMailboxByMailboxId(int projectMailboxId)
        {
            // validate input
            if (projectMailboxId <= 0) throw (new ArgumentOutOfRangeException("projectMailboxId"));

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_GETMAILBOXBYID);

                AddParamToSqlCmd(sqlCmd, "@ProjectMailboxId", SqlDbType.Int, 0, ParameterDirection.Input, projectMailboxId);

                var projectList = new List<ProjectMailbox>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectMailboxListFromReader, ref projectList);

                return projectList.Count > 0 ? projectList[0] : null;   
            }
        }

        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="mailbox">The mailbox.</param>
        /// <returns></returns>
        public override ProjectMailbox GetProjectByMailbox(string mailbox)
        {
            // validate input
            if (String.IsNullOrEmpty(mailbox)) throw new ArgumentOutOfRangeException("mailbox");

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_GETPROJECTBYMAILBOX);

                AddParamToSqlCmd(sqlCmd, "@mailbox", SqlDbType.NVarChar, 0, ParameterDirection.Input, mailbox);

                var projectList = new List<ProjectMailbox>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectMailboxListFromReader, ref projectList);

                return projectList.Count > 0 ? projectList[0] : null;   
            }
        }

        /// <summary>
        /// Gets the mailboxs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<ProjectMailbox> GetMailboxsByProjectId(int projectId)
        {
            // validate input
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_GETMAILBYPROJECTID);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                var projectList = new List<ProjectMailbox>();
                ExecuteReaderCmd(sqlCmd, GenerateProjectMailboxListFromReader, ref projectList);
                return projectList;   
            }
        }

        /// <summary>
        /// Creates the project mailbox.
        /// </summary>
        /// <param name="mailboxToUpdate">The mailbox to update.</param>
        /// <returns></returns>
        public override int CreateProjectMailbox(ProjectMailbox mailboxToUpdate)
        {
            if (mailboxToUpdate == null) throw new ArgumentNullException("mailboxToUpdate");

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_CREATEPROJECTMAILBOX);

                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@MailBox", SqlDbType.NVarChar, 0, ParameterDirection.Input, mailboxToUpdate.Mailbox);
                AddParamToSqlCmd(sqlCmd, "@AssignToUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, mailboxToUpdate.AssignToUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.IssueTypeId);

                ExecuteScalarCmd(sqlCmd);
                return (int)sqlCmd.Parameters["@ReturnValue"].Value;   
            }
        }

        /// <summary>
        /// Updates the project mailbox.
        /// </summary>
        /// <param name="mailboxToUpdate">The mailbox to update.</param>
        /// <returns></returns>
        public override bool UpdateProjectMailbox(ProjectMailbox mailboxToUpdate)
        {
            if (mailboxToUpdate == null) throw new ArgumentNullException("mailboxToUpdate");

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_UPDATEPROJECTMAILBOX);

                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectMailboxId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@MailBoxEmailAddress", SqlDbType.NVarChar, 0, ParameterDirection.Input, mailboxToUpdate.Mailbox);
                AddParamToSqlCmd(sqlCmd, "@AssignToUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, mailboxToUpdate.AssignToUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.IssueTypeId);

                ExecuteScalarCmd(sqlCmd);

                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Deletes the project mailbox.
        /// </summary>
        /// <param name="mailboxId">The mailbox id.</param>
        /// <returns></returns>
        public override bool DeleteProjectMailbox(int mailboxId)
        {
            if (mailboxId <= 0) throw new ArgumentOutOfRangeException("mailboxId");

            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_PROJECTMAILBOX_DELETEPROJECTMAILBOX);

                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectMailboxId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxId);

                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }
        #endregion

        #region Status methods
        /// <summary>
        /// Creates the new status.
        /// </summary>
        /// <param name="newStatus">The new status.</param>
        /// <returns></returns>
        public override int CreateNewStatus(Status newStatus)
        {
            // Validate Parameters
            if (newStatus == null) throw (new ArgumentNullException("newStatus"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newStatus.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@StatusName", SqlDbType.NVarChar, 0, ParameterDirection.Input, newStatus.Name);
                AddParamToSqlCmd(sqlCmd, "@StatusImageUrl", SqlDbType.NText, 255, ParameterDirection.Input, newStatus.ImageUrl);
                AddParamToSqlCmd(sqlCmd, "@IsClosedState", SqlDbType.Bit, 0, ParameterDirection.Input, newStatus.IsClosedState);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public override bool DeleteStatus(int statusId)
        {
            if (statusId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("statusId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@StatusIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, statusId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Checks if the status can be deleted.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public override bool CanDeleteStatus(int statusId)
        {
            // Validate Parameters
            if (statusId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("statusId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@StatusId", SqlDbType.Int, 4, ParameterDirection.Input, statusId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_CANDELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 1);
            }
        }

        /// <summary>
        /// Gets the status by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Status> GetStatusByProjectId(int projectId)
        {
            // validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_GETSTATUSBYPROJECTID);
                var statusList = new List<Status>();
                ExecuteReaderCmd(sqlCmd, GenerateStatusListFromReader, ref statusList);
                return statusList;   
            }
        }


        /// <summary>
        /// Updates the status.
        /// </summary>
        /// <param name="statusToUpdate">The status to update.</param>
        /// <returns></returns>
        public override bool UpdateStatus(Status statusToUpdate)
        {
            // Validate Parameters
            if (statusToUpdate == null) throw (new ArgumentNullException("statusToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@StatusId", SqlDbType.Int, 0, ParameterDirection.Input, statusToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, statusToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@SortOrder", SqlDbType.Int, 0, ParameterDirection.Input, statusToUpdate.SortOrder);
                AddParamToSqlCmd(sqlCmd, "@StatusName", SqlDbType.NVarChar, 0, ParameterDirection.Input, statusToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@StatusImageUrl", SqlDbType.NText, 255, ParameterDirection.Input, statusToUpdate.ImageUrl);
                AddParamToSqlCmd(sqlCmd, "@IsClosedState", SqlDbType.Bit, 0, ParameterDirection.Input, statusToUpdate.IsClosedState);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Gets the status by id.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public override Status GetStatusById(int statusId)
        {
            // validate Parameters
            if (statusId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("statusId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@StatusId", SqlDbType.Int, 0, ParameterDirection.Input, statusId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_STATUS_GETSTATUSBYID);
                var statusList = new List<Status>();
                ExecuteReaderCmd(sqlCmd, GenerateStatusListFromReader, ref statusList);

                return statusList.Count > 0 ? statusList[0] : null;   
            }
        }
        #endregion

        #region Custom field & selection methods

        /// <summary>
        /// Gets the custom field by id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public override CustomField GetCustomFieldById(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CustomFieldId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_GETCUSTOMFIELDBYID);

                var customFieldList = new List<CustomField>();
                ExecuteReaderCmd(sqlCmd, GenerateCustomFieldListFromReader, ref customFieldList);

                return customFieldList.Count > 0 ? customFieldList[0] : null;   
            }
        }

        /// <summary>
        /// Gets the custom fields by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<CustomField> GetCustomFieldsByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_GETCUSTOMFIELDSBYPROJECTID);

                var customFieldList = new List<CustomField>();
                ExecuteReaderCmd(sqlCmd, GenerateCustomFieldListFromReader, ref customFieldList);

                return customFieldList;   
            }
        }

        /// <summary>
        /// Gets the custom fields by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<CustomField> GetCustomFieldsByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_GETCUSTOMFIELDSBYISSUEID);

                var customFieldList = new List<CustomField>();
                ExecuteReaderCmd(sqlCmd, GenerateCustomFieldListFromReader, ref customFieldList);

                return customFieldList;   
            }
        }

        /// <summary>
        /// Creates the new custom field.
        /// </summary>
        /// <param name="newCustomField">The new custom field.</param>
        /// <returns></returns>
        public override int CreateNewCustomField(CustomField newCustomField)
        {
            if (newCustomField == null) throw new ArgumentNullException("newCustomField");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldName", SqlDbType.NText, 50, ParameterDirection.Input, newCustomField.Name);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldDataType", SqlDbType.Int, 0, ParameterDirection.Input, newCustomField.DataType);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, newCustomField.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldRequired", SqlDbType.Bit, 0, ParameterDirection.Input, newCustomField.Required);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldTypeId", SqlDbType.Int, 0, ParameterDirection.Input, (int)newCustomField.FieldType);


                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Updates the custom field.
        /// </summary>
        /// <param name="customFieldToUpdate">The custom field to update.</param>
        /// <returns></returns>
        public override bool UpdateCustomField(CustomField customFieldToUpdate)
        {
            if (customFieldToUpdate == null) throw new ArgumentNullException("customFieldToUpdate");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldName", SqlDbType.NText, 50, ParameterDirection.Input, customFieldToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldDataType", SqlDbType.Int, 0, ParameterDirection.Input, customFieldToUpdate.DataType);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldRequired", SqlDbType.Bit, 0, ParameterDirection.Input, customFieldToUpdate.Required);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldTypeId", SqlDbType.Int, 0, ParameterDirection.Input, (int)customFieldToUpdate.FieldType);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Deletes the custom field.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public override bool DeleteCustomField(int customFieldId)
        {
            // Validate Parameters
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CustomFieldIdToDelete", SqlDbType.Int, 4, ParameterDirection.Input, customFieldId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 0);   
            }
        }

        /// <summary>
        /// Saves the custom field values.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="fields">The fields.</param>
        /// <returns></returns>
        public override bool SaveCustomFieldValues(int issueId, List<CustomField> fields)
        {
            // Validate Parameters
            if (fields == null) throw (new ArgumentNullException("fields"));
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                sqlCmd.Parameters.Add("@ReturnValue", SqlDbType.Int, 0).Direction = ParameterDirection.ReturnValue;
                sqlCmd.Parameters.Add("@IssueId", SqlDbType.Int, 0).Direction = ParameterDirection.Input;
                sqlCmd.Parameters.Add("@CustomFieldId", SqlDbType.Int, 0).Direction = ParameterDirection.Input;
                sqlCmd.Parameters.Add("@CustomFieldValue", SqlDbType.NVarChar, 255).Direction = ParameterDirection.Input;

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELD_SAVECUSTOMFIELDVALUE);

                var errors = false;

                foreach (var field in fields)
                {
                    sqlCmd.Parameters["@IssueId"].Value = issueId;
                    sqlCmd.Parameters["@CustomFieldId"].Value = field.Id;
                    sqlCmd.Parameters["@CustomFieldValue"].Value = field.Value;
                    ExecuteScalarCmd(sqlCmd);
                    if ((int)sqlCmd.Parameters["@ReturnValue"].Value == 1)
                        errors = true;
                }
                return !errors;   
            }
        }

        /// <summary>
        /// Creates the new custom field selection.
        /// </summary>
        /// <param name="newCustomFieldSelection">The new custom field selection.</param>
        /// <returns></returns>
        public override int CreateNewCustomFieldSelection(CustomFieldSelection newCustomFieldSelection)
        {
            if (newCustomFieldSelection == null) throw new ArgumentNullException("newCustomFieldSelection");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldId", SqlDbType.Int, 0, ParameterDirection.Input, newCustomFieldSelection.CustomFieldId);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionName", SqlDbType.NVarChar, 255, ParameterDirection.Input, newCustomFieldSelection.Name);
                AddParamToSqlCmd(sqlCmd, "@CUstomFieldSelectionValue", SqlDbType.NVarChar, 255, ParameterDirection.Input, newCustomFieldSelection.Value);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELDSELECTION_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the custom field selection.
        /// </summary>
        /// <param name="customFieldSelectionId">The custom field selection id.</param>
        /// <returns></returns>
        public override bool DeleteCustomFieldSelection(int customFieldSelectionId)
        {
            if (customFieldSelectionId <= 0) throw new ArgumentOutOfRangeException("customFieldSelectionId");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, customFieldSelectionId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELDSELECTION_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Gets the custom field selections by custom field id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public override List<CustomFieldSelection> GetCustomFieldSelectionsByCustomFieldId(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CustomFieldId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELDSELECTION_GETCUSTOMFIELDSELECTIONSBYCUSTOMFIELDID);

                var customFieldSelectionList = new List<CustomFieldSelection>();
                ExecuteReaderCmd(sqlCmd, GenerateCustomFieldSelectionListFromReader, ref customFieldSelectionList);

                return customFieldSelectionList;   
            }
        }

        /// <summary>
        /// Gets the custom field selection by id.
        /// </summary>
        /// <param name="customFieldSelectionId">The custom field selection id.</param>
        /// <returns></returns>
        public override CustomFieldSelection GetCustomFieldSelectionById(int customFieldSelectionId)
        {
            if (customFieldSelectionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldSelectionId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldSelectionId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELDSELECTION_GETCUSTOMFIELDSELECTIONBYID);

                var customFieldSelectionList = new List<CustomFieldSelection>();
                ExecuteReaderCmd(sqlCmd, GenerateCustomFieldSelectionListFromReader, ref customFieldSelectionList);

                return customFieldSelectionList.Count > 0 ? customFieldSelectionList[0] : null;   
            }
        }

        /// <summary>
        /// Updates the custom field selection.
        /// </summary>
        /// <param name="customFieldSelectionToUpdate">The custom field selection to update.</param>
        /// <returns></returns>
        public override bool UpdateCustomFieldSelection(CustomFieldSelection customFieldSelectionToUpdate)
        {
            if (customFieldSelectionToUpdate == null) throw new ArgumentNullException("customFieldSelectionToUpdate");

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldSelectionToUpdate.CustomFieldId);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionId", SqlDbType.Int, 0, ParameterDirection.Input, customFieldSelectionToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionName", SqlDbType.NText, 50, ParameterDirection.Input, customFieldSelectionToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionValue", SqlDbType.NText, 50, ParameterDirection.Input, customFieldSelectionToUpdate.Value);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionSortOrder", SqlDbType.Int, 0, ParameterDirection.Input, customFieldSelectionToUpdate.SortOrder);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_CUSTOMFIELDSELECTION_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }
        #endregion

        #region Issue type methods
        /// <summary>
        /// Gets the issue type by id.
        /// </summary>
        /// <param name="issueTypeId">The issue type id.</param>
        /// <returns></returns>
        public override IssueType GetIssueTypeById(int issueTypeId)
        {
            // validate Parameters
            if (issueTypeId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueTypeId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_GETISSUETYPEBYID);
                var issueTypeList = new List<IssueType>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueTypeListFromReader, ref issueTypeList);

                return issueTypeList.Count > 0 ? issueTypeList[0] : null;   
            }
        }

        /// <summary>
        /// Creates the new type of the issue.
        /// </summary>
        /// <param name="issueTypeToCreate">The issue type to create.</param>
        /// <returns></returns>
        public override int CreateNewIssueType(IssueType issueTypeToCreate)
        {
            // Validate Parameters
            if (issueTypeToCreate == null) throw (new ArgumentNullException("issueTypeToCreate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeToCreate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeName", SqlDbType.NText, 50, ParameterDirection.Input, issueTypeToCreate.Name);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeImageUrl", SqlDbType.NText, 255, ParameterDirection.Input, issueTypeToCreate.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the type of the issue.
        /// </summary>
        /// <param name="issueTypeId">The issue type id.</param>
        /// <returns></returns>
        public override bool DeleteIssueType(int issueTypeId)
        {
            if (issueTypeId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueTypeId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Checks if the issue type can be deleted.
        /// </summary>
        /// <param name="issueTypeId">The issue type id.</param>
        /// <returns></returns>
        public override bool CanDeleteIssueType(int issueTypeId)
        {
            // Validate Parameters
            if (issueTypeId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueTypeId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 4, ParameterDirection.Input, issueTypeId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_CANDELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 1);
            }
        }

        /// <summary>
        /// Updates the type of the issue.
        /// </summary>
        /// <param name="issueTypeToUpdate">The issue type to update.</param>
        /// <returns></returns>
        public override bool UpdateIssueType(IssueType issueTypeToUpdate)
        {
            // Validate Parameters
            if (issueTypeToUpdate == null) throw (new ArgumentNullException("issueTypeToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeId", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@SortOrder", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeToUpdate.SortOrder);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, issueTypeToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeName", SqlDbType.NText, 50, ParameterDirection.Input, issueTypeToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@IssueTypeImageUrl", SqlDbType.NText, 50, ParameterDirection.Input, issueTypeToUpdate.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Gets the issue types by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<IssueType> GetIssueTypesByProjectId(int projectId)
        {
            // validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUETYPE_GETISSUETYPESBYPROJECTID);
                var issueTypeList = new List<IssueType>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueTypeListFromReader, ref issueTypeList);
                return issueTypeList;   
            }
        }

        #endregion

        #region Resolution methods
        /// <summary>
        /// Gets the resolution by id.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public override Resolution GetResolutionById(int resolutionId)
        {
            // validate Parameters
            if (resolutionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("resolutionId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ResolutionId", SqlDbType.Int, 0, ParameterDirection.Input, resolutionId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_GETRESOLUTIONBYID);
                var resolutionList = new List<Resolution>();
                ExecuteReaderCmd(sqlCmd, GenerateResolutionListFromReader, ref resolutionList);

                return resolutionList.Count > 0 ? resolutionList[0] : null;   
            }
        }

        /// <summary>
        /// Creates the new resolution.
        /// </summary>
        /// <param name="resolutionToCreate">The resolution to create.</param>
        /// <returns></returns>
        public override int CreateNewResolution(Resolution resolutionToCreate)
        {
            // Validate Parameters
            if (resolutionToCreate == null) throw (new ArgumentNullException("resolutionToCreate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, resolutionToCreate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@ResolutionName", SqlDbType.NText, 50, ParameterDirection.Input, resolutionToCreate.Name);
                AddParamToSqlCmd(sqlCmd, "@ResolutionImageUrl", SqlDbType.NText, 255, ParameterDirection.Input, resolutionToCreate.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_CREATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value);   
            }
        }

        /// <summary>
        /// Deletes the resolution.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public override bool DeleteResolution(int resolutionId)
        {
            if (resolutionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("resolutionId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ResolutionIdToDelete", SqlDbType.Int, 0, ParameterDirection.Input, resolutionId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_DELETE);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0);   
            }
        }

        /// <summary>
        /// Checks if the resolution can be deleted.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public override bool CanDeleteResolution(int resolutionId)
        {
            // Validate Parameters
            if (resolutionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("resolutionId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ResolutionId", SqlDbType.Int, 4, ParameterDirection.Input, resolutionId);
                AddParamToSqlCmd(sqlCmd, "@ResultValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_CANDELETE);
                ExecuteScalarCmd(sqlCmd);
                var resultValue = (int)sqlCmd.Parameters["@ResultValue"].Value;
                return (resultValue == 1);
            }
        }

        /// <summary>
        /// Updates the resolution.
        /// </summary>
        /// <param name="resolutionToUpdate">The resolution to update.</param>
        /// <returns></returns>
        public override bool UpdateResolution(Resolution resolutionToUpdate)
        {
            // Validate Parameters
            if (resolutionToUpdate == null) throw (new ArgumentNullException("resolutionToUpdate"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ResolutionId", SqlDbType.Int, 0, ParameterDirection.Input, resolutionToUpdate.Id);
                AddParamToSqlCmd(sqlCmd, "@SortOrder", SqlDbType.Int, 0, ParameterDirection.Input, resolutionToUpdate.SortOrder);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, resolutionToUpdate.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@ResolutionName", SqlDbType.NText, 50, ParameterDirection.Input, resolutionToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@ResolutionImageUrl", SqlDbType.NText, 50, ParameterDirection.Input, resolutionToUpdate.ImageUrl);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_UPDATE);
                ExecuteScalarCmd(sqlCmd);
                return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
            }
        }

        /// <summary>
        /// Gets the resolutions by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<Resolution> GetResolutionsByProjectId(int projectId)
        {
            // validate Parameters
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_RESOLUTION_GETRESOLUTIONSBYPROJECTID);
                var resolutionList = new List<Resolution>();
                ExecuteReaderCmd(sqlCmd, GenerateResolutionListFromReader, ref resolutionList);
                return resolutionList;   
            }
        }

        #endregion

        #region Issue Work Reports
        /// <summary>
        /// Creates the new issue work report.
        /// </summary>
        /// <param name="issueWorkReportToCreate">The issue work report to create.</param>
        /// <returns></returns>
        public override int CreateNewIssueWorkReport(IssueWorkReport issueWorkReportToCreate)
        {
            if (issueWorkReportToCreate == null) throw (new ArgumentNullException("issueWorkReportToCreate"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.NVarChar, 0, ParameterDirection.Input, issueWorkReportToCreate.IssueId);
                    AddParamToSqlCmd(sqlCmd, "@CreatorUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, issueWorkReportToCreate.CreatorUserName);
                    AddParamToSqlCmd(sqlCmd, "@WorkDate", SqlDbType.DateTime, 0, ParameterDirection.Input, issueWorkReportToCreate.WorkDate);
                    AddParamToSqlCmd(sqlCmd, "@Duration", SqlDbType.Decimal, 0, ParameterDirection.Input, issueWorkReportToCreate.Duration);
                    AddParamToSqlCmd(sqlCmd, "@IssueCommentId", SqlDbType.Int, 0, ParameterDirection.Input, issueWorkReportToCreate.CommentId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEWORKREPORT_CREATE);
                    ExecuteScalarCmd(sqlCmd);

                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value);
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the work report by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public override List<IssueWorkReport> GetIssueWorkReportsByIssueId(int issueId)
        {
            if (issueId <= 0) throw (new ArgumentOutOfRangeException("issueId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEWORKREPORT_GETBYISSUEWORKREPORTSBYISSUEID);

                var issueTimeEntryList = new List<IssueWorkReport>();
                ExecuteReaderCmd(sqlCmd, GenerateIssueTimeEntryListFromReader, ref issueTimeEntryList);

                return issueTimeEntryList;   
            }
        }

        /// <summary>
        /// Deletes the issue work report.
        /// </summary>
        /// <param name="issueWorkReportId">The issue work report id.</param>
        /// <returns></returns>
        public override bool DeleteIssueWorkReport(int issueWorkReportId)
        {
            if (issueWorkReportId <= 0) throw (new ArgumentOutOfRangeException("issueWorkReportId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueWorkReportId", SqlDbType.Int, 0, ParameterDirection.Input, issueWorkReportId);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEWORKREPORT_DELETE);
                    ExecuteScalarCmd(sqlCmd);
                    return ((int)sqlCmd.Parameters["@ReturnValue"].Value == 0);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        public override List<IssueWorkReport> GetIssueWorkReportsByProjectId(int projectId)
        {
            throw new NotImplementedException();
        }

        public override List<IssueWorkReport> GetIssueWorkReportsByUserName(int projectId, string reporterUserName)
        {
            throw new NotImplementedException();
        }
        #endregion

        #region Appliation log methods
        /// <summary>
        /// Gets the application log.
        /// </summary>
        /// <param name="filterType">Type of the filter.</param>
        /// <returns></returns>
        public override List<ApplicationLog> GetApplicationLog(string filterType)
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_APPLICATIONLOG_GETLOG);

                    var applicationLogList = new List<ApplicationLog>();
                    AddParamToSqlCmd(sqlCmd, "@FilterType", SqlDbType.NVarChar, 50, ParameterDirection.Input, (filterType.Length == 0) ? DBNull.Value : (object)filterType);
                    ExecuteReaderCmd(sqlCmd, GenerateApplicationLogListFromReader, ref applicationLogList);

                    return applicationLogList;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Clears the application log.
        /// </summary>
        public override void ClearApplicationLog()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_APPLICATIONLOG_CLEARLOG);
                    ExecuteScalarCmd(sqlCmd);   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
        #endregion

        /// <summary>
        /// Gets the installed language resources.
        /// </summary>
        /// <returns></returns>
        public override List<string> GetInstalledLanguageResources()
        {
            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_LANGUAGES_GETINSTALLEDLANGUAGES);
                    var cultureCodes = new List<string>();
                    ExecuteReaderCmd(sqlCmd, GenerateInstalledResourcesListFromReader, ref cultureCodes);
                    return cultureCodes;   
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the provider path.
        /// </summary>
        /// <returns></returns>
        public override string GetProviderPath()
        {
            var context = HttpContext.Current;

            if (_providerPath != string.Empty)
            {
                if (_mappedProviderPath == string.Empty)
                {
                    _mappedProviderPath = context.Server.MapPath(_providerPath);
                    if (!Directory.Exists(_mappedProviderPath))
                        return string.Format("ERROR: providerPath folder {0} specified for SqlDataProvider does not exist on web server", _mappedProviderPath);
                }
            }
            else
            {
                return "ERROR: providerPath folder value not specified in web.config for SqlDataProvider";
            }
            return _mappedProviderPath;
        }

        /// <summary>
        /// Gets the database version.
        /// </summary>
        /// <returns></returns>
        public override string GetDatabaseVersion()
        {
            string currentVersion;

            using (var sqlCmd = new SqlCommand())
            {
                //Check For 0.7 Version
                try
                {
                    SetCommandType(sqlCmd, CommandType.Text, "SELECT SettingValue FROM HostSettings WHERE SettingName='Version'");
                    currentVersion = (string)ExecuteScalarCmd(sqlCmd);
                }
                catch (SqlException)
                {
                    currentVersion = "ERROR";
                }

                //check for version 0.8 if 0.7 has not already been found or threw an exception
                if (currentVersion == string.Empty || currentVersion == "ERROR")
                {
                    try
                    {
                        SetCommandType(sqlCmd, CommandType.Text, "SELECT SettingValue FROM BugNet_HostSettings WHERE SettingName='Version'");
                        currentVersion = (string)ExecuteScalarCmd(sqlCmd);
                    }
                    catch (SqlException e)
                    {
                        switch (e.Number)
                        {
                            case 4060:
                                return "ERROR " + e.Message;
                        }

                        currentVersion = string.Empty;
                    }

                }   
            }

            return currentVersion;
        }

        /// <summary>
        /// Processes the exception.
        /// </summary>
        /// <param name="ex">The ex.</param>
        /// <returns></returns>
        public override DataAccessException ProcessException(Exception ex)
        {
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", HttpContext.Current.User.Identity.Name);

            if (Log.IsErrorEnabled)
                Log.Error(ex.Message, ex);

            return new DataAccessException("Database Error", ex);
        }

        #region SQL Helper Methods

        //*********************************************************************
        //
        // SQL Helper Methods
        //
        // The following utility methods are used to interact with SQL Server.
        //
        //*********************************************************************

        /// <summary>
        /// Adds the param to SQL CMD.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="paramId">The param id.</param>
        /// <param name="sqlType">Type of the SQL.</param>
        /// <param name="paramSize">Size of the param.</param>
        /// <param name="paramDirection">The param direction.</param>
        /// <param name="paramvalue">The paramvalue.</param>
        private static void AddParamToSqlCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, ParameterDirection paramDirection, object paramvalue)
        {
            // Validate Parameter Properties
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));
            if (paramId == string.Empty) throw (new ArgumentOutOfRangeException("paramId"));

            // Add Parameter
            var newSqlParam = new SqlParameter
                                  {ParameterName = paramId, SqlDbType = sqlType, Direction = paramDirection};

            if (paramSize > 0)
                newSqlParam.Size = paramSize;

            if (paramvalue != null)
                newSqlParam.Value = paramvalue;

            sqlCmd.Parameters.Add(newSqlParam);
        }


        /// <summary>
        /// Executes the scalar CMD.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <returns></returns>
        private Object ExecuteScalarCmd(SqlCommand sqlCmd)
        {
            // Validate Command Properties
            if (string.IsNullOrEmpty(_connectionString)) throw new Exception("The connection string cannot be empty, please check the web.config for the proper settings");
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));

            Object result;

            using (var cn = new SqlConnection(_connectionString))
            {
                sqlCmd.Connection = cn;
                cn.Open();
                result = sqlCmd.ExecuteScalar();
            }

            return result;
        }


        /// <summary>
        /// Ts the execute reader CMD.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="gcfr">The GCFR.</param>
        /// <param name="list">The list.</param>
        private void ExecuteReaderCmd<T>(SqlCommand sqlCmd, GenerateListFromReader<T> gcfr, ref List<T> list)
        {
            if (string.IsNullOrEmpty(_connectionString)) throw new Exception("The connection string cannot be empty, please check the web.config for the proper settings");
            if (sqlCmd == null) throw (new ArgumentNullException("sqlCmd"));

            using (var cn = new SqlConnection(_connectionString))
            {
                sqlCmd.Connection = cn;
                cn.Open();
                gcfr(sqlCmd.ExecuteReader(), ref list);
            }
        }

        /// <summary>
        /// Sets the type of the command.
        /// </summary>
        /// <param name="sqlCmd">The SQL CMD.</param>
        /// <param name="cmdType">Type of the CMD.</param>
        /// <param name="cmdText">The CMD text.</param>
        private static void SetCommandType(IDbCommand sqlCmd, CommandType cmdType, string cmdText)
        {
            sqlCmd.CommandType = cmdType;
            sqlCmd.CommandText = cmdText;
        }

        /// <summary>
        /// Executes the script.
        /// </summary>
        /// <param name="sql">The SQL.</param>
        public override void ExecuteScript(List<string> sql)
        {
            if (sql == null)
                throw new ArgumentNullException("sql");

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                foreach (var command in sql.Select(stmt => new SqlCommand(stmt, conn)))
                {
                    command.ExecuteNonQuery();
                }
                conn.Close();
            }
        }

        #endregion

        #region GENARATE LIST HELPER METHODS

        /// <summary>
        /// Ts the generate issue comment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCommentList">The issue comment list.</param>
        private static void GenerateIssueCommentListFromReader(IDataReader returnData, ref List<IssueComment> issueCommentList)
        {
            while (returnData.Read())
            {
                issueCommentList.Add(new IssueComment
                                         {
                                            Id = returnData.GetInt32(returnData.GetOrdinal("IssueCommentId")),
                                            Comment = returnData.GetString(returnData.GetOrdinal("Comment")),
                                            DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                                            CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                                            CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                                            IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                                            CreatorUserId = returnData.GetGuid(returnData.GetOrdinal("CreatorUserId"))
                                         });
            }
        }

        /// <summary>
        /// Ts the generate issue count list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCountList">The issue count list.</param>
        private static void GenerateIssueCountListFromReader(IDataReader returnData, ref List<IssueCount> issueCountList)
        {
            while (returnData.Read())
            {
                var issueCount = new IssueCount(returnData.GetValue(2), (string)returnData.GetValue(0), (int)returnData.GetValue(1), (string)returnData.GetValue(3));
                issueCountList.Add(issueCount);
            }
        }

        /// <summary>
        /// Ts the generate issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static void GenerateIssueListFromReader(IDataReader returnData, ref List<Issue> issueList)
        {
            while (returnData.Read())
            {
                issueList.Add(MapIssue(returnData));
            }
        }

        /// <summary>
        /// Ts the generate installed resources list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="cultureCodes">The culture codes.</param>
        private static void GenerateInstalledResourcesListFromReader(IDataReader returnData, ref List<string> cultureCodes)
        {
            while (returnData.Read())
            {
                cultureCodes.Add((string)returnData["cultureCode"]);
            }
        }

        /// <summary>
        /// Ts the generate issue history list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueHistoryList">The issue history list.</param>
        private static void GenerateIssueHistoryListFromReader(IDataReader returnData, ref List<IssueHistory> issueHistoryList)
        {
            while (returnData.Read())
            {
                issueHistoryList.Add(new IssueHistory
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueHistoryId")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    CreatedUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    FieldChanged = returnData.GetString(returnData.GetOrdinal("FieldChanged")),
                    NewValue = returnData.GetString(returnData.GetOrdinal("NewValue")),
                    OldValue = returnData.GetString(returnData.GetOrdinal("OldValue")),
                    DateChanged = returnData.GetDateTime(returnData.GetOrdinal("DateCreated"))
                });
            }
        }

        /// <summary>
        /// Ts the generate issue notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueNotificationList">The issue notification list.</param>
        private static void GenerateIssueNotificationListFromReader(IDataReader returnData, ref List<IssueNotification> issueNotificationList)
        {
            while (returnData.Read())
            {
                issueNotificationList.Add(new IssueNotification
                {
                    Id = 1,
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    NotificationUsername = returnData.GetString(returnData.GetOrdinal("NotificationUsername")),
                    NotificationEmail = returnData.GetString(returnData.GetOrdinal("NotificationEmail")),
                    NotificationDisplayName = returnData.GetString(returnData.GetOrdinal("NotificationDisplayName"))
                });
            }
        }

        /// <summary>
        /// Ts the generate host setting list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="hostsettingList">The hostsetting list.</param>
        private static void GenerateHostSettingListFromReader(IDataReader returnData, ref List<HostSetting> hostsettingList)
        {
            while (returnData.Read())
            {
                hostsettingList.Add(new HostSetting
                                        {
                                            SettingName = returnData.GetString(returnData.GetOrdinal("SettingName")),
                                            SettingValue = returnData.GetString(returnData.GetOrdinal("SettingValue"))
                                        });
            }
        }

        /// <summary>
        /// Ts the generate role list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="roleList">The role list.</param>
        private static void GenerateRoleListFromReader(IDataReader returnData, ref List<Role> roleList)
        {
            while (returnData.Read())
            {
                roleList.Add(new Role
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("RoleId")),
                    ProjectId = (returnData["ProjectId"] != DBNull.Value) ? returnData.GetInt32(returnData.GetOrdinal("ProjectId")) : 0,
                    Name = returnData.GetString(returnData.GetOrdinal("RoleName")),
                    AutoAssign = returnData.GetBoolean(returnData.GetOrdinal("AutoAssign")),
                    Description = returnData.GetString(returnData.GetOrdinal("RoleDescription")),
                });
            }
        }

        /// <summary>
        /// Ts the generate role permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="rolePermissionList">The role permission list.</param>
        private static void GenerateRolePermissionListFromReader(SqlDataReader returnData, ref List<RolePermission> rolePermissionList)
        {
            while (returnData.Read())
            {
                var permission = new RolePermission((int)returnData["PermissionId"], (int)returnData["ProjectId"], returnData["RoleName"].ToString(),
                    returnData["PermissionName"].ToString(), returnData["PermissionKey"].ToString());
                rolePermissionList.Add(permission);
            }
        }

        /// <summary>
        /// Ts the generate permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="permissionList">The permission list.</param>
        private static void GeneratePermissionListFromReader(SqlDataReader returnData, ref List<Permission> permissionList)
        {
            while (returnData.Read())
            {
                var permission = new Permission((int)returnData["PermissionId"], returnData["PermissionName"].ToString(), returnData["PermissionKey"].ToString());
                permissionList.Add(permission);
            }
        }

        /// <summary>
        /// Ts the generate user list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="userList">The user list.</param>
        private static void GenerateUserListFromReader(SqlDataReader returnData, ref List<ITUser> userList)
        {
            while (returnData.Read())
            {
                var user = new ITUser((Guid)returnData["UserId"], (string)returnData["UserName"], (string)returnData["DisplayName"]);
                userList.Add(user);
            }
        }

        /// <summary>
        /// Ts the generate project list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectList">The project list.</param>
        private static void GenerateProjectListFromReader(IDataReader returnData, ref List<Project> projectList)
        {
            while (returnData.Read())
            {
                projectList.Add(new Project
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("ProjectName")),
                    Description = returnData.GetString(returnData.GetOrdinal("ProjectDescription")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    AllowAttachments = returnData.GetBoolean(returnData.GetOrdinal("AllowAttachments")),
                    AccessType = (Globals.ProjectAccessType)returnData["ProjectAccessType"],
                    AllowIssueVoting = returnData.GetBoolean(returnData.GetOrdinal("AllowIssueVoting")),
                    AttachmentStorageType = (IssueAttachmentStorageTypes)returnData["AttachmentStorageType"], 
                    Code = returnData.GetString(returnData.GetOrdinal("ProjectCode")),
                    Disabled = returnData.GetBoolean(returnData.GetOrdinal("ProjectDisabled")), 
                    ManagerDisplayName = returnData.GetString(returnData.GetOrdinal("ManagerDisplayName")),
                    ManagerId = returnData.GetGuid(returnData.GetOrdinal("ProjectManagerUserId")),
                    ManagerUserName = returnData.GetString(returnData.GetOrdinal("ManagerUserName")),
                    SvnRepositoryUrl = returnData.GetString(returnData.GetOrdinal("SvnRepositoryUrl")),
                    UploadPath = returnData.GetString(returnData.GetOrdinal("AttachmentUploadPath")),
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated"))
                });
            }
        }

        /// <summary>
        /// Ts the generate member roles list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="memberRoleList">The member roles list.</param>
        private static void GenerateProjectMemberRoleListFromReader(SqlDataReader returnData, ref List<MemberRoles> memberRoleList)
        {
            while (returnData.Read())
            {
                int i;
                var found = false;
                for (i = 0; i < memberRoleList.Count; i++)
                {
                    if (!memberRoleList[i].Username.Equals((string) returnData.GetValue(0))) continue;
                    memberRoleList[i].AddRole((string)returnData.GetValue(1));
                    found = true;
                }

                if (found) continue;

                var memberRoles = new MemberRoles((string)returnData.GetValue(0), (string)returnData.GetValue(1));
                memberRoleList.Add(memberRoles);
            }
        }

        /// <summary>
        /// Ts the generate roadmap issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static void GenerateRoadmapIssueListFromReader(IDataReader returnData, ref List<RoadMapIssue> issueList)
        {
            while (returnData.Read())
            {
                var issue = MapIssue(returnData);

                if(issue == null) continue;

                var rmIssue = new RoadMapIssue(issue, returnData.GetInt32(returnData.GetOrdinal("MilestoneSortOrder")));
                issueList.Add(rmIssue);
            }
        }

        /// <summary>
        /// Ts the generate project notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectNotificationList">The project notification list.</param>
        private static void GenerateProjectNotificationListFromReader(IDataReader returnData, ref List<ProjectNotification> projectNotificationList)
        {
            while (returnData.Read())
            {
                projectNotificationList.Add(new ProjectNotification
                                                {
                                                    Id = returnData.GetInt32(returnData.GetOrdinal("ProjectNotificationId")),
                                                    NotificationDisplayName = returnData.GetString(returnData.GetOrdinal("NotificationDisplayName")),
                                                    NotificationEmail = returnData.GetString(returnData.GetOrdinal("NotificationEmail")),
                                                    NotificationUsername = returnData.GetString(returnData.GetOrdinal("NotificationUsername")),
                                                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                                    ProjectName = returnData.GetString(returnData.GetOrdinal("ProjectName")),
                                                });
            }
        }

        /// <summary>
        /// Ts the generate category list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="categoryList">The category list.</param>
        private static void GenerateCategoryListFromReader(IDataReader returnData, ref List<Category> categoryList)
        {
            while (returnData.Read())
            {
                categoryList.Add(new Category
                        {
                            Id = returnData.GetInt32(returnData.GetOrdinal("CategoryId")),
                            ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                            Name = returnData.GetString(returnData.GetOrdinal("CategoryName")),
                            ChildCount = returnData.GetInt32(returnData.GetOrdinal("ChildCount")),
                            ParentCategoryId = returnData.GetInt32(returnData.GetOrdinal("ParentCategoryId")),
                        });
            }
        }

        /// <summary>
        /// Ts the generate issue attachment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueAttachmentList">The issue attachment list.</param>
        private static void GenerateIssueAttachmentListFromReader(IDataReader returnData, ref List<IssueAttachment> issueAttachmentList)
        {
            while (returnData.Read())
            {
                var attachment = new IssueAttachment
                                     {
                                         Id = returnData.GetInt32(returnData.GetOrdinal("IssueAttachmentId")),
                                         Attachment = null,
                                         Description = returnData.GetString(returnData.GetOrdinal("Description")),
                                         DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                                         ContentType = returnData.GetString(returnData.GetOrdinal("ContentType")),
                                         CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                                         CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                                         FileName = returnData.GetString(returnData.GetOrdinal("FileName")),
                                         IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                                         Size = returnData.GetInt32(returnData.GetOrdinal("FileSize"))
                                     };

                issueAttachmentList.Add(attachment);
            }
        }

        /// <summary>
        /// Ts the generate query clause list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryClauseList">The query clause list.</param>
        private static void GenerateQueryClauseListFromReader(IDataReader returnData, ref List<QueryClause> queryClauseList)
        {
            while (returnData.Read())
            {
                var queryClause = new QueryClause((string)returnData["BooleanOperator"], (string)returnData["FieldName"], (string)returnData["ComparisonOperator"], (string)returnData["FieldValue"], (SqlDbType)returnData["DataType"], (bool)returnData["IsCustomField"]);
                queryClauseList.Add(queryClause);
            }
        }

        /// <summary>
        /// Ts the generate query list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryList">The query list.</param>
        private static void GenerateQueryListFromReader(IDataReader returnData, ref List<Query> queryList)
        {
            while (returnData.Read())
            {
                queryList.Add(new Query
                                  {
                                      Id = returnData.GetInt32(returnData.GetOrdinal("QueryId")),
                                      Name = returnData.GetString(returnData.GetOrdinal("QueryName")),
                                      IsPublic = returnData.GetBoolean(returnData.GetOrdinal("IsPublic"))
                                  });
            }
        }

        /// <summary>
        /// Ts the generate required field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="requiredFieldList">The required field list.</param>
        private static void GenerateRequiredFieldListFromReader(SqlDataReader returnData, ref List<RequiredField> requiredFieldList)
        {
            while (returnData.Read())
            {
                var newRequiredField = new RequiredField(returnData["FieldName"].ToString(), returnData["FieldValue"].ToString());
                requiredFieldList.Add(newRequiredField);
            }
        }

        /// <summary>
        /// Ts the generate related issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="relatedIssueList">The related issue list.</param>
        private static void GenerateRelatedIssueListFromReader(IDataReader returnData, ref List<RelatedIssue> relatedIssueList)
        {
            while (returnData.Read())
            {
                var relatedIssue = new RelatedIssue
                                       {
                                           DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                                           IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                                           Resolution = DefaultIfNull(returnData["IssueResolution"], string.Empty),
                                           Status = DefaultIfNull(returnData["IssueStatus"], string.Empty), 
                                           Title = returnData.GetString(returnData.GetOrdinal("IssueTitle"))
                                       };

                relatedIssueList.Add(relatedIssue);
            }
        }

        /// <summary>
        /// Ts the generate issue revision list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="revisionList">The revision list.</param>
        private static void GenerateIssueRevisionListFromReader(IDataReader returnData, ref List<IssueRevision> revisionList)
        {
            while (returnData.Read())
            {
                revisionList.Add(new IssueRevision
                                    {
                                        Id = returnData.GetInt32(returnData.GetOrdinal("IssueRevisionId")),
                                        Author = returnData.GetString(returnData.GetOrdinal("RevisionAuthor")),
                                        DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                                        IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                                        Message = returnData.GetString(returnData.GetOrdinal("RevisionMessage")),
                                        Repository = returnData.GetString(returnData.GetOrdinal("Repository")),
                                        RevisionDate = returnData.GetString(returnData.GetOrdinal("RevisionDate")),
                                        Revision = returnData.GetInt32(returnData.GetOrdinal("Revision"))
                                    });
            }
        }

        /// <summary>
        /// Ts the generate milestone list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="milestoneList">The milestone list.</param>
        private static void GenerateMilestoneListFromReader(IDataReader returnData, ref List<Milestone> milestoneList)
        {
            while (returnData.Read())
            {
                var milestone = new Milestone
                                    {
                                        Id = returnData.GetInt32(returnData.GetOrdinal("MilestoneId")),
                                        ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                        Name = returnData.GetString(returnData.GetOrdinal("MilestoneName")),
                                        DueDate = returnData[returnData.GetOrdinal("MilestoneDueDate")] as DateTime?,
                                        ImageUrl = returnData.GetString(returnData.GetOrdinal("MilestoneImageUrl")),
                                        ReleaseDate = returnData[returnData.GetOrdinal("MilestoneReleaseDate")] as DateTime?,
                                        IsCompleted = returnData.GetBoolean(returnData.GetOrdinal("MilestoneCompleted")),
                                        Notes = returnData[returnData.GetOrdinal("MilestoneNotes")] as string ?? string.Empty,
                                        SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder"))
                                    };

                milestoneList.Add(milestone);
            }
        }

        /// <summary>
        /// Ts the generate priority list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="priorityList">The priority list.</param>
        private static void GeneratePriorityListFromReader(IDataReader returnData, ref List<Priority> priorityList)
        {
            while (returnData.Read())
            {
                priorityList.Add(new Priority
                                     {
                                         Id = returnData.GetInt32(returnData.GetOrdinal("PriorityId")),
                                         ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                         Name = returnData.GetString(returnData.GetOrdinal("PriorityName")),
                                         ImageUrl = returnData.GetString(returnData.GetOrdinal("PriorityImageUrl")),
                                         SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                                     });
            }
        }

        /// <summary>
        /// Ts the generate project mailbox list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectMailboxList">The project mailbox list.</param>
        private static void GenerateProjectMailboxListFromReader(IDataReader returnData, ref List<ProjectMailbox> projectMailboxList)
        {
            while (returnData.Read())
            {
                var mailbox = new ProjectMailbox
                                  {
                                      AssignToDisplayName = returnData.GetString(returnData.GetOrdinal("AssignToDisplayName")),
                                      AssignToId = returnData["AssignToUserId"] as Guid? ?? Guid.Empty,
                                      AssignToUserName = DefaultIfNull(returnData["AssignToUserName"], string.Empty),
                                      Id = returnData.GetInt32(returnData.GetOrdinal("ProjectMailboxId")),
                                      IssueTypeId = returnData.GetInt32(returnData.GetOrdinal("IssueTypeId")),
                                      IssueTypeName = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                                      Mailbox = returnData.GetString(returnData.GetOrdinal("Mailbox")),
                                      ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId"))
                                  };
                projectMailboxList.Add(mailbox);
            }
        }

        /// <summary>
        /// Ts the generate status list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="statusList">The status list.</param>
        private static void GenerateStatusListFromReader(IDataReader returnData, ref List<Status> statusList)
        {
            while (returnData.Read())
            {
                statusList.Add(new Status
                                   {
                                       Id = returnData.GetInt32(returnData.GetOrdinal("StatusId")),
                                       ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                       Name = returnData.GetString(returnData.GetOrdinal("StatusName")),
                                       SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                                       ImageUrl = returnData.GetString(returnData.GetOrdinal("StatusImageUrl")),
                                       IsClosedState = returnData.GetBoolean(returnData.GetOrdinal("IsClosedState"))
                                   });
            }
        }

        /// <summary>
        /// Ts the generate custom field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldList">The custom field list.</param>
        private static void GenerateCustomFieldListFromReader(IDataReader returnData, ref List<CustomField> customFieldList)
        {
            while (returnData.Read())
            {
                customFieldList.Add(new CustomField
                                        {
                                            Id = returnData.GetInt32(returnData.GetOrdinal("CustomFieldId")),
                                            ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                            Name = returnData.GetString(returnData.GetOrdinal("CustomFieldName")),
                                            DataType = (ValidationDataType)returnData["CustomFieldDataType"],
                                            FieldType = (CustomFieldType)returnData["CustomFieldTypeId"],
                                            Required = returnData.GetBoolean(returnData.GetOrdinal("CustomFieldRequired")),
                                            Value = returnData.GetString(returnData.GetOrdinal("CustomFieldValue")),
                                        });
            }
        }

        /// <summary>
        /// Ts the generate custom field selection list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldSelectionList">The custom field list.</param>
        private static void GenerateCustomFieldSelectionListFromReader(IDataReader returnData, ref List<CustomFieldSelection> customFieldSelectionList)
        {
            while (returnData.Read())
            {
                customFieldSelectionList.Add(new CustomFieldSelection
                                                 {
                                                     Id = returnData.GetInt32(returnData.GetOrdinal("CustomFieldSelectionId")),
                                                     CustomFieldId = returnData.GetInt32(returnData.GetOrdinal("CustomFieldId")),
                                                     Value = returnData.GetString(returnData.GetOrdinal("CustomFieldSelectionValue")),
                                                     Name = returnData.GetString(returnData.GetOrdinal("CustomFieldSelectionName")),
                                                     SortOrder = returnData.GetInt32(returnData.GetOrdinal("CustomFieldSelectionSortOrder")),
                                                 });
            }
        }

        /// <summary>
        /// Ts the generate issue type list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueTypeList">The issue type list.</param>
        private static void GenerateIssueTypeListFromReader(IDataReader returnData, ref List<IssueType> issueTypeList)
        {
            while (returnData.Read())
            {
                issueTypeList.Add(new IssueType
                                      {
                                          Id = returnData.GetInt32(returnData.GetOrdinal("IssueTypeId")),
                                          ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                          Name = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                                          SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                                          ImageUrl = returnData.GetString(returnData.GetOrdinal("IssueTypeImageUrl")),
                                      });
            }
        }

        /// <summary>
        /// Ts the generate issue time entry list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueWorkReportList">The issue time entry list.</param>
        private static void GenerateIssueTimeEntryListFromReader(IDataReader returnData, ref List<IssueWorkReport> issueWorkReportList)
        {
            while (returnData.Read())
            {
                issueWorkReportList.Add(new IssueWorkReport
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueWorkReportId")),
                    CommentId = returnData.GetInt32(returnData.GetOrdinal("IssueCommentId")),
                    CommentText = returnData.GetString(returnData.GetOrdinal("Comment")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    CreatorUserId = returnData.GetGuid(returnData.GetOrdinal("CreatorUserId")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),
                    Duration = returnData.GetDecimal(returnData.GetOrdinal("Duration")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    WorkDate = returnData.GetDateTime(returnData.GetOrdinal("WorkDate"))
                });
            }
        }

        /// <summary>
        /// Ts the generate resolution list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="resolutionList">The resolution list.</param>
        private static void GenerateResolutionListFromReader(SqlDataReader returnData, ref List<Resolution> resolutionList)
        {
            while (returnData.Read())
            {
                resolutionList.Add(new Resolution
                                       {
                                           Id = returnData.GetInt32(returnData.GetOrdinal("ResolutionId")),
                                           ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                                           Name = returnData.GetString(returnData.GetOrdinal("ResolutionName")),
                                           SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                                           ImageUrl = returnData.GetString(returnData.GetOrdinal("ResolutionImageUrl")),
                                       });
            }
        }

        /// <summary>
        /// Ts the generate application log list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="applicationLogList">The application log list.</param>
        private static void GenerateApplicationLogListFromReader(IDataReader returnData, ref List<ApplicationLog> applicationLogList)
        {
            while (returnData.Read())
            {
                var newAppLog = new ApplicationLog
                    {
                        Id = (int)returnData["Id"],
                        Date = (DateTime)returnData["Date"],
                        Thread = (string)returnData["Thread"],
                        Level = (string)returnData["Level"],
                        User = (string)returnData["User"],
                        Logger = (string)returnData["Logger"],
                        Message = (string)returnData["Message"],
                        Exception = (string)returnData["Exception"]
                    };

                applicationLogList.Add(newAppLog);
            }
        }

        private static Issue MapIssue(IDataRecord returnData)
        {
            var time = returnData["TimeLogged"].ToString();
            double timeLogged;
            double.TryParse(time, out timeLogged);

            return new Issue
            {
                AffectedMilestoneId = DefaultIfNull(returnData["IssueAffectedMilestoneId"], 0),
                AffectedMilestoneImageUrl = returnData.GetString(returnData.GetOrdinal("AffectedMilestoneImageUrl")),
                AffectedMilestoneName = returnData.GetString(returnData.GetOrdinal("AffectedMilestoneName")),

                AssignedDisplayName = returnData.GetString(returnData.GetOrdinal("AssignedDisplayName")),
                AssignedUserId = DefaultIfNull(returnData["IssueAssignedUserId"], Guid.Empty),
                AssignedUserName = returnData.GetString(returnData.GetOrdinal("AssignedUserName")),

                CategoryId = DefaultIfNull(returnData["IssueCategoryId"], 0),
                CategoryName = returnData.GetString(returnData.GetOrdinal("CategoryName")),

                CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                CreatorUserId = DefaultIfNull(returnData["IssueCreatorUserId"], Guid.Empty),
                CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),

                DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                Description = returnData.GetString(returnData.GetOrdinal("IssueDescription")),
                Disabled = returnData.GetBoolean(returnData.GetOrdinal("Disabled")),
                DueDate = DefaultIfNull(returnData["IssueDueDate"], DateTime.MinValue),
                Estimation = returnData.GetDecimal(returnData.GetOrdinal("IssueEstimation")),
                Id = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                IsClosed = returnData.GetBoolean(returnData.GetOrdinal("IsClosed")),

                IssueTypeId = DefaultIfNull(returnData["IssueTypeId"], 0),
                IssueTypeName = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                IssueTypeImageUrl = returnData.GetString(returnData.GetOrdinal("IssueTypeImageUrl")),

                LastUpdate = returnData.GetDateTime(returnData.GetOrdinal("LastUpdate")),
                LastUpdateDisplayName = returnData.GetString(returnData.GetOrdinal("LastUpdateDisplayName")),
                LastUpdateUserName = returnData.GetString(returnData.GetOrdinal("LastUpdateUserName")),

                MilestoneDueDate = DefaultIfNull(returnData["MilestoneDueDate"], DateTime.MinValue),
                MilestoneId = DefaultIfNull(returnData["IssueMilestoneId"], 0),
                MilestoneImageUrl = returnData.GetString(returnData.GetOrdinal("MilestoneImageUrl")),
                MilestoneName = returnData.GetString(returnData.GetOrdinal("MilestoneName")),

                OwnerDisplayName = returnData.GetString(returnData.GetOrdinal("OwnerDisplayName")),
                OwnerUserId = DefaultIfNull(returnData["IssueOwnerUserId"], Guid.Empty),
                OwnerUserName = returnData.GetString(returnData.GetOrdinal("OwnerUserName")),

                PriorityId = DefaultIfNull(returnData["IssuePriorityId"], 0),
                PriorityImageUrl = returnData.GetString(returnData.GetOrdinal("PriorityImageUrl")),
                PriorityName = returnData.GetString(returnData.GetOrdinal("PriorityName")),

                Progress = returnData.GetInt32(returnData.GetOrdinal("IssueProgress")),

                ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                ProjectCode = returnData.GetString(returnData.GetOrdinal("ProjectCode")),
                ProjectName = returnData.GetString(returnData.GetOrdinal("ProjectName")),

                ResolutionId = DefaultIfNull(returnData["IssueResolutionId"], 0),
                ResolutionImageUrl = returnData.GetString(returnData.GetOrdinal("ResolutionImageUrl")),
                ResolutionName = returnData.GetString(returnData.GetOrdinal("ResolutionName")),

                StatusId = DefaultIfNull(returnData["IssueStatusId"], 0),
                StatusImageUrl = returnData.GetString(returnData.GetOrdinal("StatusImageUrl")),
                StatusName = returnData.GetString(returnData.GetOrdinal("StatusName")),

                Title = returnData.GetString(returnData.GetOrdinal("IssueTitle")),
                TimeLogged = timeLogged,
                Visibility = returnData.GetInt32(returnData.GetOrdinal("IssueVisibility")),
                Votes = returnData.GetInt32(returnData.GetOrdinal("IssueVotes"))
            };
        }

        private static T DefaultIfNull<T>(object value, T defaultValue)
        {
            if (value == DBNull.Value) return defaultValue;

            return (T)value;
        }

        #endregion

    }
}