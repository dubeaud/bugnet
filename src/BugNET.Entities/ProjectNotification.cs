using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Entity object for the project notifications table.
    /// </summary>
    public class ProjectNotification
    {
        private int     _Id;
        private int     _ProjectId;
        private string  _NotificationUsername;
        private string  _NotificationEmail;
        private string  _NotificationDisplayName;
        private string  _ProjectName;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectNotification"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="notificationUsername">The notification username.</param>
        /// <param name="notificationEmail">The notification email.</param>
        /// <param name="notificationDisplayName">Display name of the notification.</param>
        public ProjectNotification(int id,int projectId,string projectName, string notificationUsername,string notificationEmail, string notificationDisplayName)
		{
			_Id = id;
			_ProjectId = projectId;
			_NotificationUsername = notificationUsername;
			_NotificationEmail =notificationEmail;
            _NotificationDisplayName = notificationDisplayName;
            _ProjectName = projectName;
		}

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectNotification"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="notificationUsername">The notification username.</param>
		public ProjectNotification(int projectId,string notificationUsername) : 
			this(DefaultValues.GetProjectNotificationIdMinValue(),projectId,string.Empty,notificationUsername,string.Empty,string.Empty){}


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
            set { _Id = value; }
        }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int ProjectId
        {
            get { return _ProjectId; }
            set
            {
                if (value <= DefaultValues.GetProjectIdMinValue())
                    throw (new ArgumentOutOfRangeException("value"));
                _ProjectId = value;
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
        /// Gets the name of the project.
        /// </summary>
        /// <value>The name of the project.</value>
        public string ProjectName
        {
            get
            {
               return _ProjectName;
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
        
    }
}
