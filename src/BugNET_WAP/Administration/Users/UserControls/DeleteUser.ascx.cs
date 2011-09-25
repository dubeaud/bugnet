using System;
using System.Web.Security;
using BugNET.BLL;

namespace BugNET.Administration.Users.UserControls
{
    public partial class DeleteUser : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Gets the user id.
        /// </summary>
        /// <value>The user id.</value>
        public Guid UserId
        {
            get
            {
                if (Request.QueryString["user"] != null && Request.QueryString["user"].Length != 0)
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
        /// Handles the Click event of the cmdUnauthorizeAccount control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdUnauthorizeAccount_Click(object sender, EventArgs e)
        {
            try
            {           
                MembershipUser objUser = UserManager.GetUser(UserId);
                objUser.IsApproved = false;
                UserManager.UpdateUser(objUser);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdDeleteUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdDeleteUser_Click(object sender, EventArgs e)
        {
            try
            {
                MembershipUser objUser = UserManager.GetUser(UserId);
                System.Web.Security.Membership.DeleteUser(objUser.UserName);
                Response.Redirect("~/Administration/Users/UserList.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }
}