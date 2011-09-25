using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class QueryManager
    {
        /// <summary>
        /// Saves the query.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryName">Name of the query.</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public static bool SaveQuery(string username, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses)
        {
            //if username is null then query is global for all users on a project

            if (projectId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("projectId");

            if (queryName == null || queryName.Length == 0)
                throw new ArgumentOutOfRangeException("queryName");

            if (queryClauses.Count == 0)
                throw new ArgumentOutOfRangeException("queryClauses");

            return DataProviderManager.Provider.SaveQuery(username, projectId, queryName, isPublic, queryClauses);
        }

        /// <summary>
        /// Updates the query.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <param name="username">The username.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryName">Name of the query.</param>
        /// <param name="isPublic">if set to <c>true</c> [is public].</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public static bool UpdateQuery(int queryId, string username, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses)
        {
            if (queryId <= 0)
                throw new ArgumentOutOfRangeException("queryId");

            if (projectId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("projectId");

            if (queryName == null || queryName.Length == 0)
                throw new ArgumentOutOfRangeException("queryName");

            if (queryClauses.Count == 0)
                throw new ArgumentOutOfRangeException("queryClauses");

            return DataProviderManager.Provider.UpdateQuery(queryId, username, projectId, queryName, isPublic, queryClauses);
        }

        /// <summary>
        /// Deletes the query.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static bool DeleteQuery(int queryId)
        {
            if (queryId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("queryId");

            return DataProviderManager.Provider.DeleteQuery(queryId);
        }

        /// <summary>
        /// Gets the query by id.
        /// </summary>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static Query GetQueryById(int queryId)
        {
            return DataProviderManager.Provider.GetQueryById(queryId);
        }

        /// <summary>
        /// Gets the queries by username.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Query> GetQueriesByUsername(string username, int projectId)
        {
            if (projectId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("projectId");

            return DataProviderManager.Provider.GetQueriesByUserName(username, projectId);
        }
    }
}
