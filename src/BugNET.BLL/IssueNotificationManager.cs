using System;
using System.Collections.Generic;
using System.Web;
using BugNET.BLL.Notifications;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueNotificationManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves the issue notification
        /// </summary>
        /// <param name="notification">The issue notification to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueNotification notification)
        {
            if (notification == null) throw new ArgumentNullException("notification");
            if (notification.IssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("notification", "The issue id for the notification is not valid"));
            if (string.IsNullOrEmpty(notification.NotificationUsername)) throw (new ArgumentOutOfRangeException("notification", "The user name for the notification cannot be null or empty"));

            return DataProviderManager.Provider.CreateNewIssueNotification(notification) > 0;
        }

        /// <summary>
        /// Deletes the issue notification.
        /// </summary>
        /// <param name="notification">The issue notification to delete.</param>
        /// <returns></returns>
        public static bool Delete(IssueNotification notification)
        {
            if (notification == null) throw new ArgumentNullException("notification");
            if (notification.IssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("notification", "The issue id for the notification is not valid"));
            if (string.IsNullOrEmpty(notification.NotificationUsername)) throw (new ArgumentOutOfRangeException("notification", "The user name for the notification cannot be null or empty"));

            return DataProviderManager.Provider.DeleteIssueNotification(notification.IssueId, notification.NotificationUsername);
        }

        /// <summary>
        /// Gets the issue notifications by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<IssueNotification> GetByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
        }

        /// <summary>
        /// Sends an email to all users that are subscribed to a issue
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        public static void SendIssueNotifications(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template 
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueUpdated", emailFormatType);
            var data = new Dictionary<string, object> {{"Issue", issue}};
            template = NotificationManager.GenerateNotificationContent(template, data);

            var subject = NotificationManager.Instance.LoadNotificationTemplate("IssueUpdatedSubject");
            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            foreach (var notify in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    if (notify.NotificationUsername != Security.GetUserName())
                    {
                        var context = new NotificationContext
                        {
                            BodyText = template,
                            EmailFormatType = emailFormatType,
                            Subject = String.Format(subject, issue.FullId, displayname),
                            UserDisplayName = UserManager.GetUserDisplayName(notify.NotificationUsername),
                            Username = notify.NotificationUsername
                        };

                        NotificationManager.Instance.SendNotification(context);
                    }
                        
                }
                catch (Exception ex)
                {
                    ProcessException(ex);
                }
            }
        }

        /// <summary>
        /// Sends the issue add notifications.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        public static void SendIssueAddNotifications(int issueId)
        {
            // validate input
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueAdded", emailFormatType);
            var data = new Dictionary<string, object> {{"Issue", issue}};

            template = NotificationManager.GenerateNotificationContent(template, data);

            var subject = NotificationManager.Instance.LoadNotificationTemplate("IssueAddedSubject");

            foreach (var notify in issNotifications)
            {
                try
                {
                    var context = new NotificationContext
                    {
                        BodyText = template,
                        EmailFormatType = emailFormatType,
                        Subject = String.Format(subject, issue.FullId, issue.ProjectName),
                        UserDisplayName = UserManager.GetUserDisplayName(notify.NotificationUsername),
                        Username = notify.NotificationUsername
                    };

                    NotificationManager.Instance.SendNotification(context);
                }
                catch (Exception ex)
                {
                    ProcessException(ex);
                }
            }
        }


        /// <summary>
        /// Sends the issue notifications.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="issueChanges">The issue changes.</param>
        public static void SendIssueNotifications(int issueId, IEnumerable<IssueHistory> issueChanges)
        {
            // validate input
            if (issueId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("issueId"));

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template 
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueUpdatedWithChanges", emailFormatType);
            var data = new Dictionary<string, object> {{"Issue", issue}};

            var writer = new System.IO.StringWriter();
            using (System.Xml.XmlWriter xml = new System.Xml.XmlTextWriter(writer))
            {
                xml.WriteStartElement("IssueHistoryChanges");

                foreach (var issueHistory in issueChanges)
                {
                    IssueHistoryManager.SaveOrUpdate(issueHistory);
                    xml.WriteRaw(issueHistory.ToXml());
                }

                xml.WriteEndElement();

                data.Add("RawXml_Changes", writer.ToString());
            }

            template = NotificationManager.GenerateNotificationContent(template, data);

            var subject = NotificationManager.Instance.LoadNotificationTemplate("IssueUpdatedSubject");
            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            foreach (var notify in issNotifications)
            {
                try
                {
                    var context = new NotificationContext
                    {
                        BodyText = template,
                        EmailFormatType = emailFormatType,
                        Subject = String.Format(subject, issue.FullId, displayname),
                        UserDisplayName = UserManager.GetUserDisplayName(notify.NotificationUsername),
                        Username = notify.NotificationUsername
                    };

                    NotificationManager.Instance.SendNotification(context);
                }
                catch (Exception ex)
                {
                    ProcessException(ex);
                }
            }
        }

        /// <summary>
        /// Sends an email to the user that is assigned to the issue
        /// </summary>
        /// <param name="notification"></param>
        public static void SendNewAssigneeNotification(IssueNotification notification)
        {
            if (notification == null) throw (new ArgumentNullException("notification"));
            if (notification.IssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("notification", "The issue id is not valid for this notification"));

            var issue = DataProviderManager.Provider.GetIssueById(notification.IssueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("NewAssignee", emailFormatType);
            var data = new Dictionary<string, object> {{"Issue", issue}};

            template = NotificationManager.GenerateNotificationContent(template, data);

            var subject = NotificationManager.Instance.LoadNotificationTemplate("NewAssigneeSubject");

            try
            {
                var context = new NotificationContext
                {
                    BodyText = template,
                    EmailFormatType = emailFormatType,
                    Subject = String.Format(subject, issue.FullId),
                    UserDisplayName = UserManager.GetUserDisplayName(notification.NotificationUsername),
                    Username = notification.NotificationUsername
                };

                NotificationManager.Instance.SendNotification(context);
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        /// <summary>
        /// Sends the new issue comment notification.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="newComment">The new comment.</param>
        public static void SendNewIssueCommentNotification(int issueId, IssueComment newComment)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));
            if (newComment == null) throw new ArgumentNullException("newComment");

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template 
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("NewIssueComment", emailFormatType);
            var data = new Dictionary<string, object> {{"Issue", issue}, {"Comment", newComment}};

            template = NotificationManager.GenerateNotificationContent(template, data);

            var subject = NotificationManager.Instance.LoadNotificationTemplate("NewIssueCommentSubject");
            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());


            foreach (var notify in issNotifications)
            {
                try
                {
                    var context = new NotificationContext
                    {
                        BodyText = template,
                        EmailFormatType = emailFormatType,
                        Subject = String.Format(subject, issue.FullId, displayname),
                        UserDisplayName = UserManager.GetUserDisplayName(notify.NotificationUsername),
                        Username = notify.NotificationUsername
                    };

                    NotificationManager.Instance.SendNotification(context);
                }
                catch (Exception ex)
                {
                    ProcessException(ex);
                }
            }
        }

        /// <summary>
        /// Processes the exception by logging and throwing a wrapper exception with non-sensitive data.
        /// </summary>
        /// <param name="ex">The ex.</param>
        /// <returns>New exception to wrap the thrown one.</returns>
        private static void ProcessException(Exception ex)
        {
            
            //set user to log4net context, so we can use %X{user} in the appenders
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", HttpContext.Current.User.Identity.Name);

            if (Log.IsErrorEnabled)
                Log.Error("Email Notification Error", ex);
        }
    }
}
