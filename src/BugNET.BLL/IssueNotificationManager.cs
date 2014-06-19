using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
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

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            var data = new Dictionary<string, object> { { "Issue", issue } };
 
            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            var templateCache = new List<CultureNotificationContent>();
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "IssueUpdatedSubject";
            var bodyKey = string.Concat("IssueUpdated", emailFormatKey);

            // get a list of distinct cultures
            var distinctCultures = (from c in issNotifications
                                    select c.NotificationCulture
                                   ).Distinct().ToList();

            // populate the template cache of the cultures needed
            foreach (var culture in from culture in distinctCultures let notificationContent = templateCache.FirstOrDefault(p => p.CultureString == culture) where notificationContent == null select culture)
            {
                templateCache.Add(new CultureNotificationContent().LoadContent(culture, subjectKey, bodyKey));
            }

            foreach (var notification in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    if (notification.NotificationUsername.ToLower() == Security.GetUserName().ToLower()) continue;

                    var user = UserManager.GetUser(notification.NotificationUsername);
                    
                    // skip to the next user if this user is not approved
                    if(!user.IsApproved) continue; 
                    // skip to next user if this user doesn't have notifications enabled.
                    if (!new WebProfile().GetProfile(user.UserName).ReceiveEmailNotifications) continue;

                    var nc = templateCache.First(p => p.CultureString == notification.NotificationCulture);

                    var emailSubject = nc.CultureContents
                        .First(p => p.ContentKey == subjectKey)
                        .FormatContent(issue.FullId, displayname);

                    var bodyContent = nc.CultureContents
                        .First(p => p.ContentKey == bodyKey)
                        .TransformContent(data);

                    var message = new MailMessage()
                        {
                            Subject = emailSubject,
                            Body = bodyContent,
                            IsBodyHtml = true
                        };

                    mailService.Send(user.Email, message);
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

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            var data = new Dictionary<string, object> {{"Issue", issue}};

            var templateCache = new List<CultureNotificationContent>();
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "IssueAddedSubject";
            var bodyKey = string.Concat("IssueAdded", emailFormatKey);

            // get a list of distinct cultures
            var distinctCultures = (from c in issNotifications
                                    select c.NotificationCulture
                                   ).Distinct().ToList();

            // populate the template cache of the cultures needed
            foreach (var culture in from culture in distinctCultures let notificationContent = templateCache.FirstOrDefault(p => p.CultureString == culture) where notificationContent == null select culture)
            {
                templateCache.Add(new CultureNotificationContent().LoadContent(culture, subjectKey, bodyKey));
            }

            foreach (var notification in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who added it.
                    if (notification.NotificationUsername.ToLower() == Security.GetUserName().ToLower()) continue;

                    var user = UserManager.GetUser(notification.NotificationUsername);

                    // skip to the next user if this user is not approved
                    if (!user.IsApproved) continue; 
                    // skip to next user if this user doesn't have notifications enabled.
                    if (!new WebProfile().GetProfile(user.UserName).ReceiveEmailNotifications) continue;

                    var nc = templateCache.First(p => p.CultureString == notification.NotificationCulture);

                    var emailSubject = nc.CultureContents
                        .First(p => p.ContentKey == subjectKey)
                        .FormatContent(issue.FullId, issue.ProjectName);

                    var bodyContent = nc.CultureContents
                        .First(p => p.ContentKey == bodyKey)
                        .TransformContent(data);

                    var message = new MailMessage
                        {
                            Subject = emailSubject,
                            Body = bodyContent,
                            IsBodyHtml = true
                        };

                    mailService.Send(user.Email, message);
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
            { 
                throw (new ArgumentOutOfRangeException("issueId"));
            }

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

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

            var templateCache = new List<CultureNotificationContent>();
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "IssueUpdatedSubject";
            var bodyKey = string.Concat("IssueUpdatedWithChanges", emailFormatKey);

            // get a list of distinct cultures
            var distinctCultures = (from c in issNotifications
                                    select c.NotificationCulture
                                   ).Distinct().ToList();

            // populate the template cache of the cultures needed
            foreach (var culture in from culture in distinctCultures let notificationContent = templateCache.FirstOrDefault(p => p.CultureString == culture) where notificationContent == null select culture)
            {
                templateCache.Add(new CultureNotificationContent().LoadContent(culture, subjectKey, bodyKey));
            }

            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            foreach (var notification in issNotifications)
            {
                try
                {
                    //send notifications to everyone except who changed it.
                    if (notification.NotificationUsername.ToLower() == Security.GetUserName().ToLower()) continue;

                    var user = UserManager.GetUser(notification.NotificationUsername);

                    // skip to the next user if this user is not approved
                    if (!user.IsApproved) continue; 
                    // skip to next user if this user doesn't have notifications enabled.
                    if (!new WebProfile().GetProfile(user.UserName).ReceiveEmailNotifications) continue;

                    var nc = templateCache.First(p => p.CultureString == notification.NotificationCulture);

                    var emailSubject = nc.CultureContents
                        .First(p => p.ContentKey == subjectKey)
                        .FormatContent(issue.FullId, displayname);

                    var bodyContent = nc.CultureContents
                        .First(p => p.ContentKey == bodyKey)
                        .TransformContent(data);

                    var message = new MailMessage
                        {
                            Subject = emailSubject,
                            Body = bodyContent,
                            IsBodyHtml = true
                        };

                    mailService.Send(user.Email, message);
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

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

        	var issue = DataProviderManager.Provider.GetIssueById(notification.IssueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            // data for template
            var data = new Dictionary<string, object> { { "Issue", issue } };
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "NewAssigneeSubject";
            var bodyKey = string.Concat("NewAssignee", emailFormatKey);

            var nc = new CultureNotificationContent().LoadContent(notification.NotificationCulture, subjectKey, bodyKey);

            try
            {
                //send notifications to everyone except who changed it.
                if (notification.NotificationUsername.ToLower() == Security.GetUserName().ToLower()) return;

                var user = UserManager.GetUser(notification.NotificationUsername);

                // skip to the next user if this user is not approved
                if (!user.IsApproved) return; 
                // skip to next user if this user doesn't have notifications enabled.
                if (!new WebProfile().GetProfile(user.UserName).ReceiveEmailNotifications)
                    return;

                var emailSubject = nc.CultureContents
                    .First(p => p.ContentKey == subjectKey)
                    .FormatContent(issue.FullId);

                var bodyContent = nc.CultureContents
                    .First(p => p.ContentKey == bodyKey)
                    .TransformContent(data);

                var message = new MailMessage
                    {
                        Subject = emailSubject,
                        Body = bodyContent,
                        IsBodyHtml = true
                    };

                mailService.Send(user.Email, message);
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

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            var issNotifications = DataProviderManager.Provider.GetIssueNotificationsByIssueId(issueId);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            // data for template
            var data = new Dictionary<string, object> {{"Issue", issue}, {"Comment", newComment}};
            var displayname = UserManager.GetUserDisplayName(Security.GetUserName());

            var templateCache = new List<CultureNotificationContent>();
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "NewIssueCommentSubject";
            var bodyKey = string.Concat("NewIssueComment", emailFormatKey);

            // get a list of distinct cultures
            var distinctCultures = (from c in issNotifications
                                    select c.NotificationCulture
                                   ).Distinct().ToList();

            // populate the template cache of the cultures needed
            foreach (var culture in from culture in distinctCultures let notificationContent = templateCache.FirstOrDefault(p => p.CultureString == culture) where notificationContent == null select culture)
            {
                templateCache.Add(new CultureNotificationContent().LoadContent(culture, subjectKey, bodyKey));
            }

            foreach (var notification in issNotifications)
            {
                var nc = templateCache.First(p => p.CultureString == notification.NotificationCulture);

                var emailSubject = nc.CultureContents
                    .First(p => p.ContentKey == subjectKey)
                    .FormatContent(issue.FullId, displayname);

                var bodyContent = nc.CultureContents
                    .First(p => p.ContentKey == bodyKey)
                    .TransformContent(data);

                try
                {
                    //send notifications to everyone except who changed it.
                    if (notification.NotificationUsername.ToLower() == Security.GetUserName().ToLower()) continue;

                    var user = UserManager.GetUser(notification.NotificationUsername);

                    // skip to the next user if this user is not approved
                    if (!user.IsApproved) continue; 
                    // skip to next user if this user doesn't have notifications enabled.
                    if (!new WebProfile().GetProfile(user.UserName).ReceiveEmailNotifications) continue;

                    var message = new MailMessage
                        {
                            Subject = emailSubject,
                            Body = bodyContent,
                            IsBodyHtml = true
                        };

                    mailService.Send(user.Email, message);
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