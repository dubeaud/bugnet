using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using BugNET.Models;
using BugNET.BLL;
using BugNET.Common;

namespace BugNET.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect to access denied if user registration disabled
            if (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)) == (int)UserRegistration.None)
            {
                Response.Redirect("~/Errors/AccessDenied", true);
            }
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() {Id = Guid.NewGuid(), UserName = UserName.Text, Email = Email.Text, PreferredLocale = "en-US", IsApproved = true };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                // generate email confirmation code and url.
                string code = manager.GenerateEmailConfirmationToken(user.Id);
                string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id.ToString(), Request);

                BugNET.BLL.UserManager.SendUserVerificationNotification(user, callbackUrl);

                // add users to all auto assigned roles
                var roles = RoleManager.GetAll();
                foreach (var r in roles.Where(r => r.AutoAssign))
                {
                    RoleManager.AddUser(user.UserName, r.Id);
                }

                loginForm.Visible = false;
                DisplayEmail.Visible = true;

                // send notification this user was created
                UserManager.SendUserRegisteredNotification(user.UserName);

                //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}