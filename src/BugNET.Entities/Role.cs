namespace BugNET.Entities
{
    /// <summary>
    /// A role definition for a user in the issue tracker.
    /// </summary>
    public class Role
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Role"/> class.
        /// </summary>
        public Role()
        {
            Name = string.Empty;
            Description = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description { get; set; }

        /// <summary>
        /// Gets a value indicating whether [auto assign].
        /// </summary>
        /// <value><c>true</c> if [auto assign]; otherwise, <c>false</c>.</value>
        public bool AutoAssign { get; set; }

        #endregion


    }
}
