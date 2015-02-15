using System;

namespace BugNET.Entities
{
    public class IssueHistory
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="IssueHistory"/> class.
        /// </summary>
        public IssueHistory()
        {
            CreatedUserName = string.Empty;
            CreatorDisplayName = string.Empty;
            DateChanged = DateTime.Now;
            NewValue = string.Empty;
            OldValue = string.Empty;
            TriggerLastUpdateChange = false;
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets the name of the created user.
        /// </summary>
        /// <value>The name of the created user.</value>
        public string CreatedUserName { get; set; }

        /// <summary>
        /// Gets the field changed.
        /// </summary>
        /// <value>The field changed.</value>
        public string FieldChanged { get; set; }

        /// <summary>
        /// Gets the old value.
        /// </summary>
        /// <value>The old value.</value>
        public string OldValue { get; set; }

        /// <summary>
        /// Gets the new value.
        /// </summary>
        /// <value>The new value.</value>
        public string NewValue { get; set; }

        /// <summary>
        /// Gets the date changed.
        /// </summary>
        /// <value>The date changed.</value>
        public DateTime DateChanged { get; set; }

        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName { get; set; }

        /// <summary>
        /// Gets or sets if the hsitory item will trigger an update to the last updated field
        /// </summary>
        /// <remarks>By default this is false, set to true when related entites need to update the last updated field (i.e. A new attachment is added)</remarks>
        public bool TriggerLastUpdateChange { get; set; }
    }
}
