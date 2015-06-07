using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Configuration.Provider;
using System.Data;
using System.Data.SqlClient;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;
using Permission = BugNET.Entities.Permission;

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

        public override string ConnectionString
        {
            get { return _connectionString; }
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

        #region Default issue values methods
        /// <summary>
        /// Sets the default issue type by project id.
        /// </summary>
        /// <param name="defaultValue">The default value.</param>
        /// <returns></returns>
        /// <exception cref="System.ArgumentOutOfRangeException">projectId</exception>
        public override bool SetDefaultIssueTypeByProjectId(DefaultValue defaultVal)
        {
            // validate Parameters
            if (defaultVal.ProjectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            // Execute SQL Command
            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.ProjectId);
                AddParamToSqlCmd(sqlCmd, "@Type", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.IssueTypeId);
                AddParamToSqlCmd(sqlCmd, "@StatusId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.StatusId);
                AddParamToSqlCmd(sqlCmd, "@IssueOwnerUserName", SqlDbType.NText, 255, ParameterDirection.Input, defaultVal.OwnerUserName);
                AddParamToSqlCmd(sqlCmd, "@IssuePriorityId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.PriorityId);
                AddParamToSqlCmd(sqlCmd, "@IssueAffectedMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.AffectedMilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueAssignedUsername", SqlDbType.NText, 255, ParameterDirection.Input, defaultVal.AssignedUserName);
                AddParamToSqlCmd(sqlCmd, "@IssueVisibility", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.IssueVisibility);
                AddParamToSqlCmd(sqlCmd, "@IssueCategoryId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.CategoryId);
                AddParamToSqlCmd(sqlCmd, "@IssueDueDate", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.DueDate == null ? DBNull.Value : (object)defaultVal.DueDate);
                AddParamToSqlCmd(sqlCmd, "@IssueProgress", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.Progress);
                AddParamToSqlCmd(sqlCmd, "@IssueMilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.MilestoneId);
                AddParamToSqlCmd(sqlCmd, "@IssueEstimation", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.Estimation);
                AddParamToSqlCmd(sqlCmd, "@IssueResolutionId", SqlDbType.Int, 0, ParameterDirection.Input, defaultVal.ResolutionId);
                AddParamToSqlCmd(sqlCmd, "@StatusVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.StatusVisibility);
                AddParamToSqlCmd(sqlCmd, "@OwnedByVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.OwnedByVisibility);
                AddParamToSqlCmd(sqlCmd, "@PriorityVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PriorityVisibility);
                AddParamToSqlCmd(sqlCmd, "@AssignedToVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.AssignedToVisibility);
                AddParamToSqlCmd(sqlCmd, "@PrivateVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PrivateVisibility);
                AddParamToSqlCmd(sqlCmd, "@CategoryVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.CategoryVisibility);
                AddParamToSqlCmd(sqlCmd, "@DueDateVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.DueDateVisibility);
                AddParamToSqlCmd(sqlCmd, "@TypeVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.TypeVisibility);
                AddParamToSqlCmd(sqlCmd, "@PercentCompleteVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PercentCompleteVisibility);
                AddParamToSqlCmd(sqlCmd, "@MilestoneVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.MilestoneVisibility);
                AddParamToSqlCmd(sqlCmd, "@EstimationVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.EstimationVisibility);
                AddParamToSqlCmd(sqlCmd, "@ResolutionVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.ResolutionVisibility);
                AddParamToSqlCmd(sqlCmd, "@AffectedMilestoneVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.AffectedMilestoneVisibility);
                AddParamToSqlCmd(sqlCmd, "@StatusEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.StatusEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@OwnedByEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.OwnedByEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@PriorityEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PriorityEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@AssignedToEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.AssignedToEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@PrivateEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PrivateEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@CategoryEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.CategoryEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@DueDateEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.DueDateEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@TypeEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.TypeEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@PercentCompleteEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.PercentCompleteEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@MilestoneEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.MilestoneEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@EstimationEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.EstimationEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@ResolutionEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.ResolutionEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@AffectedMilestoneEditVisibility", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.AffectedMilestoneEditVisibility);
                AddParamToSqlCmd(sqlCmd, "@OwnedByNotify", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.OwnedByNotify);
                AddParamToSqlCmd(sqlCmd, "@AssignedToNotify", SqlDbType.Bit, 0, ParameterDirection.Input, defaultVal.AssignedToNotify);


                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_DEFAULTVALUES_SET);
                ExecuteScalarCmd(sqlCmd);

                int returnValue = (int)sqlCmd.Parameters["@ReturnValue"].Value;
                return (returnValue == 0 ? true : false);
            }
        }

        /// <summary>
        /// Gets the default issue type by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        /// <exception cref="System.ArgumentOutOfRangeException">projectId</exception>
        public override List<DefaultValue> GetDefaultIssueTypeByProjectId(int projectId)
        {
            // validate Parameters
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            // Execute SQL Command
            SqlCommand sqlCmd = new SqlCommand();

            AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);

            SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_DEFAULTVALUES_GETBYPROJECTID);
            List<DefaultValue> defaultValueList = new List<DefaultValue>();
            ExecuteReaderCmd(sqlCmd, TGenerateDefaultValueListFromReader<DefaultValue>, ref defaultValueList);
            return defaultValueList;
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
            return this.GetUsersByProjectId(projectId, false);
        }

        /// <summary>
        /// Gets the users by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="excludeReadOnlyUsers">if set to <c>true</c> [exclude read only users].</param>
        /// <returns></returns>
        public override List<ITUser> GetUsersByProjectId(int projectId, bool excludeReadOnlyUsers = false)
        {
            using (var sqlCmd = new SqlCommand())
            {
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_USER_GETUSERSBYPROJECTID);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@ExcludeReadonlyUsers", SqlDbType.Bit, 0, ParameterDirection.Input, excludeReadOnlyUsers);

                var userList = new List<ITUser>();
                ExecuteReaderCmd(sqlCmd, GenerateUserListFromReader, ref userList);
                return userList;
            }
        }

        /// <summary>
        /// Gets the user name by password reset token.
        /// </summary>
        /// <param name="token">The token.</param>
        /// <returns></returns>
        public override string GetUserNameByPasswordResetToken(string token)
        {
            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@Token", SqlDbType.NVarChar, 0, ParameterDirection.Input, token);
                AddParamToSqlCmd(sqlCmd, "@UserName", SqlDbType.NVarChar, 255, ParameterDirection.Output, null);
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_USER_GETUSERNAMEBYPASSWORDRESETTOKEN);
                ExecuteScalarCmd(sqlCmd);
                var returnValue = (string)sqlCmd.Parameters["@UserName"].Value;

                return returnValue;
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
                AddParamToSqlCmd(sqlCmd, "@ProjectName", SqlDbType.NText, 256, ParameterDirection.Input, newProject.Name);
                AddParamToSqlCmd(sqlCmd, "@ProjectDescription", SqlDbType.NText, 1000, ParameterDirection.Input, newProject.Description);
                AddParamToSqlCmd(sqlCmd, "@ProjectManagerUserName", SqlDbType.NVarChar, 0, ParameterDirection.Input, newProject.ManagerUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectCreatorUserName", SqlDbType.NText, 255, ParameterDirection.Input, newProject.CreatorUserName);
                AddParamToSqlCmd(sqlCmd, "@ProjectAccessType", SqlDbType.Int, 0, ParameterDirection.Input, newProject.AccessType);
                AddParamToSqlCmd(sqlCmd, "@AttachmentUploadPath", SqlDbType.NVarChar, 80, ParameterDirection.Input, newProject.UploadPath);
                AddParamToSqlCmd(sqlCmd, "@ProjectCode", SqlDbType.NVarChar, 80, ParameterDirection.Input, newProject.Code);
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
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

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
        public override List<Project> GetAllProjects(bool? activeOnly = true)
        {
            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@ActiveOnly", SqlDbType.Bit, 0, ParameterDirection.Input, activeOnly);
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
        /// <param name="creatorUserName">The user who cloned the project</param>
        /// <returns></returns>
        public override int CloneProject(int projectId, string projectName, string creatorUserName = "")
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
                    AddParamToSqlCmd(sqlCmd, "@CloningUserName", SqlDbType.VarChar, 0, ParameterDirection.Input, creatorUserName);
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
        /// Validates if the requesting user can download the attachment
        /// </summary>
        /// <param name="attachmentId">The attachment id to fetch</param>
        /// <param name="requestingUser">The requesting user name</param>
        /// <returns>An attachment if the security checks pass</returns>
        /// <remarks>
        /// The following defines the logic for a attachment id NOT to be returned
        /// <list type="number">
        /// <item><description>When the requestor is anon and anon access is disabled</description></item>
        /// <item><description>When the project or the issue is deleted / disabled</description></item>
        /// <item><description>When the project is private and (the requestor does not have project access or elevated permissions)</description></item>
        /// <item><description>When the issue is private and (the requestor is neither the creator of the issue or (assigned to the issue when anon access is off)) or (the requestor does not have elevated permissions)</description></item>
        /// </list>
        /// </remarks>
        public override IssueAttachment GetAttachmentForDownload(int attachmentId, string requestingUser = "")
        {
            if (attachmentId <= 0) throw (new ArgumentOutOfRangeException("attachmentId"));

            try
            {
                using (var sqlCmd = new SqlCommand())
                {
                    AddParamToSqlCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 0, ParameterDirection.ReturnValue, null);
                    AddParamToSqlCmd(sqlCmd, "@IssueAttachmentId", SqlDbType.Int, 0, ParameterDirection.Input, attachmentId);
                    AddParamToSqlCmd(sqlCmd, "@RequestingUser", SqlDbType.VarChar, 0, ParameterDirection.Input, requestingUser);

                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUEATTACHMENT_VALIDATEDOWNLOAD);
                    ExecuteNonQuery(sqlCmd);

                    attachmentId = ((int)sqlCmd.Parameters["@ReturnValue"].Value);

                    return GetIssueAttachmentById(attachmentId);
                }
            }
            catch (Exception ex)
            {
                var message = ex.Message.Trim();

                if (!message.StartsWith("BNCode")) throw ProcessException(ex);

                var statusCode = Utilities.ParseDatabaseStatusCode(ex.Message);
                throw new DataAccessException(ex.Message, statusCode);
            }
        }

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
                cmdClause.Parameters.Add("@CustomFieldId", SqlDbType.Int);

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
                    cmdClause.Parameters["@CustomFieldId"].Value = clause.CustomFieldId;
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
                cmdClause.Parameters.Add("@CustomFieldId", SqlDbType.Int);

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
                    cmdClause.Parameters["@CustomFieldId"].Value = clause.CustomFieldId;
                    ExecuteScalarCmd(cmdClause);
                }

                return true;   
            }
        }

        /// <summary>
        /// Performs the saved query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public override List<Issue> PerformSavedQuery(int projectId, int queryId, ICollection<KeyValuePair<string, string>> sortFields)
        {
            // Validate Parameters
            if (queryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("queryId"));
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@QueryId", SqlDbType.Int, 0, ParameterDirection.Input, queryId);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_QUERY_GETSAVEDQUERY);

                var queryClauses = new List<QueryClause>();

                // add the disabled query filter since the UI cannot add this
                queryClauses.Insert(0, new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int));

                ExecuteReaderCmd(sqlCmd, GenerateQueryClauseListFromReader, ref queryClauses);

                return PerformQuery(queryClauses, sortFields, projectId);   
            }
        }


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
                    AddParamToSqlCmd(sqlCmd, "@Changeset", SqlDbType.NVarChar, 100, ParameterDirection.Input, newIssueRevision.Changeset);
                    AddParamToSqlCmd(sqlCmd, "@Branch", SqlDbType.NVarChar, 255, ParameterDirection.Input, newIssueRevision.Branch);

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
                AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.CategoryId);

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
                AddParamToSqlCmd(sqlCmd, "@CategoryId", SqlDbType.Int, 0, ParameterDirection.Input, mailboxToUpdate.CategoryId);

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
                sqlCmd.Parameters.Add("@CustomFieldValue", SqlDbType.NVarChar).Direction = ParameterDirection.Input;

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
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionName", SqlDbType.NVarChar, 255, ParameterDirection.Input, customFieldSelectionToUpdate.Name);
                AddParamToSqlCmd(sqlCmd, "@CustomFieldSelectionValue", SqlDbType.NVarChar, 255, ParameterDirection.Input, customFieldSelectionToUpdate.Value);
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="projectId"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public override List<IssueWorkReport> GetIssueWorkReportsByProjectId(int projectId)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="projectId"></param>
        /// <param name="reporterUserName"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
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

    }
}