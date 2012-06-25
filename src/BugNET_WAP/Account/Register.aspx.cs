using System;
using System.Linq;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title"), HostSettingManager.Get(HostSettingNames.ApplicationTitle));

            //redirect to access denied if user registration disabled
            switch (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)))
            {
                case (int)Globals.UserRegistration.None:
                    Response.Redirect("~/AccessDenied.aspx", true);
                    break;
                case (int)Globals.UserRegistration.Verified:
                    CreateUserWizard1.DisableCreatedUser = true;
                    CreateUserWizard1.CompleteStep.ContentTemplateContainer.FindControl("VerificationPanel").Visible = true;
                    break;
            }

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
            var captcha = (HIPControl)CreateUserWizardStep0.ContentTemplateContainer.FindControl("CapchaTest");

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

            var userName = CreateUserWizard1.UserName;

            var user = UserManager.GetUser(userName);

            if (user == null) return;

            var firstName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("FirstName");
            var lastName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("LastName");
            var fullName = (TextBox)CreateUserWizardStep0.ContentTemplateContainer.FindControl("FullName");

            var profile = new WebProfile().GetProfile(user.UserName);

            profile.FirstName = firstName.Text;
            profile.LastName = lastName.Text;
            profile.DisplayName = fullName.Text;
            profile.Save();

            //auto assign user to roles
            var roles = RoleManager.GetAll();
            foreach (var r in roles.Where(r => r.AutoAssign))
            {
                RoleManager.AddUser(user.UserName, r.Id);
            }

            if (Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.UserRegistration, (int)Globals.UserRegistration.Verified)))
            {
                UserManager.SendUserVerificationNotification(user);
            }

            //send notification this user was created
            UserManager.SendUserRegisteredNotification(user.UserName);
        }
    }
}
