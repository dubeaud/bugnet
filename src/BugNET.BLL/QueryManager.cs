using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class QueryManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves or updates the instance.
        /// </summary>
        /// <param name="projectId">The current project id</param>
        /// <param name="userName">The current user name</param>
        /// <param name="entity">The query to save or update</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(string userName, int projectId, Query entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The query name cannot be empty or null"));
            if (entity.Clauses.Count == 0) throw new ArgumentException("The query must have at least one query clause");

            return entity.Id > Globals.NEW_ID ? 
                DataProviderManager.Provider.SaveQuery(userName, projectId, entity.Name, entity.IsPublic, entity.Clauses) : 
                DataProviderManager.Provider.UpdateQuery(entity.Id, userName, projectId, entity.Name, entity.IsPublic, entity.Clauses);
        }

        /// <summary>
        /// Deletes the query.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static bool Delete(int queryId)
        {
            if (queryId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("queryId");

            return DataProviderManager.Provider.DeleteQuery(queryId);
        }

        /// <summary>
        /// Gets the query by id.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static Query GetById(int queryId)
        {
            if (queryId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("queryId");

            return DataProviderManager.Provider.GetQueryById(queryId);
        }

        /// <summary>
        /// Gets the queries by username.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Query> GetByUsername(string username, int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("projectId");

            return DataProviderManager.Provider.GetQueriesByUserName(username, projectId);
        }
    }
}
