using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Category.
    /// </summary>
    public class Category
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Category"/> class.
        /// </summary>
        public Category()
        {
            Name = string.Empty;
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
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets the child Category count.
        /// </summary>
        /// <value>The child count.</value>
        public int ChildCount { get; set; }

        /// <summary>
        /// Gets the parent Category id.
        /// </summary>
        /// <value>The parent Category id.</value>
        public int ParentCategoryId { get; set; }

        /// <summary>
        /// Gets the issue count for the category
        /// </summary>
        /// <value>The parent Category id.</value>
        public int IssueCount { get; set; }

        /// <summary>
        /// Gets the disabled status for the category
        /// </summary>
        /// <value>The disabled status.</value>
        public bool Disabled { get; set; }

        #endregion
    }
}
