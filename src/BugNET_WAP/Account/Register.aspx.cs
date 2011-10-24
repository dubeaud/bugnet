using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using Clearscreen.SharpHIP;

namespace BugNET.Account
{
    /// <summary>
    /// Summary description for Register.
    /// </summary>
    public partial class Register : System.Web.UI.Page
    {

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, System.EventArgs e)
        {
            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title"), HostSettingManager.Get(HostSettingNames.ApplicationTitle));

            #region Security Check
            //redirect to access denied if user registration disabled
            if (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)) == (int)Globals.UserRegistration.None)
                Response.Redirect("~/AccessDenied.aspx", true);
            else if (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)) == (int)Globals.UserRegistration.Verified)
            {
                CreateUserWizard1.DisableCreatedUser = true;
                CreateUserWizard1.CompleteStep.ContentTemplateContainer.FindControl("VerificationPanel").Visible = true;
            }
            #endregion

            // if you are logged in, you cant register
            if (Context.Request.IsAuthenticated)
            {
                Response.Redirect("~/", true);
            }
        }

        /// <summary>
        /// Handles the CreateUser event of the CreateUserWizard1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CreatingUser(object sender, LoginCancelEventArgs e)
        {
            HIPControl captcha = (HIPControl)CreateUserWizardStep0.ContentTemplateContainer.FindControl("CapchaTest");

            if (!captcha.IsValid || !Page.IsValid)
            {

                e.Cancel = true;
            }
        }

        /// <summary>
        /// Handles the CreatedUser event of the CreateUserWizard1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {

            string userName = CreateUserWizard1.UserName;

            MembershipUser user = UserManager.GetUser(userName);

            if (user != null)
            {
                TextBox FirstName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("FirstName");
                TextBox LastName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("LastName");
                TextBox FullName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("FullName");

                WebProfile Profile = new WebProfile().GetProfile(user.UserName);

                Profile.FirstName = FirstName.Text;
                Profile.LastName = LastName.Text;
                Profile.DisplayName = FullName.Text;
                Profile.Save();

                //auto assign user to roles
                List<Role> roles = RoleManager.GetAll();
                foreach (Role r in roles)
                {
                    if (r.AutoAssign)
                        RoleManager.AddUser(user.UserName, r.Id);
                }

                if (Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.UserRegistration,(int)Globals.UserRegistration.Verified)))
                {
                    UserManager.SendUserVerificationNotification(user);
                }

                //send notification this user was created
                UserManager.SendUserRegisteredNotification(user.UserName);
            }
        }


    }
}
