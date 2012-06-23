using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueHistoryManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves the issue history.
        /// </summary>
        /// <param name="issueHistoryToSave">The issue history to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueHistory issueHistoryToSave)
        {
            if (issueHistoryToSave.Id > Globals.NEW_ID) return false;

            var tempId = DataProviderManager.Provider.CreateNewIssueHistory(issueHistoryToSave);

            if (tempId <= 0) return false;

            issueHistoryToSave.Id = tempId;

            if (issueHistoryToSave.TriggerLastUpdateChange)
                DataProviderManager.Provider.UpdateIssueLastUpdated(issueHistoryToSave.IssueId, Security.GetUserName());

            return true;
        }

        /// <summary>
        /// Gets the BugHistory by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<IssueHistory> GetByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueHistoryByIssueId(issueId);
        }

        ///// <summary>
        ///// Stewart Moss
        ///// Apr 14 2010 
        ///// 
        ///// Performs a query containing any number of query clauses on a certain projectID
        ///// </summary>
        ///// <param name="issueId"></param>
        ///// <param name="queryClauses"></param>
        ///// <returns></returns>
        //public static List<IssueHistory> PerformQuery(int issueId, List<QueryClause> queryClauses)
        //{
        //    if (issueId < 0) throw new ArgumentOutOfRangeException("issueId", "Issue id must be bigger than 0");

        //    queryClauses.Add(new QueryClause("AND", "IssueID", "=", issueId.ToString(), System.Data.SqlDbType.Int, false));

        //    return PerformQuery(queryClauses);
        //}

        ///// <summary>
        ///// Stewart Moss
        ///// Apr 14 2010 8:30 pm
        ///// 
        ///// Performs any query containing any number of query clauses
        ///// WARNING! Will expose the entire IssueHistory table, regardless of 
        ///// project level privledges. 
        ///// </summary>        
        ///// <param name="queryClauses"></param>
        ///// <returns></returns>
        //public static List<IssueHistory> PerformQuery(List<QueryClause> queryClauses)
        //{
        //    if (queryClauses == null) throw new ArgumentNullException("queryClauses");

        //    var lst = new List<IssueHistory>();
        //    DataProviderManager.Provider.PerformGenericQuery(ref lst, queryClauses, @"SELECT DISTINCT a.*, c.ProjectID as ProjectID, b.UserName as CreatorUserName, b.UserName as CreatorDisplayName from BugNet_IssueHistory as a, aspnet_Users as b, BugNet_Issues as d, BugNet_Projects as c  WHERE c.ProjectId=d.ProjectId AND d.IssueID=a.IssueID AND a.UserId=b.UserID AND ( 1=1 ", @" ) ORDER BY IssueHistoryId DESC");

        //    return lst;
        //}
    }
}
