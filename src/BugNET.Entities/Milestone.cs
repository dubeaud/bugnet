using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Milestone.
    /// </summary>
    public class Milestone
    {
        #region Constructors

        public Milestone()
        {
            Name = string.Empty;
            ImageUrl = string.Empty;
            Notes = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder { get; set; }

        /// <summary>
        /// Gets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
        public string ImageUrl { get; set; }

        /// <summary>
        /// Gets or sets the notes.
        /// </summary>
        /// <value>The notes.</value>
        public string Notes { get; set; }

        /// <summary>
        /// Gets or sets the due date.
        /// </summary>
        /// <value>The Due Date.</value>
        public DateTime? DueDate { get; set; }

        /// <summary>
        /// Gets or sets the release date.
        /// </summary>
        /// <value>The release date.</value>
        public DateTime? ReleaseDate { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is complete.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is complete; otherwise, <c>false</c>.
        /// </value>
        public bool IsCompleted { get; set; }

        #endregion

    }
}
