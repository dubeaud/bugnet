using System;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Providers.MembershipProviders;

namespace BugNET.Administration.Users.UserControls
{
    public partial class Membership : System.Web.UI.UserControl
    {

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            base.DataBind();
            BindData();
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void BindData()
        {

            if (UserId != Guid.Empty)
            {
                //get this user and bind the data
                CustomMembershipUser user = (CustomMembershipUser)UserManager.GetUser(UserId);
                if (user != null)
                {
                    //if (user.IsLockedOut)
                       //lblError"This user is currently locked out");

                    lblUserName.Text = user.UserName;
                    UserName.Text = user.UserName;
                    Email.Text = user.Email;
                    CreatedDate.Text = user.CreationDate.ToString("g");
                    LastActivityDate.Text = user.LastActivityDate.ToString("g");
                    LastLoginDate.Text = user.LastLoginDate.ToString("g");
                    LockedOut.Checked = user.IsLockedOut;
                    Authorized.Checked = user.IsApproved;
                    Online.Checked = user.IsOnline;
                    FirstName.Text = user.FirstName; 
                    LastName.Text = user.LastName;
                    DisplayName.Text = user.DisplayName;
                    cmdAuthorize.Visible = !user.IsApproved;
                    ibAuthorize.Visible = !user.IsApproved;
                    cmdUnAuthorize.Visible = user.IsApproved;
                    ibUnAuthorize.Visible = user.IsApproved;
                    ibUnLock.Visible = user.IsLockedOut ? true :false;
                    cmdUnLock.Visible = user.IsLockedOut ? true : false;       
                }
            }
        }
        /// <summary>
        /// Gets the user id.
        /// </summary>
        /// <value>The user id.</value>
        public Guid UserId
        {
            get {
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
        /// Handles the Click event of the cmdUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void cmdUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CustomMembershipUser user = (CustomMembershipUser)UserManager.GetUser(UserId);
                if (user != null)
                {
                    //user.IsApproved = Authorized.Checked;
                    user.Email = Email.Text;
                    user.DisplayName = DisplayName.Text;
                    user.FirstName = FirstName.Text;
                    user.LastName =  LastName.Text;
                    UserManager.UpdateUser(user);
                }
                lblError.Text = GetLocalResourceObject("UpdateUserMessage").ToString();
            }
            catch
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("UpdateUserError");
                lblError.Visible = true;
            }
        }


        /// <summary>
        /// Handles the Click event of the AuthorizeUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AuthorizeUser_Click(object sender, EventArgs e)
        {
            try
            {
                AuthorizeUser(true);
                lblError.Text = GetLocalResourceObject("UserAuthorizedMessage").ToString();
            }
            catch
            {
                lblError.Text = GetLocalResourceObject("UserAuthorizedError").ToString();
            }
        }

        /// <summary>
        /// Handles the Click event of the UnLockUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void UnLockUser_Click(object sender, EventArgs e)
        {
            MembershipUser user = UserManager.GetUser(UserId);
            if(user!=null)
            {
                user.UnlockUser();
            }
        }

        /// <summary>
        /// Handles the Click event of the UnAuthorizeUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void UnAuthorizeUser_Click(object sender, EventArgs e)
        {
            try
            {
                AuthorizeUser(false);
                lblError.Text = GetLocalResourceObject("UserUnAuthorizedMessage").ToString(); 
            }
            catch
            {
                lblError.Text = GetLocalResourceObject("UserUnAuthorizedError").ToString();
            }
        }


        /// <summary>
        /// Authorizes the user.
        /// </summary>
        /// <param name="isAuthorized">if set to <c>true</c> [is authorized].</param>
        private void AuthorizeUser(bool isAuthorized)
        {
            MembershipUser user = UserManager.GetUser(UserId);
            if (user != null)
            {
                user.IsApproved = isAuthorized;
                Authorized.Checked = isAuthorized;
                UserManager.UpdateUser(user);
                cmdAuthorize.Visible = !isAuthorized;
                ibAuthorize.Visible = !isAuthorized;
                cmdUnAuthorize.Visible = isAuthorized;
                ibUnAuthorize.Visible = isAuthorized;
            }
        }

      
    }
}