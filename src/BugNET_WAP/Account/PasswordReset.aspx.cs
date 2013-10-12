using System;
using System.Web.UI;
using BugNET.BLL;

namespace BugNET.Account
{
    public partial class PasswordReset : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Gets the message.
        /// </summary>
        /// <value>
        /// The message.
        /// </value>
        protected string Message
        {
            get;
            private set;
        }

        /// <summary>
        /// Handles the Click event of the Submit control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // get the user by the reset token
                var token  = Request.QueryString["token"];
                
                if (!string.IsNullOrWhiteSpace(token))
                {
                    var user = UserManager.GetUserByPasswordResetToken(token);

                    if (user != null)
                    {
                        try
                        {
                            // update the users password to the new password provided
                            user.ChangePassword(user.ResetPassword(), Password.Text.Trim());

                            // update profile to clear the reset token and date
                            var profile = new WebProfile().GetProfile(user.UserName);
                            profile.PasswordVerificationToken = null;
                            profile.PasswordVerificationTokenExpirationDate = null;
                            profile.Save();

                            Response.Redirect("~/Account/PasswordResetSuccess.aspx");

                        }
                        catch (System.Web.Security.MembershipPasswordException ex)
                        {
                            Message = ex.Message;
                            message.Visible = !String.IsNullOrEmpty(Message);
                        }
                    }
                    else
                    {
                        Message = GetLocalResourceObject("InvalidTokenMessage").ToString();
                        message.Visible = !String.IsNullOrEmpty(Message);
                    }
                }
                else
                {
                    Message = GetLocalResourceObject("InvalidTokenMessage").ToString();
                    message.Visible = !String.IsNullOrEmpty(Message);
                }
            }
        }
    }
}