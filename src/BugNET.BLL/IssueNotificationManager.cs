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
    public class IssueNotificationManager
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(IssueNotificationManager));


        /// <summary>
        /// Saves the issue notification
        /// </summary>
        /// <param name="issueNotificationToSave">The issue notification to save.</param>
        /// <returns></returns>
        public static bool SaveIssueNotification(IssueNotification issueNotificationToSave)
        {
            int TempId = DataProviderManager.Provider.CreateNewIssueNotification(issueNotificationToSave);
            if (TempId > 0)
            {
                return true;
            }
            else
                return false;
        }

        /// <summary>
        /// Deletes the bug notification.
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static bool DeleteIssueNotification(int issueId, string username)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.DeleteIssueNotification(issueId, username);
        }

        /// <summary>
        /// Gets the bug notifications by bug id.
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        /// <returns></returns>
        public static List<IssueNotification> GetIssueNotificationsByIssueId(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
        }

        /// <summary>
        /// Sends an email to all users that are subscribed to a bug
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        public static void SendIssueNotifications(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            Issue issue = DataProviderManager.Provider.GetIssueById(issueId);
            List<IssueNotification> issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);

            //load plugins
            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);
            //load template 
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueUpdated", type);
            Dictionary<string, object> data = new Dictionary<string, object>();
            data.Add("Issue", issue);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            string subject = NotificationManager.Instance.LoadNotificationTemplate("IssueUpdatedSubject");
            string displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            foreach (IssueNotification notify in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    if (notify.NotificationUsername != Security.GetUserName())
                        NotificationManager.Instance.SendNotification(notify.NotificationUsername, String.Format(subject, issue.FullId, displayname), template);
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
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            Issue issue = DataProviderManager.Provider.GetIssueById(issueId);
            List<IssueNotification> issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);
            //load template
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueAdded", type);
            Dictionary<string, object> data = new Dictionary<string, object>();

            data.Add("Issue", issue);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            string subject = NotificationManager.Instance.LoadNotificationTemplate("IssueAddedSubject");

            foreach (IssueNotification notify in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    //if (notify.NotificationUsername != Security.GetUserName())
                    NotificationManager.Instance.SendNotification(notify.NotificationUsername, String.Format(subject, issue.FullId, issue.ProjectName), template);
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
        public static void SendIssueNotifications(int issueId, List<IssueHistory> issueChanges)
        {
            // validate input
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            Issue issue = DataProviderManager.Provider.GetIssueById(issueId);
            List<IssueNotification> issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);

            //load template 
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("IssueUpdatedWithChanges", type);
            Dictionary<string, object> data = new Dictionary<string, object>();

            data.Add("Issue", issue);

            System.IO.StringWriter writer = new System.IO.StringWriter();
            using (System.Xml.XmlWriter xml = new System.Xml.XmlTextWriter(writer))
            {
                xml.WriteStartElement("IssueHistoryChanges");

                foreach (IssueHistory issueHistory in issueChanges)
                {
                    IssueHistoryManager.SaveIssueHistory(issueHistory);
                    //TODO Fix this 
                    //xml.WriteRaw(issueHistory.ToXml());
                }

                xml.WriteEndElement();

                data.Add("RawXml_Changes", writer.ToString());
            }

            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            string subject = NotificationManager.Instance.LoadNotificationTemplate("IssueUpdatedSubject");
            string displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            foreach (IssueNotification notify in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    //if (notify.NotificationUsername != Security.GetUserName())
                    NotificationManager.Instance.SendNotification(notify.NotificationUsername, String.Format(subject, issue.FullId, displayname), String.Format(template, issueChanges));
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
        /// <param name="issueId">The issue id.</param>
        /// <param name="newAssigneeUserName">New name of the assignee user.</param>
        public static void SendNewAssigneeNotification(int issueId, string newAssigneeUserName)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            Issue issue = DataProviderManager.Provider.GetIssueById(issueId);
            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);

            //load template
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("NewAssignee", type);
            Dictionary<string, object> data = new Dictionary<string, object>();

            data.Add("Issue", issue);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            string subject = NotificationManager.Instance.LoadNotificationTemplate("NewAssigneeSubject");
            string displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            try
            {
                //send notifications to the new assignee
                NotificationManager.Instance.SendNotification(newAssigneeUserName, String.Format(subject, issue.FullId), template);
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
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));
            if (newComment == null)
                throw new ArgumentNullException("newComment");

            Issue issue = DataProviderManager.Provider.GetIssueById(issueId);
            List<IssueNotification> issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);


            //load template 
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("NewIssueComment", type);
            Dictionary<string, object> data = new Dictionary<string, object>();

            data.Add("Issue", issue);
            data.Add("Comment", newComment);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            string subject = NotificationManager.Instance.LoadNotificationTemplate("NewIssueCommentSubject");
            string displayname = UserManager.GetUserDisplayName(Security.GetUserName());


            foreach (IssueNotification notify in issNotifications)
            {
                try
                {
                    NotificationManager.Instance.SendNotification(notify.NotificationUsername, String.Format(subject, issue.FullId, displayname), template);
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
        private static ApplicationException ProcessException(Exception ex)
        {
            
            //set user to log4net context, so we can use %X{user} in the appenders
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", HttpContext.Current.User.Identity.Name);

            if (Log.IsErrorEnabled)
                Log.Error("Email Notification Error", ex);

            return new ApplicationException("An error has occurred sending notifications. Please check the error log for details.", ex);
        }
    }
}
