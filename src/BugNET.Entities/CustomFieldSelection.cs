namespace BugNET.Entities
{

    /// <summary>
    /// Summary description for CustomFieldSelection
    /// </summary>
    public class CustomFieldSelection
    {

        public CustomFieldSelection()
        {
            Name = string.Empty;
            Value = string.Empty;
        }

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the custom field id.
        /// </summary>
        /// <value>The custom field id.</value>
        public int CustomFieldId { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the value.
        /// </summary>
        /// <value>The value.</value>
        public string Value { get; set; }

        /// <summary>
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder { get; set; }

        #endregion
    }
}