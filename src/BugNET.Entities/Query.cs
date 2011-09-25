using System.Collections.Generic;

namespace BugNET.Entities
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

    }
}
