using System;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using log4net;

namespace BugNET.Account
{
    /// <summary>
    /// Password recovery page
    /// </summary>
    public partial class ForgotPassword : System.Web.UI.Page
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(ForgotPassword));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title"), HostSettingManager.Get(HostSettingNames.ApplicationTitle));
        }

        /// <summary>
        /// Handles the SendingMail event of the PasswordRecovery1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.MailMessageEventArgs"/> instance containing the event data.</param>
        protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
        {
            e.Cancel = true;

            var user = Membership.GetUser(PasswordRecovery1.UserName);

            if (user != null)
            {
                Log.InfoFormat(GetLocalResourceObject("PasswordReminderRequested").ToString(), user, DateTime.Now);
                UserManager.SendUserPasswordReminderNotification(user, PasswordRecovery1.Answer);
            }
            else
            {
                // This exception can expose a specialized type of brute force attack against the username.
                Log.Error(
                    string.Format("Hack Attempt! Password Reminder Bypass by '{0}'", PasswordRecovery1.UserName), 
                    new ArgumentException(String.Format("Non-Existent User '{0}' bypassed something in the password reminder\r\nAt {1} from IP Address {2}\r\nUser Agent {3}", PasswordRecovery1.UserName, DateTime.Now, Context.Request.UserHostAddress, Context.Request.UserAgent)));
            }

        }
    }
}
