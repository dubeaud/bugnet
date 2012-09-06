using System;

namespace BugNET.Entities
{
    public class NotificationUser
    {
        public Guid Id { get; set; }

        /// <summary>
        /// Gets or sets the first name.
        /// </summary>
        /// <value>The first name.</value>
        public string FirstName { get; set; }

        /// <summary>
        /// Gets or sets the last name.
        /// </summary>
        /// <value>The last name.</value>
        public string LastName { get; set; }

        /// <summary>
        /// Gets or sets the display name.
        /// </summary>
        /// <value>The display name.</value>
        public string DisplayName { get; set; }

        /// <summary>
        /// Gets or sets the display name.
        /// </summary>
        /// <value>The display name.</value>
        public string Password { get; set; }

        /// <summary>
        /// when the user was created
        /// </summary>
        public DateTime CreationDate { get; set; }

        /// <summary>
        /// The user email
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// The user username
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// The user is approved
        /// </summary>
        public bool IsApproved { get; set; }
    }
}
