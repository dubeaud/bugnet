using System;
using System.Net.Mail;
using System.Net;
using System.Web;
using log4net;

namespace BugNET.BLL.Notifications
{
    /// <summary>
    /// Email Format Type
    /// </summary>
    public enum EmailFormatType
    {
        /// <summary>
        /// Text
        /// </summary>
        Text = 1,
        /// <summary>
        /// HTML
        /// </summary>
        HTML = 2
    }

    /// <summary>
    /// 
    /// </summary>
    public class EmailNotificationType : INotificationType
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(EmailNotificationType));
        private readonly bool _enabled = true;

        /// <summary>
        /// Initializes a new instance of the <see cref="EmailNotificationType"/> class.
        /// </summary>
        public EmailNotificationType()
        {
            _enabled = NotificationManager.IsNotificationTypeEnabled(Name);  
        }

        #region INotificationType Members

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name
        {
            get { return "Email"; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="EmailNotificationType"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
        public bool Enabled
        {
            get
            {
                return _enabled;
            }
        }

        /// <summary>
        /// Sends the notification.
        /// </summary>
        /// <param name="context">The context.</param>
        public void SendNotification(INotificationContext context)
        {
            try
            {
                var user = UserManager.GetUser(context.Username);

                //check if this user had this notifiction type enabled in their profile.
                if (user != null && UserManager.IsNotificationTypeEnabled(context.Username, Name))
                {
                    var from = HostSettingManager.GetHostSetting("HostEmailAddress");
                    var smtpServer = HostSettingManager.GetHostSetting("SMTPServer");
                    var smtpPort = int.Parse(HostSettingManager.GetHostSetting("SMTPPort"));
                    var smtpAuthentictation = Convert.ToBoolean(HostSettingManager.GetHostSetting("SMTPAuthentication"));
                    var smtpUseSSL = Boolean.Parse(HostSettingManager.GetHostSetting("SMTPUseSSL"));

                    // Security Bugfix by SMOSS
                    // Only fetch the password if you need it
                    var smtpUsername = string.Empty;
                    var smtpPassword = string.Empty;
                    var smtpDomain = string.Empty;

                    if (smtpAuthentictation)
                    {
                        smtpUsername = HostSettingManager.GetHostSetting("SMTPUsername", string.Empty);
                        smtpPassword = HostSettingManager.GetHostSetting("SMTPPassword", string.Empty);
                        smtpDomain = HostSettingManager.GetHostSetting("SMTPDomain", string.Empty);
                    }

                    using (var smtp = new SmtpClient())
                    {

                        smtp.Host = smtpServer;
                        smtp.Port = smtpPort;
                        smtp.EnableSsl = smtpUseSSL;

                        if (smtpAuthentictation)
                            smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword, smtpDomain);

                        using (var message = new MailMessage(
                            from,
                            user.Email,
                            context.Subject,
                            context.BodyText) { IsBodyHtml = true })
                        {
                            smtp.Send(message);
                        }

                    }

                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        #endregion

        /// <summary>
        /// Processes the exception.
        /// </summary>
        /// <param name="ex">The ex.</param>
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
