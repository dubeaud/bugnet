using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueTypeManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueType entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save issue type, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The issue type name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateIssueType(entity);

            var tempId = DataProviderManager.Provider.CreateNewIssueType(entity);

            if (tempId <= 0)
                return false;

            entity.Id = tempId;
            return true;
        }


        /// <summary>
        /// Gets the IssueType by id.
        /// </summary>
        /// <param name="issueTypeId">The IssueType id.</param>
        /// <returns></returns>
        public static IssueType GetById(int issueTypeId)
        {
            if (issueTypeId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueTypeId"));

            return DataProviderManager.Provider.GetIssueTypeById(issueTypeId);
        }

        /// <summary>
        /// Deletes the Issue Type.
        /// </summary>
        /// <param name="id">The id for the item to be deleted.</param>
        /// <param name="cannotDeleteMessage">If</param>
        /// <returns></returns>
        public static bool Delete(int id, out string cannotDeleteMessage)
        {
            if (id <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("id"));

            var entity = GetById(id);

            cannotDeleteMessage = string.Empty;

            if (entity == null) return true;

            var canBeDeleted = DataProviderManager.Provider.CanDeleteIssueType(entity.Id);

            if (canBeDeleted)
                return DataProviderManager.Provider.DeleteIssueType(entity.Id);

            cannotDeleteMessage = ResourceStrings.GetGlobalResource(GlobalResources.Exceptions, "DeleteItemAssignedToIssueError");
            cannotDeleteMessage = string.Format(cannotDeleteMessage, entity.Name,  ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "IssueType", "issue type").ToLower());

            return false;
        }

        /// <summary>
        /// Gets the issue type by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueType> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueTypesByProjectId(projectId);
        }

        ///// <summary>
        ///// Stewart Moss
        ///// Apr 14 2010 
        ///// 
        ///// Performs a query containing any number of query clauses on a certain projectID
        ///// </summary>
        ///// <param name="projectId"></param>
        ///// <param name="queryClauses"></param>
        ///// <returns></returns>
        //public static List<IssueType> PerformQuery(int projectId, List<QueryClause> queryClauses)
        //{
        //    if (projectId < 0) throw new ArgumentOutOfRangeException("projectId", "projectI d must be bigger than 0");

        //    queryClauses.Add(new QueryClause("AND", "ProjectID", "=", projectId.ToString(), System.Data.SqlDbType.Int, false));

        //    return PerformQuery(queryClauses);
        //}

        ///// <summary>
        ///// Stewart Moss
        ///// Apr 14 2010 8:30 pm
        ///// 
        ///// Performs any query containing any number of query clauses
        ///// WARNING! Will expose the entire IssueType table, regardless of 
        ///// project level privledges. (thats why its private for now)
        ///// </summary>        
        ///// <param name="queryClauses"></param>
        ///// <returns></returns>
        //private static List<IssueType> PerformQuery(List<QueryClause> queryClauses)
        //{
        //    if (queryClauses == null) throw new ArgumentNullException("queryClauses");

        //    var lst = new List<IssueType>();
        //    DataProviderManager.Provider.PerformGenericQuery(ref lst, queryClauses, @"SELECT a.*, b.ProjectName as ProjectName from BugNet_ProjectIssueTypes as a, BugNet_Projects as b  WHERE a.ProjectID=b.ProjectID ", @" ORDER BY a.ProjectID, a.IssueTypeID ASC");

        //    return lst;
        //}
    }
}
