using System;
using System.Collections.Generic;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Users
{
    public partial class AddUser : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SecretQuestionRow.Visible = Membership.RequiresQuestionAndAnswer ? true : false;
                SecretAnswerRow.Visible = Membership.RequiresQuestionAndAnswer ? true : false;
                if (!Membership.RequiresQuestionAndAnswer)
                {
                    ActiveUser.Checked = true;
                    ActiveUser.Enabled = false;
                }
                //this.Validate();
            }
        }

        /// <summary>
        /// Handles the CheckChanged event of the RandomPassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RandomPassword_CheckChanged(object sender, EventArgs e)
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
        protected void AddNewUser_Click(object sender, EventArgs e)
        {
            string password;
           
            //if (chkRandomPassword.Checked)
            //{
            //    cvPassword.Enabled = false;
            //    rvConfirmPassword.Enabled = false;
            //    rvPassword.Enabled = false;
            //    password = Membership.GeneratePassword(7, 0);
            //}
            //else
            //{
            //    rvConfirmPassword.Enabled = true;
            //    rvPassword.Enabled = true;
            //    password = Password.Text;
            //}

            if (!Page.IsValid)
            {
                return;
            }

            if (chkRandomPassword.Checked)
            {
                password = Membership.GeneratePassword(7, 0);
            }
            else
            {
                password = Password.Text;

            }
            

            MembershipCreateStatus createStatus = MembershipCreateStatus.Success;
            string resultMsg = "";

            string userIDText = UserName.Text;
            string emailText = Email.Text;
            bool isActive = ActiveUser.Checked;
            
            string question = "";
            string answer = "";
            if (Membership.RequiresQuestionAndAnswer)
            {
                question = SecretQuestion.Text;
                answer = SecretAnswer.Text;
            }

            try
            {
                MembershipUser mu = null;

                if (Membership.RequiresQuestionAndAnswer)
                {
                    mu = Membership.CreateUser(userIDText, password, emailText, question, answer, isActive, out createStatus);
                }
                else
                {
                    mu = Membership.CreateUser(userIDText, password, emailText);
                }

                if (createStatus == MembershipCreateStatus.Success && mu != null)
                {
                    WebProfile Profile = new WebProfile().GetProfile(mu.UserName);
                    Profile.DisplayName = DisplayName.Text;
                    Profile.FirstName = FirstName.Text;
                    Profile.LastName = LastName.Text;
                    Profile.Save();

                    //auto assign user to roles
                    List<Role> roles = RoleManager.GetAllRoles();
                    foreach (Role r in roles)
                    {
                        if (r.AutoAssign)
                            RoleManager.AddUserToRole(mu.UserName, r.Id);
                    }
                }

                ImageButton2.Enabled = false;
                LinkButton2.Enabled = false;
  
                resultMsg = GetLocalResourceObject("UserCreated").ToString();
                Message1.IconType = BugNET.UserControls.Message.MessageType.Information;
                
            }
            catch (Exception ex)
            {
                resultMsg = GetLocalResourceObject("UserCreatedError").ToString() + "<br/>" + ex.Message;
                Message1.IconType = BugNET.UserControls.Message.MessageType.Error;
            }

            Message1.Text = resultMsg;
            Message1.Visible = true;
        }

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Host/Users/Users.aspx");
        }
    }
}
