using System.Collections.Generic;

namespace BugNET.Entities
{
    /// <summary>
    /// Represents a query issued against the issue database.
    /// </summary>
    public class Query
    {

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Query"/> class.
        /// </summary>
        public Query()
        {
            Name = string.Empty;
            Clauses = new List<QueryClause>();
        }
        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets a value indicating whether this instance is public.
        /// </summary>
        /// <value><c>true</c> if this instance is public; otherwise, <c>false</c>.</value>
        public bool IsPublic { get; set; }

        /// <summary>
        /// Gets the clauses.
        /// </summary>
        /// <value>The clauses.</value>
        public List<QueryClause> Clauses { get; set; }

        #endregion

    }
}
