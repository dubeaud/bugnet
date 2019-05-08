// -----------------------------------------------------------------------
// <copyright file="SqlDataProviderPro.cs" company="Code Ascent">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.Providers.DataProviders
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using BugNET.Entities;
    using System.Data;
    using System.Data.SqlClient;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public partial class SqlDataProvider
    {
        // Reports
        private const string SP_REPORTS_MILESTONEBURNUP = "BugNet_Reports_MilestoneBurnup";
        private const string SP_REPORTS_BURNDOWN = "BugNet_Reports_Burndown";
        private const string SP_REPORTS_ISSUETREND = "BugNet_Reports_IssueTrend";
        private const string SP_REPORTS_GETCLOSEDISSUECOUNTBYDATE = "BugNet_Reports_GetClosedIssueCountByDate";
        private const string SP_REPORTS_GETOPENISSUECOUNTBYDATE = "BugNet_Reports_GetOpenIssueCountByDate";
        private const string SP_REPORTS_TIMELOGGED = "BugNet_Reports_TimeLogged";
        private const string SP_REPORTS_ISSUESBYPRIORITY = "BugNet_Reports_IssuesByPriority";

        private const string SP_WIKI_GETBYVERSION = "BugNet_Wiki_GetByVersion";
        private const string SP_WIKI_GETBYID = "BugNet_Wiki_GetById";
        private const string SP_WIKI_GETBYSLUGANDTITLE = "BugNet_Wiki_GetBySlugAndTitle";
        private const string SP_WIKI_SAVE = "BugNet_Wiki_Save";
        private const string SP_WIKI_GETHISTORY = "BugNet_Wiki_GetHistory";
        private const string SP_WIKI_DELETE = "BugNet_Wiki_Delete";


        #region Reports
        /// <summary>
        /// Gets the milestone burnup report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override List<MilestoneBurnup> GetMilestoneBurnupReport(int projectId)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_MILESTONEBURNUP);

                List<MilestoneBurnup> milestoneBurnupList = new List<MilestoneBurnup>();
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                ExecuteReaderCmd<MilestoneBurnup>(sqlCmd, GenerateMilestoneBurnupListFromReader, ref milestoneBurnupList);

                return milestoneBurnupList;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }


        /// <summary>
        /// Gets the milestone burndown report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public override List<MilestoneBurndown> GetMilestoneBurndownReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_BURNDOWN);

                List<MilestoneBurndown> milestoneBurndownList = new List<MilestoneBurndown>();
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                AddParamToSqlCmd(sqlCmd, "@Start", SqlDbType.DateTime, 0, ParameterDirection.Input, startDate);
                AddParamToSqlCmd(sqlCmd, "@End", SqlDbType.DateTime, 0, ParameterDirection.Input, endDate);
                ExecuteReaderCmd<MilestoneBurndown>(sqlCmd, GenerateMilestoneBurndownListFromReader, ref milestoneBurndownList);

                return milestoneBurndownList;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issue trend report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public override List<IssueTrend> GetIssueTrendReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_ISSUETREND);

                List<IssueTrend> issueTrendList = new List<IssueTrend>();
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                AddParamToSqlCmd(sqlCmd, "@Start", SqlDbType.DateTime, 0, ParameterDirection.Input, startDate);
                AddParamToSqlCmd(sqlCmd, "@End", SqlDbType.DateTime, 0, ParameterDirection.Input, endDate);
                ExecuteReaderCmd<IssueTrend>(sqlCmd, GenerateIssueTrendListFromReader, ref issueTrendList);

                return issueTrendList;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the issues by priority report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public override List<Issue> GetIssuesByPriorityReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_ISSUESBYPRIORITY);

                List<Issue> issueList = new List<Issue>();
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                AddParamToSqlCmd(sqlCmd, "@Start", SqlDbType.DateTime, 0, ParameterDirection.Input, startDate);
                AddParamToSqlCmd(sqlCmd, "@End", SqlDbType.DateTime, 0, ParameterDirection.Input, endDate);
                ExecuteReaderCmd<Issue>(sqlCmd, GenerateIssueListFromReader, ref issueList);

                return issueList;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the time logged report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public override List<TimeLogged> GetTimeLoggedReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_TIMELOGGED);

                List<TimeLogged> timeLoggedList = new List<TimeLogged>();
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@MilestoneId", SqlDbType.Int, 0, ParameterDirection.Input, milestoneId);
                AddParamToSqlCmd(sqlCmd, "@Start", SqlDbType.DateTime, 0, ParameterDirection.Input, startDate);
                AddParamToSqlCmd(sqlCmd, "@End", SqlDbType.DateTime, 0, ParameterDirection.Input, endDate);
                ExecuteReaderCmd<TimeLogged>(sqlCmd, GenerateTimeLoggedListFromReader, ref timeLoggedList);

                return timeLoggedList;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }
       

        /// <summary>
        /// Gets the closed issue count by date.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override Dictionary<DateTime, int> GetClosedIssueCountByDate(int projectId)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_GETCLOSEDISSUECOUNTBYDATE);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                Dictionary<DateTime, int> Values = new Dictionary<DateTime, int>();
                using (var cn = new SqlConnection(_connectionString))
                {
                    sqlCmd.Connection = cn;
                    cn.Open();
                    using (IDataReader dr = sqlCmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            Values.Add(Convert.ToDateTime(dr[0]), (int)dr[1]);
                        }
                    }

                }

                return Values;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }

        /// <summary>
        /// Gets the open issue count by date.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public override Dictionary<DateTime, int> GetOpenIssueCountByDate(int projectId)
        {
            try
            {
                SqlCommand sqlCmd = new SqlCommand();
                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_REPORTS_GETOPENISSUECOUNTBYDATE);

                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                Dictionary<DateTime, int> Values = new Dictionary<DateTime, int>();
                using (var cn = new SqlConnection(_connectionString))
                {
                    sqlCmd.Connection = cn;
                    cn.Open();
                    using (IDataReader dr = sqlCmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            Values.Add(Convert.ToDateTime(dr[0]), (int)dr[1]);
                        }
                    }

                }

                return Values;
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }

        }

        

        /// <summary>
        /// Generates the milestone burnup list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="milestoneBurnupList">The milestone burnup list.</param>
        private static void GenerateMilestoneBurnupListFromReader(IDataReader returnData, ref List<MilestoneBurnup> milestoneBurnupList)
        {
            while (returnData.Read())
            {
                var newMilestoneBurnup = new MilestoneBurnup
                {
                    MilestoneName = (string)returnData["MilestoneName"],
                    TotalCompleted = (decimal)returnData["TotalComplete"],
                    TotalHours = (decimal)returnData["TotalHours"]
                };

                milestoneBurnupList.Add(newMilestoneBurnup);
            }
        }

        /// <summary>
        /// Generates the time logged list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="timeLoggedList">The time logged list.</param>
        private static void GenerateTimeLoggedListFromReader(IDataReader returnData, ref List<TimeLogged> timeLoggedList)
        {
            while (returnData.Read())
            {
                var newTimeLogged = new TimeLogged
                {
                    TotalHours = (decimal)returnData["TotalHours"],
                    DisplayName = (string)returnData["DisplayName"],
                    ProjectId = (int)returnData["ProjectId"],
                    WorkDate = (DateTime)returnData["WorkDate"],
                    UserId = (Guid)returnData["UserId"]
                };

                timeLoggedList.Add(newTimeLogged);
            }
        }

        /// <summary>
        /// Generates the milestone burndown list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="milestoneBurndownList">The milestone burndown list.</param>
        private static void GenerateMilestoneBurndownListFromReader(IDataReader returnData, ref List<MilestoneBurndown> milestoneBurndownList)
        {
            while (returnData.Read())
            {
                var newMilestoneBurndown = new MilestoneBurndown
                {
                    Date = (DateTime)returnData["Date"],
                    Ideal = (double)returnData["Ideal"],
                    Remaining = (double)returnData["Remaining"]
                };

                milestoneBurndownList.Add(newMilestoneBurndown);
            }
        }

        /// <summary>
        /// Generates the issue activity list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueActivityList">The issue activity list.</param>
        private static void GenerateIssueTrendListFromReader(IDataReader returnData, ref List<IssueTrend> issueTrendList)
        {
            while (returnData.Read())
            {
                var newIssueTrendList = new IssueTrend
                {
                    Date = (DateTime)returnData["Date"],
                    CumulativeOpen = (int)returnData["CumulativeOpened"],
                    CumulativeClosed = (int)returnData["CumulativeClosed"],
                    TotalActive = (int)returnData["TotalActive"]
             
                };

                issueTrendList.Add(newIssueTrendList);
            }
        }
        #endregion

        #region Wiki

        /// <summary>
        /// Gets the content of the wiki.
        /// </summary>
        /// <param name="slug">The slug.</param>
        /// <param name="title">The title.</param>
        /// <returns></returns>
        public override WikiContent GetWikiContent(int projectId, string slug, string title)
        {
            try
            {
                using (SqlCommand sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_GETBYSLUGANDTITLE);

                    List<WikiContent> wikiContentList = new List<WikiContent>();
                    AddParamToSqlCmd(sqlCmd, "@Slug", SqlDbType.NVarChar, 255, ParameterDirection.Input, slug);
                    AddParamToSqlCmd(sqlCmd, "@Title", SqlDbType.NVarChar,255, ParameterDirection.Input, title);
                    AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                    ExecuteReaderCmd<WikiContent>(sqlCmd, GenerateWikiContentListFromReader, ref wikiContentList);

                    return wikiContentList.Count > 0 ? wikiContentList[0] : null;
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the wiki content by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public override WikiContent GetWikiContent(int id)
        {
            try
            {
                using (SqlCommand sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_GETBYID);

                    List<WikiContent> wikiContentList = new List<WikiContent>();
                    AddParamToSqlCmd(sqlCmd, "@Id", SqlDbType.Int, 0, ParameterDirection.Input, id);
                    ExecuteReaderCmd<WikiContent>(sqlCmd, GenerateWikiContentListFromReader, ref wikiContentList);

                    return wikiContentList.Count > 0 ? wikiContentList[0] : null;
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the wiki content by version.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="version">The version.</param>
        /// <returns></returns>
        public override WikiContent GetWikiContentByVersion(int id, int version)
        {
            try
            {
                using (SqlCommand sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_GETBYVERSION);

                   List<WikiContent> wikiContentList = new List<WikiContent>();
                    AddParamToSqlCmd(sqlCmd, "@Id", SqlDbType.Int, 0, ParameterDirection.Input, id);
                    AddParamToSqlCmd(sqlCmd, "@Version", SqlDbType.Int, 0, ParameterDirection.Input, version);
                    ExecuteReaderCmd<WikiContent>(sqlCmd, GenerateWikiContentListFromReader, ref wikiContentList);

                    return wikiContentList.Count > 0 ? wikiContentList[0] : null;
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Gets the wiki content history.
        /// </summary>
        /// <param name="titleId">The title id.</param>
        /// <returns></returns>
        public override List<WikiContent> GetWikiContentHistory(int titleId)
        {
            try
            {
                using (SqlCommand sqlCmd = new SqlCommand())
                { 
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_GETHISTORY);

                    List<WikiContent> wikiContentList = new List<WikiContent>();
                    AddParamToSqlCmd(sqlCmd, "@Id", SqlDbType.Int, 0, ParameterDirection.Input, titleId);
                    ExecuteReaderCmd<WikiContent>(sqlCmd, GenerateWikiContentListFromReader, ref wikiContentList);

                    return wikiContentList;
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Saves the content of the wiki.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="id">The id.</param>
        /// <param name="slug">The slug.</param>
        /// <param name="title">The title.</param>
        /// <param name="source">The source.</param>
        /// <returns></returns>
        public override int SaveWikiContent(int projectId, int id, string slug, string title, string source, string createdByUserName)
        {
            using (var sqlCmd = new SqlCommand())
            {
                AddParamToSqlCmd(sqlCmd, "@TitleId", SqlDbType.Int, 0, ParameterDirection.Input, id);
                AddParamToSqlCmd(sqlCmd, "@ProjectId", SqlDbType.Int, 0, ParameterDirection.Input, projectId);
                AddParamToSqlCmd(sqlCmd, "@Slug", SqlDbType.NVarChar, 2555, ParameterDirection.Input, slug);
                AddParamToSqlCmd(sqlCmd, "@Name", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
                AddParamToSqlCmd(sqlCmd, "@Source", SqlDbType.NVarChar, 0, ParameterDirection.Input, source);
                AddParamToSqlCmd(sqlCmd, "@CreatedByUserName", SqlDbType.NVarChar, 255, ParameterDirection.Input, createdByUserName);

                SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_SAVE);
                return (int)ExecuteScalarCmd(sqlCmd);
            }
            
        }

        /// <summary>
        /// Deletes the content of the wiki.
        /// </summary>
        /// <param name="id">The id.</param>
        public override void DeleteWikiContent(int id)
        {
            try
            {
                using (SqlCommand sqlCmd = new SqlCommand())
                {
                    SetCommandType(sqlCmd, CommandType.StoredProcedure, SP_WIKI_DELETE);

                    List<WikiContent> wikiContentList = new List<WikiContent>();
                    AddParamToSqlCmd(sqlCmd, "@Id", SqlDbType.Int, 0, ParameterDirection.Input, id);
                    ExecuteNonQuery(sqlCmd);
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Generates the wiki content list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="wikiContentList">The wiki content list.</param>
         private static void GenerateWikiContentListFromReader(IDataReader returnData, ref List<WikiContent> wikiContentList)
         {
             while (returnData.Read())
             {
                wikiContentList.Add(new WikiContent
                    {
                        Id = returnData.GetInt32(0),
                        Source = returnData.GetString(1),
                        Version = returnData.GetInt32(2),
                        VersionDate = returnData.GetDateTime(3),
                        Title = new WikiTitle
                        {
                            Id = returnData.GetInt32(4),
                            Name = returnData.GetString(5),
                            Slug = returnData.GetString(6),
                            MaxVersion = returnData.GetInt32(7),
                            ProjectId = returnData.GetInt32(8)
                        },
                        CreatorUserId = returnData.GetGuid(9),
                        CreatorDisplayName = returnData.GetString(10)
                     }
                );

             }
         }     
        #endregion

        #region Install
         /// <summary>
         /// Gets the name of the product.
         /// </summary>
         /// <returns></returns>
         public override string GetProductName()
         {
             string currentVersion;

             using (var sqlCmd = new SqlCommand())
             {
                 
                try
                {
                    SetCommandType(sqlCmd, CommandType.Text, "SELECT SettingValue FROM BugNet_HostSettings WHERE SettingName='ProductName'");
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

             return currentVersion;
         }
        
        #endregion
    }
}
