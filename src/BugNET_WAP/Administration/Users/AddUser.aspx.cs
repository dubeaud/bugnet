using System;
using System.Linq;
using System.Web;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using BugNET.Models;
using System.Web.UI;
using System.Threading.Tasks;

namespace BugNET.Administration.Users
{
    public partial class AddUser : BasePage
    {
        void ResetForNewUser()
        {
            UserName.Text = string.Empty;
            FirstName.Text = string.Empty;
            LastName.Text = string.Empty;
            DisplayName.Text = string.Empty;
            Email.Text = string.Empty;
            Password.Text = string.Empty;
            ConfirmPassword.Text = string.Empty;
            ActiveUser.Checked = true;

            chkRandomPassword.Checked = false;
            RandomPasswordCheckChanged(null, null);
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;

            ResetForNewUser();
        }

        /// <summary>
        /// Handles the CheckChanged event of the RandomPassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RandomPasswordCheckChanged(object sender, EventArgs e)
        {
            if (chkRandomPassword.Checked)
            {
                cvPassword.Enabled = false;
                rvConfirmPassword.Enabled = false;
                rvPassword.Enabled = false;
                Password.Enabled = false;
                ConfirmPassword.Enabled = false;
            }
            else
            {
                rvConfirmPassword.Enabled = true;
                rvPassword.Enabled = true;
                Password.Enabled = true;
                ConfirmPassword.Enabled = true;
            }
        }

        /// <summary>
        /// Handles the Click event of the AddNewUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddNewUserClick(object sender, EventArgs e)
        {
            Page.RegisterAsyncTask(new PageAsyncTask(AddUser)); 
        }

        private async Task AddUser()
        {
            if (!Page.IsValid) { return; }

            string resultMsg;

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() { UserName = UserName.Text, Email = Email.Text };
            var password = chkRandomPassword.Checked ? await manager.GenerateRandomPasswordAsync() : Password.Text;

            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                var profile = new WebProfile().GetProfile(UserName.Text);
                profile.DisplayName = DisplayName.Text;
                profile.FirstName = FirstName.Text;
                profile.LastName = LastName.Text;
                profile.Save();

                //auto assign user to roles
                var roles = RoleManager.GetAll();
                foreach (var r in roles.Where(r => r.AutoAssign))
                {
                    RoleManager.AddUser(UserName.Text, r.Id);
                }

                resultMsg = GetLocalResourceObject("UserCreated").ToString();
                MessageContainer.IconType = BugNET.UserControls.Message.MessageType.Information;
            }
            else
            {
                resultMsg = GetLocalResourceObject("UserCreatedError").ToString();
                MessageContainer.IconType = BugNET.UserControls.Message.MessageType.Error;
            }

            MessageContainer.Text = resultMsg;
            MessageContainer.Visible = true;
        }

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CmdCancelClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Users/UserList.aspx");
        }
    }
}
