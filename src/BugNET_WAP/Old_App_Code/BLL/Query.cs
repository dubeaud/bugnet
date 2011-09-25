using System;
using System.Collections;
using System.Web.UI.WebControls;
using BugNET.DataAccessLayer;
using System.Collections.Generic;


namespace BugNET.BusinessLogicLayer
{


    /// <summary>
    /// Represents a query issued against the issue database.
    /// </summary>
    public class Query
    {

        #region Private Fields

        private int _Id;
        private string _Name;
        private bool _IsPublic;
        private List<QueryClause> _QueryClauses;

        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the <see cref="Query"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="isPublic">if set to <c>true</c> [is public].</param>
        public Query(int id, string name, bool isPublic)
        {
            _Id = id;
            _Name = name;
            _IsPublic = isPublic;
        }

        public Query(int id, string name, bool isPublic, List<QueryClause> queryClauses)
        {
            _Id = id;
            _Name = name;
            _IsPublic = isPublic;
            _QueryClauses = queryClauses;
        }

        #endregion

        #region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
        }


        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name
        {
            get { return _Name; }
        }

        /// <summary>
        /// Gets a value indicating whether this instance is public.
        /// </summary>
        /// <value><c>true</c> if this instance is public; otherwise, <c>false</c>.</value>
        public bool IsPublic
        {
            get { return _IsPublic; }
        }

        /// <summary>
        /// Gets the clauses.
        /// </summary>
        /// <value>The clauses.</value>
        public List<QueryClause> Clauses
        {
            get { return _QueryClauses; }
            set { _QueryClauses = value; }
        }

        #endregion

        /// <summary>
        /// Saves the query.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryName">Name of the query.</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public static bool SaveQuery( string username, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses)
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
