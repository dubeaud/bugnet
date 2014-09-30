
namespace BugNET.Account
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using Microsoft.AspNet.Membership.OpenAuth;
    using BugNET.BLL;
    using BugNET.Common;

    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect to access denied if user registration disabled
            switch (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)))
            {
                case (int)UserRegistration.None:
                    Response.Redirect("~/Errors/AccessDenied", true);
                    break;
                case (int)UserRegistration.Verified:
                    RegisterUser.DisableCreatedUser = true;
                    RegisterUser.CompleteStep.ContentTemplateContainer.FindControl("VerificationPanel").Visible = true;
                    break;
            }

            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/";
            }

            var user = UserManager.GetUser(RegisterUser.UserName); 
            var profile = new WebProfile().GetProfile(user.UserName);
            var displayName = (TextBox)RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("DisplayName");
            var firstName = (TextBox)RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("FirstName");
            var lastName = (TextBox)RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("LastName");

            profile.DisplayName = displayName.Text;
            profile.FirstName = firstName.Text;
            profile.LastName = lastName.Text;

            profile.Save();

            // add users to all auto assigned roles
            var roles = RoleManager.GetAll();
            foreach (var r in roles.Where(r => r.AutoAssign))
            {
                RoleManager.AddUser(user.UserName, r.Id);
            }

            //send notification this user was created
            UserManager.SendUserRegisteredNotification(user.UserName);

            // send user verification email if enabled
            if (HostSettingManager.Get(HostSettingNames.UserRegistration, (int)UserRegistration.Verified) == (int)UserRegistration.Verified)
            {
                UserManager.SendUserVerificationNotification(user);
            }
            else
            {
                Response.Redirect(continueUrl);
            }
        }
    }
}