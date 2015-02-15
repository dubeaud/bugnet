using System;
using System.Security.Cryptography;
using System.Web;
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
        /// Handles the Click event of the SubmitButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                var user = Membership.GetUser(UserName.Text.Trim());
                if (user != null && user.IsApproved)
                {
                    var profile = new WebProfile().GetProfile(UserName.Text.Trim());
                    string token = GenerateToken();
                    profile.PasswordVerificationToken = token;
                    profile.PasswordVerificationTokenExpirationDate = DateTime.Now.AddMinutes(1440);
                    profile.Save();

                    // Email the user the password reset token
                    UserManager.SendForgotPasswordEmail(user, token);
                }

                forgotPassword.Visible = false;
                successMessage.Visible = true;
            }
        }

        /// <summary>
        /// Generates the token.
        /// </summary>
        /// <returns></returns>
        private string GenerateToken()
        {
            using (var prng = new RNGCryptoServiceProvider())
            {
                return GenerateToken(prng);
            }
        }

        /// <summary>
        /// Generates the token.
        /// </summary>
        /// <param name="generator">The generator.</param>
        /// <returns></returns>
        internal static string GenerateToken(RandomNumberGenerator generator)
        {
            byte[] tokenBytes = new byte[16];
            generator.GetBytes(tokenBytes);
            return HttpServerUtility.UrlTokenEncode(tokenBytes);
        }
    }
}
