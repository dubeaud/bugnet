using System;
using System.Linq;
using System.Web.Security;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;

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

            chkRandomPassword.Checked = false;
            RandomPasswordCheckChanged(null, null);

            SecretQuestion.Text = string.Empty;
            SecretAnswer.Text = string.Empty;

            SecretQuestionRow.Visible = Membership.RequiresQuestionAndAnswer;
            SecretAnswerRow.Visible = Membership.RequiresQuestionAndAnswer;

            if (Membership.RequiresQuestionAndAnswer) return;

            ActiveUser.Checked = true;
            ActiveUser.Enabled = false;
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
            if (!Page.IsValid) { return; }

            var password = chkRandomPassword.Checked ? Membership.GeneratePassword(7, 0) : Password.Text;

            var createStatus = MembershipCreateStatus.Success;
            string resultMsg;

            var userIdText = UserName.Text;
            var emailText = Email.Text;
            var isActive = ActiveUser.Checked;
            
            var question = "";
            var answer = "";

            if (Membership.RequiresQuestionAndAnswer)
            {
                question = SecretQuestion.Text;
                answer = SecretAnswer.Text;
            }

            try
            {
                var mu = Membership.RequiresQuestionAndAnswer ?                                                          
                    Membership.CreateUser(userIdText, password, emailText, question, answer, isActive, out createStatus) :
                    Membership.CreateUser(userIdText, password, emailText);

                if (createStatus == MembershipCreateStatus.Success && mu != null)
                {
                    var profile = new WebProfile().GetProfile(mu.UserName);
                    profile.DisplayName = DisplayName.Text;
                    profile.FirstName = FirstName.Text;
                    profile.LastName = LastName.Text;
                    profile.Save();

                    //auto assign user to roles
                    var roles = RoleManager.GetAll();
                    foreach (var r in roles.Where(r => r.AutoAssign))
                    {
                        RoleManager.AddUser(mu.UserName, r.Id);
                    }
                }

                ResetForNewUser();
  
                resultMsg = GetLocalResourceObject("UserCreated").ToString();
                MessageContainer.IconType = BugNET.UserControls.Message.MessageType.Information;
                
            }
            catch (Exception ex)
            {
                resultMsg = GetLocalResourceObject("UserCreatedError") + "<br/>" + ex.Message;
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
