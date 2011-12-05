using System;
using System.Web;
using System.Web.UI;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Providers.MembershipProviders;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Users.UserControls
{
    public partial class Password : BaseUserControlUserAdmin, IEditUserControl
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public Guid UserId
        {
            get { return ViewState.Get("UserId", Guid.Empty); }
            set { ViewState.Set("UserId", value); }
        }

        public void Initialize()
        {
            BindUserData(UserId);
            DataBind();

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

            if (UserId == Guid.Empty) return;

            //get this user and bind the data
            var user = (CustomMembershipUser)MembershipData;

            if (user == null) return;

            PasswordLastChanged.Text = string.Concat(user.LastPasswordChangedDate.ToString("g"), "&nbsp;");
        }

        /// <summary>
        /// Handles the Click event of the cmdChangePassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void CmdChangePasswordClick(object sender, EventArgs e)
        {
            if (!cvPasswords.IsValid) return;

            if (MembershipData == null) return;

            try
            {
                MembershipData.ChangePassword(MembershipData.ResetPassword(), NewPassword.Text);
                ActionMessage.ShowSuccessMessage(GetLocalResourceObject("PasswordChangeSuccess").ToString());
                BindUserData(UserId);
                DataBind();
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                { 
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);

                    Log.Error(LoggingManager.GetErrorMessageResource("PasswordChangeError"),ex);
                }
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("PasswordChangeError"));
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
                var newPassword = MembershipData.ResetPassword();
                ActionMessage.ShowSuccessMessage(GetLocalResourceObject("PasswordResetSuccess").ToString());

                //Email the password to the user.
                UserManager.SendUserNewPasswordNotification(MembershipData, newPassword);
                BindUserData(UserId);
                DataBind();

                if(Log.IsInfoEnabled)
                    Log.InfoFormat(GetLocalResourceObject("PasswordResetLogMessage").ToString(), MembershipData.UserName); 
                
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Error(Resources.Exceptions.PasswordResetError, ex); 
                }
                ActionMessage.ShowErrorMessage(ex.Message); 
            }
        }

        protected void CmdCancelClick(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Administration/Users/UserList.aspx");
        }
    }
}