namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Priority.
    /// </summary>
    public class Priority
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Priority"/> class.
        /// </summary>
        public Priority()
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
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
        public string ImageUrl { get; set; }

        #endregion
    }
}
