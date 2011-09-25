using System;
using System.Web;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Providers.MembershipProviders;
using log4net;

namespace BugNET.Administration.Users.UserControls
{
	public partial class Password : System.Web.UI.UserControl
	{
        private static readonly ILog Log = LogManager.GetLogger(typeof(Password));
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.Security.Membership.RequiresQuestionAndAnswer || !System.Web.Security.Membership.EnablePasswordRetrieval)
                ChangePassword.Visible = false;

            if (!System.Web.Security.Membership.EnablePasswordReset)
                ResetPassword.Visible = false;
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            base.DataBind();

            if (UserId != Guid.Empty)
            {
                //get this user and bind the data
                CustomMembershipUser user = (CustomMembershipUser)UserManager.GetUser(UserId);
                if (user != null)
                {

                    lblUserName.Text = user.UserName;
                    PasswordLastChanged.Text = user.LastPasswordChangedDate.ToShortDateString();
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdChangePassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdChangePassword_Click(object sender, EventArgs e)
        {
            if (cvPasswords.IsValid)
            {
                MembershipUser objUser = UserManager.GetUser(UserId);
                if (objUser != null)
                {
                    try
                    {
                        objUser.ChangePassword(objUser.ResetPassword(), NewPassword.Text);
                        Message1.ShowSuccessMessage(GetLocalResourceObject("PasswordChangeSuccess").ToString());
                    }
                    catch (Exception ex)
                    {
                        if (Log.IsErrorEnabled)
                        { 
                            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                                MDC.Set("user", HttpContext.Current.User.Identity.Name);
                            Log.Error(LoggingManager.GetErrorMessageResource("PasswordChangeError"),ex);
                        }
                        Message1.ShowErrorMessage(LoggingManager.GetErrorMessageResource("PasswordChangeError"));
                    }

                }
            }

        }

        /// <summary>
        /// Gets the user id.
        /// </summary>
        /// <value>The user id.</value>
        public Guid UserId
        {
            get
            {
                if (Request.QueryString["user"] != null || Request.QueryString["user"].Length != 0)
                    try
                    {
                        return new Guid(Request.QueryString["user"].ToString());
                    }
                    catch
                    {
                        throw new Exception(LoggingManager.GetErrorMessageResource("QueryStringError"));
                    }
                else
                    return Guid.Empty;
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdResetPassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                MembershipUser objUser = UserManager.GetUser(UserId);
                string newPassword = objUser.ResetPassword();
                Message1.ShowSuccessMessage(GetLocalResourceObject("PasswordResetSuccess").ToString());

                //Email the password to the user.
                UserManager.SendUserNewPasswordNotification(objUser, newPassword);

                if(Log.IsInfoEnabled)
                    Log.InfoFormat(GetLocalResourceObject("PasswordResetLogMessage").ToString(),objUser.UserName); 
                
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Error(Resources.Exceptions.PasswordResetError, ex); 
                }
                Message1.ShowErrorMessage(ex.Message); 
            }
        }
	}
}