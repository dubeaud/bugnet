using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Notification.
    /// </summary>
    public class IssueNotification
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="IssueNotification"/> class.
        /// </summary>
        public IssueNotification()
        {
            NotificationUsername = string.Empty;
            NotificationEmail = string.Empty;
            NotificationCulture = "en-US";
        }

        /// <summary>
        /// Gets or sets the display name of the notification.
        /// </summary>
        /// <value>The display name of the notification.</value>
        public string NotificationDisplayName { get; set; }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets the notification username.
        /// </summary>
        /// <value>The notification username.</value>
        public string NotificationUsername { get; set; }

        /// <summary>
        /// Gets the notification email.
        /// </summary>
        /// <value>The notification email.</value>
        public string NotificationEmail { get; set; }

        /// <summary>
        /// The culture string to use for the email content
        /// </summary>
        public string NotificationCulture { get; set; }
    }
}
