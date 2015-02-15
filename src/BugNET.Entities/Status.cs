namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Status.
    /// </summary>
    public class Status
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Status"/> class.
        /// </summary>
        public Status()
        {
            Name = string.Empty;
            ImageUrl = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is closed state.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is closed state; otherwise, <c>false</c>.
        /// </value>
        public bool IsClosedState { get; set; }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
        public string ImageUrl { get; set; }

        /// <summary>
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder { get; set; }

        #endregion
    }
}
