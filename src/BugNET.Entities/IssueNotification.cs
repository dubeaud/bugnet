using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Notification.
    /// </summary>
    public class IssueNotification
    {
        private int _IssueId;
        private int _Id;
        private string _NotificationUsername;
        private string _NotificationEmail;
        private string _NotificationDisplayName;

        /// <summary>
        /// Initializes a new instance of the <see cref="T:IssueNotification"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="issueId">The bug id.</param>
        /// <param name="notificationUsername">The notification username.</param>
        /// <param name="notificationEmail">The notification email.</param>
        public IssueNotification(int id, int issueId, string notificationUsername, string notificationEmail, string notificationDisplayName)
        {
            _Id = id;
            _IssueId = issueId;
            _NotificationUsername = notificationUsername;
            _NotificationEmail = notificationEmail;
            _NotificationDisplayName = notificationDisplayName;
        }
        /// <summary>
        /// Initializes a new instance of the <see cref="T:IssueNotification"/> class.
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        /// <param name="notificationUsername">The notification username.</param>
        public IssueNotification(int issueId, string notificationUsername) :
            this(Globals.NEW_ID, issueId, notificationUsername, string.Empty, string.Empty) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="T:IssueNotification"/> class.
        /// </summary>
        public IssueNotification() { }

        /// <summary>
        /// Gets or sets the display name of the notification.
        /// </summary>
        /// <value>The display name of the notification.</value>
        public string NotificationDisplayName
        {
            get { return _NotificationDisplayName; }
            set { _NotificationDisplayName = value; }
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
        }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set
            {
                if (value <= DefaultValues.GetIssueIdMinValue())
                    throw (new ArgumentOutOfRangeException("value"));
                _IssueId = value;
            }
        }

        /// <summary>
        /// Gets the notification username.
        /// </summary>
        /// <value>The notification username.</value>
        public string NotificationUsername
        {
            get
            {
                if (_NotificationUsername == null || _NotificationUsername.Length == 0)
                    return string.Empty;
                else
                    return _NotificationUsername;
            }
        }

        /// <summary>
        /// Gets the notification email.
        /// </summary>
        /// <value>The notification email.</value>
        public string NotificationEmail
        {
            get
            {
                if (_NotificationEmail == null || _NotificationEmail.Length == 0)
                    return string.Empty;
                else
                    return _NotificationEmail;
            }
        }

        /// <summary>
        /// Notifcate Type
        /// </summary>
        public enum NotificationType
        {
            /// <summary>
            /// Bug update email
            /// </summary>
            BugUpdate = 1,
            /// <summary>
            /// Assigned to new user email
            /// </summary>
            BugAssignedToNewUser,
            /// <summary>
            /// New user registered email
            /// </summary>
            NewUserRegistered
        }
         
        
    }
}
