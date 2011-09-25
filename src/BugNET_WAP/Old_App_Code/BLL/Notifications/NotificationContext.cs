using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Security;

namespace BugNET.BusinessLogicLayer.Notifications
{
    public class NotificationContext : INotificationContext
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationContext"/> class.
        /// </summary>
        public NotificationContext()
        {
            this.UserDisplayName = string.Empty;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationContext"/> class.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="bodyText">The body text.</param>
        public NotificationContext(string username, string subject, string bodyText)
            : this()
        {
            this.Username = username;
            this.Subject = subject;
            this.BodyText = bodyText;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationContext"/> class.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="bodyText">The body text.</param>
        /// <param name="emailFormatType">The format of the email's body</param>
        public NotificationContext(string username, string subject, string bodyText, EmailFormatType emailFormatType)
            : this(username, subject, bodyText)
        {
            this.EmailFormatType = emailFormatType;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationContext"/> class.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="bodyText">The body text.</param>
        /// <param name="emailFormatType">The format of the email's body</param>
        /// <param name="userDisplayName">The human friendly users name</param>
        public NotificationContext(string username, string subject, string bodyText, EmailFormatType emailFormatType, string userDisplayName)
            : this(username, subject, bodyText, emailFormatType)
        {
            this.UserDisplayName = userDisplayName;
        }

        #region INotificationContext Members

        /// <summary>
        /// Gets or sets the message to send
        /// </summary>
        /// <value>The message.</value>
        public virtual string BodyText { get; set; }

        /// <summary>
        /// Gets or sets the send to address.
        /// </summary>
        /// <value>The send to address.</value>
        public string Username { get; set; }

        /// <summary>
        /// Gets or sets the users display name.
        /// </summary>
        /// <value>The user display name.</value>
        public string UserDisplayName { get; set; }

        /// <summary>
        /// Gets or sets the subject.
        /// </summary>
        /// <value>The subject.</value>
        public string Subject { get; set; }

        /// <summary>
        /// Gets or sets the email format type
        /// </summary>
        /// <value>The email format type</value>
        public EmailFormatType EmailFormatType { get; set; }

        #endregion
    }
}
