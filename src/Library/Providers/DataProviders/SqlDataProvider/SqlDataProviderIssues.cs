using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.Providers.DataProviders
{
    public partial class SqlDataProvider
    {
        /// <summary>
        /// Updates the issues last updated fields.
        /// </summary>
        /// <param name="issueId">The id of the issue to update</param>
        /// <param name="lastUpdatedUsername">The username of the indivisual triggering the update</param>
        /// <returns></returns>
        public override bool UpdateIssueLastUpdated(int issueId, string lastUpdatedUsername)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentNullException("issueId"));
            if (string.IsNullOrEmpty(lastUpdatedUsername.Trim())) throw (new ArgumentNullException("lastUpdatedUsername"));

            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@IssueId", SqlDbType.Int, 0, ParameterDirection.Input, issueId);
                AddParamToSqlCmd(sqlCmd, "@LastUpdateUserName", SqlDbType.NText, 255, ParameterDirection.Input, lastUpdatedUsername);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_ISSUE_UPDATELASTUPDATED);
                ExecuteNonQuery(sqlCmd);
                return true;
            }
        }

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
                using (var sqlCmd = new SqlCommand())
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

        
        public override List<Issue> GetMonitoredIssuesByUserName(object userId, ICollection<KeyValuePair<string, string>> sortFields, List<int> projects, bool excludeClosedStatus)
        {
            if (userId == null) throw (new ArgumentNullException("userId"));

            using (var sqlCmd = new SqlCommand())
            {
                var sortSql = string.Empty;
                string sql = "SELECT iv.*, bin.UserId AS NotificationUserId, uv.UserName AS NotificationUserName, uv.DisplayName AS NotificationDisplayName FROM BugNet_IssuesView iv " +
                    "INNER JOIN BugNet_IssueNotifications bin ON iv.IssueId = bin.IssueId INNER JOIN BugNet_UserView uv ON bin.UserId = uv.UserId  WHERE bin.UserId = @NotificationUserId " +
                    "AND iv.[Disabled] = 0 AND iv.ProjectDisabled = 0 AND ((@ExcludeClosedStatus = 0) OR (iv.IsClosed = 0)) ";

                if (projects.Count > 0)
                {
                    var first = true;

                    foreach (var project in projects)
                    {
                        sql += (first) ? " AND (" : " OR ";
                        sql += "iv.[ProjectId] = " + project.ToString();
                        first = false;
                    }

                    sql += ")";
                }

                // build the sort string (if any)
                if (sortFields != null)
                {
                    foreach (var keyValuePair in sortFields)
                    {
                        var field = keyValuePair.Key.Trim();

                        // no field then no sort option
                        if (field.Length.Equals(0)) continue;

                        // lower the direction
                        var direction = keyValuePair.Value.Trim().ToLowerInvariant();

                        // check if the direction is valid
                        if (!direction.Equals("asc") && !direction.Equals("desc"))
                            direction = "asc";

                        // if the field contains a period then they might be passing in and alias so don't try and clean up
                        if (!field.Contains("."))
                        {
                            field = field.Replace("[]", " ").Trim();    // this is used as a placeholder for spaces in custom
                            // fields used only for sorting

                            if (!field.EndsWith("]"))
                                field = string.Concat(field, "]");

                            if (!field.EndsWith("["))
                                field = string.Concat("[", field);
                        }

                        // build proper sort string
                        sortSql = string.Concat(sortSql, " ", field, " ", direction, ",").Trim();
                    }
                }

                // set a default sort if no sort fields
                if (sortFields == null || sortFields.Count.Equals(0))
                {
                    sortSql = "iv.[IssueId] desc";
                }

                sortSql = sortSql.TrimEnd(',');
                sortSql = sortSql.Insert(0, "ORDER BY ");
                sql += sortSql;
                
                sqlCmd.CommandText = sql;
                AddParamToSqlCmd(sqlCmd, "@NotificationUserId", SqlDbType.UniqueIdentifier, 255, ParameterDirection.Input, userId);
                AddParamToSqlCmd(sqlCmd, "@ExcludeClosedStatus", SqlDbType.Bit, 0, ParameterDirection.Input, excludeClosedStatus);

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
    }
}
