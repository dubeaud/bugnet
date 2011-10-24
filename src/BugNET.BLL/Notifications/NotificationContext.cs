namespace BugNET.BLL.Notifications
{
    public class NotificationContext : INotificationContext
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationContext"/> class.
        /// </summary>
        public NotificationContext()
        {
            Username = string.Empty;
            Subject = string.Empty;
            BodyText = string.Empty;
            UserDisplayName = string.Empty;
            EmailFormatType = EmailFormatType.Text;
        }

        /// <summary>
        /// Gets or sets the message to send
        /// </summary>
        /// <value>The message.</value>
        public string BodyText { get; set; }

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
    }
}
