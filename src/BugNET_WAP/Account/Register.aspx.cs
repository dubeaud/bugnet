
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
            //redirect to access denied if user registration disabled
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
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/";
            }

            var user = UserManager.GetUser(RegisterUser.UserName);

            // add users to all auto assigned roles
            var roles = RoleManager.GetAll();
            foreach (var r in roles.Where(r => r.AutoAssign))
            {
                RoleManager.AddUser(user.UserName, r.Id);
            }

            // send user verification email if enabled
            if (Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.UserRegistration, (int)UserRegistration.Verified)))
            {
                UserManager.SendUserVerificationNotification(user);
            }

            //send notification this user was created
            UserManager.SendUserRegisteredNotification(user.UserName);

            Response.Redirect(continueUrl);
        }
    }
}