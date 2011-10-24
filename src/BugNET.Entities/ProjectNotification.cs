using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Entity object for the project notifications table.
    /// </summary>
    public class ProjectNotification
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectNotification"/> class.
        /// </summary>
        public ProjectNotification()
        {
            NotificationUsername = string.Empty;
            ProjectName = string.Empty;
            NotificationEmail = string.Empty;
        }

        /// <summary>
        /// Gets or sets the display name for the user
        /// </summary>
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
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets the notification username.
        /// </summary>
        /// <value>The notification username.</value>
        public string NotificationUsername { get; set; }

        /// <summary>
        /// Gets the name of the project.
        /// </summary>
        /// <value>The name of the project.</value>
        public string ProjectName { get; set; }

        /// <summary>
        /// Gets the notification email.
        /// </summary>
        /// <value>The notification email.</value>
        public string NotificationEmail { get; set; }

    }
}
