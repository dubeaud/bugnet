using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class IssueTypeManager
    {
        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveIssueType(IssueType issueTypeToSave)
        {

            if (issueTypeToSave.Id <= Globals.NewId)
            {

                int TempId = DataProviderManager.Provider.CreateNewIssueType(issueTypeToSave);
                if (TempId > 0)
                {
                    issueTypeToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateIssueType(issueTypeToSave);
            }

        }


    
        /// <summary>
        /// Gets the IssueType by id.
        /// </summary>
        /// <param name="IssueTypeId">The IssueType id.</param>
        /// <returns></returns>
        public static IssueType GetIssueTypeById(int issueTypeId)
        {
            if (issueTypeId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueTypeId"));

            return DataProviderManager.Provider.GetIssueTypeById(issueTypeId);
        }

        /// <summary>
        /// Deletes the type of the issue.
        /// </summary>
        /// <param name="issueTypeId">The issue type id.</param>
        /// <returns></returns>
        public static bool DeleteIssueType(int issueTypeId)
        {
            if (issueTypeId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueTypeId"));

            return DataProviderManager.Provider.DeleteIssueType(issueTypeId);
        }

        /// <summary>
        /// Gets the issue type by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueType> GetIssueTypesByProjectId(int projectId)
        {
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueTypesByProjectId(projectId);
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
        public static List<IssueType> PerformQuery(int projectID, List<QueryClause> QueryClauses)
        {
            if (projectID < 0)
                throw new ArgumentOutOfRangeException("projectID must be bigger than 0");
            QueryClauses.Add(new QueryClause("AND", "ProjectID", "=", projectID.ToString(), System.Data.SqlDbType.Int, false));

            return PerformQuery(QueryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueType table, regardless of 
        /// project level privledges. (thats why its private for now)
        /// </summary>        
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        private static List<IssueType> PerformQuery(List<QueryClause> QueryClauses)
        {
            if (QueryClauses == null)
                throw new ArgumentNullException("QueryClauses");

            List<IssueType> lst = new List<IssueType>();
            DataProviderManager.Provider.PerformGenericQuery<IssueType>(ref lst, QueryClauses, @"SELECT a.*, b.ProjectName as ProjectName from BugNet_ProjectIssueTypes as a, BugNet_Projects as b  WHERE a.ProjectID=b.ProjectID ", @" ORDER BY a.ProjectID, a.IssueTypeID ASC");

            return lst;
        }





        #endregion
    }
}
