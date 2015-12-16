using System;
using System.Web.UI.WebControls;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Custom Fields Class
    /// </summary>
    public class UserCustomField
    {
        #region Constructors

        public UserCustomField()
        {
            Name = String.Empty;
            Value = String.Empty;
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
        /// Gets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
        public ValidationDataType DataType { get; set; }

        /// <summary>
        /// Gets the type of the field.
        /// </summary>
        /// <value>The type of the field.</value>
        public CustomFieldType FieldType { get; set; }

        /// <summary>
        /// Gets a value indicating whether this <see cref="CustomField"/> is required.
        /// </summary>
        /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
        public bool Required { get; set; }

        /// <summary>
        /// Gets or sets the value.
        /// </summary>
        /// <value>The value.</value>
        public string Value { get; set; }

        #endregion
    }
}
