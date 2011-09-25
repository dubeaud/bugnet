using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class IssueHistoryManager
    {
        /// <summary>
        /// Saves the issue history.
        /// </summary>
        /// <param name="issueHistoryToSave">The issue history to save.</param>
        /// <returns></returns>
        public static bool SaveIssueHistory(IssueHistory issueHistoryToSave)
        {
            if (issueHistoryToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewIssueHistory(issueHistoryToSave);
                if (TempId > 0)
                {
                    issueHistoryToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }

        #region Static Methods
        /// <summary>
        /// Gets the BugHistory by bug id.
        /// </summary>
        /// <param name="bugId">The bug id.</param>
        /// <returns></returns>
        public static List<IssueHistory> GetIssueHistoryByIssueId(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueHistoryByIssueId(issueId);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 
        /// 
        /// Performs a query containing any number of query clauses on a certain projectID
        /// </summary>
        /// <param name="issueId"></param>
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        public static List<IssueHistory> PerformQuery(int issueID, List<QueryClause> QueryClauses)
        {
            if (issueID < 0)
                throw new ArgumentOutOfRangeException("projectID must be bigger than 0");
            QueryClauses.Add(new QueryClause("AND", "IssueID", "=", issueID.ToString(), System.Data.SqlDbType.Int, false));

            return PerformQuery(QueryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueHistory table, regardless of 
        /// project level privledges. 
        /// </summary>        
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        public static List<IssueHistory> PerformQuery(List<QueryClause> QueryClauses)
        {
            if (QueryClauses == null)
                throw new ArgumentNullException("QueryClauses");

            List<IssueHistory> lst = new List<IssueHistory>();
            DataProviderManager.Provider.PerformGenericQuery<IssueHistory>(ref lst, QueryClauses, @"SELECT DISTINCT a.*, c.ProjectID as ProjectID, b.UserName as CreatorUserName, b.UserName as CreatorDisplayName from BugNet_IssueHistory as a, aspnet_Users as b, BugNet_Issues as d, BugNet_Projects as c  WHERE c.ProjectId=d.ProjectId AND d.IssueID=a.IssueID AND a.UserId=b.UserID AND ( 1=1 ", @" ) ORDER BY IssueHistoryId DESC");

            return lst;
        }
        #endregion
    }
}
