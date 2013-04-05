namespace BugNET.Providers.DataProviders
{
    public partial class SqlDataProvider
    {
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
        private const string SP_ISSUE_UPDATELASTUPDATED = "BugNet_Issue_UpdateLastUpdated";

        private const string SP_ISSUE_GETISSUEMILESTONECOUNTBYPROJECT = "BugNet_Issue_GetIssueMilestoneCountByProject";

        private const string SP_ISSUE_GETISSUESTATUSCOUNTBYPROJECT = "BugNet_Issue_GetIssueStatusCountByProject";
        private const string SP_ISSUE_GETISSUEPRIORITYCOUNTBYPROJECT = "BugNet_Issue_GetIssuePriorityCountByProject";
        private const string SP_ISSUE_GETISSUEUSERCOUNTBYPROJECT = "BugNet_Issue_GetIssueUserCountByProject";
        private const string SP_ISSUE_GETISSUEUNASSIGNEDCOUNTBYPROJECT = "BugNet_Issue_GetIssueUnassignedCountByProject";
        private const string SP_ISSUE_GETISSUEUNSCHEDULEDMILESTONECOUNTBYPROJECT = "BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject";
        private const string SP_ISSUE_GETISSUETYPECOUNTBYPROJECT = "BugNet_Issue_GetIssueTypeCountByProject";
        private const string SP_ISSUE_GETISSUECATEGORYCOUNTBYPROJECT = "BugNet_Issue_GetIssueCategoryCountByProject";
        private const string SP_ISSUE_GETOPENISSUES = "BugNet_Issue_GetOpenIssues";

        private const string SP_DEFAULTVALUES_SET = "BugNet_DefaultValues_Set";
        private const string SP_DEFAULTVALUES_GETBYPROJECTID = "BugNet_DefaultValues_GetByProjectId";

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
        private const string SP_ISSUEATTACHMENT_VALIDATEDOWNLOAD = "BugNet_IssueAttachment_ValidateDownload";

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
    }
}
