using System;
using System.Collections.Generic;
using System.Text;
using BugNET.UserInterfaceLayer;
using System.Net.Mail;
using System.Net;
using System.Web;
using log4net;

namespace BugNET.BusinessLogicLayer.Notifications
{
    /// <summary>
    /// Email Format Type
    /// </summary>
    public enum EmailFormatType : int
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
        private bool _Enabled = true;

        /// <summary>
        /// Initializes a new instance of the <see cref="EmailNotificationType"/> class.
        /// </summary>
        public EmailNotificationType()
        {
            _Enabled = NotificationManager.IsNotificationTypeEnabled(this.Name);  
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
                return _Enabled;
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
                System.Web.Security.MembershipUser user = ITUser.GetUser(context.Username);

                //check if this user had this notifiction type enabled in their profile.
                if (user != null && ITUser.IsNotificationTypeEnabled(context.Username, this.Name))
                {                                   
                    string From = HostSetting.GetHostSetting("HostEmailAddress");
                    string SMTPServer = HostSetting.GetHostSetting("SMTPServer");
                    int SMTPPort = int.Parse(HostSetting.GetHostSetting("SMTPPort"));
                    bool SMTPAuthentictation = Convert.ToBoolean(HostSetting.GetHostSetting("SMTPAuthentication"));
                    bool SMTPUseSSL = Boolean.Parse(HostSetting.GetHostSetting("SMTPUseSSL"));
                    string SMTPDomain = HostSetting.GetHostSetting("SMTPDomain", string.Empty);

                    // Security Bugfix by SMOSS
                    // Only fetch the password if you need it
                    string SMTPUsername="";
                    string SMTPPassword="";
                    if (SMTPAuthentictation)
                    {
                        SMTPUsername = HostSetting.GetHostSetting("SMTPUsername");
                        SMTPPassword = HostSetting.GetHostSetting("SMTPPassword");
                    }

                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = SMTPServer;
                    smtp.Port = SMTPPort;
                    smtp.EnableSsl = SMTPUseSSL;

                    if (SMTPAuthentictation)
                        smtp.Credentials = new NetworkCredential(SMTPUsername, SMTPPassword, SMTPDomain);

                    MailMessage message = new MailMessage(From, user.Email, context.Subject, context.BodyText);
                    message.IsBodyHtml = true;

                    smtp.Send(message);

                    // try to clean up the credentials
                    if (smtp.Credentials != null)
                      smtp.Credentials = null;
                    SMTPPassword="                 ";
                    SMTPUsername="                 ";
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
