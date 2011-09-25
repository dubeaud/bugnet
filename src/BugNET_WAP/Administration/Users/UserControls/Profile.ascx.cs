using System;
using System.Web.Security;
using BugNET.BLL;

namespace BugNET.Administration.Users.UserControls
{
    public partial class Profile : System.Web.UI.UserControl
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
            //get this user and bind the data
            MembershipUser user = UserManager.GetUser(UserId);
            if (user != null)
            {
                lblUserName.Text = user.UserName;
                WebProfile Profile = new WebProfile().GetProfile(user.UserName);
                FirstName.Text = Profile.FirstName;
                LastName.Text = Profile.LastName;
                DisplayName.Text = Profile.DisplayName;
                //Fax.Text = Profile.ContactInfo.Fax;
                //Mobile.Text = Profile.ContactInfo.Mobile;
                //Telephone.Text = Profile.ContactInfo.Telephone;
            }
        }
      

        /// <summary>
        /// Gets the user id.
        /// </summary>
        /// <value>The user id.</value>
        public Guid UserId
        {
            get
            {
                if (Request.QueryString["user"] != null || Request.QueryString["user"].Length != 0)
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
                MembershipUser user = UserManager.GetUser(UserId);
                if (user != null)
                {
                    WebProfile Profile = new WebProfile().GetProfile(user.UserName);
                    Profile.DisplayName = DisplayName.Text;
                    Profile.FirstName = FirstName.Text;
                    Profile.LastName = LastName.Text;
                    //Profile.ContactInfo.Fax = Fax.Text;
                    //Profile.ContactInfo.Mobile = Mobile.Text;
                    //Profile.ContactInfo.Telephone = Telephone.Text;
                    Profile.Save();
                }
            }
            catch
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("ProfileUpdateError");
            }
        }
    }
}