using System;
using System.Web.UI;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Users.UserControls
{
    public partial class Profile : BaseUserControlUserAdmin, IEditUserControl
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public Guid UserId
        {
            get { return ViewState.Get("UserId", Guid.Empty); }
            set { ViewState.Set("UserId", value); }
        }

        public void Initialize()
        {
            BindUserData(UserId);
            DataBind();
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            if (MembershipData == null) return;

            var profile = new WebProfile().GetProfile(MembershipData.UserName);

            FirstName.Text = profile.FirstName;
            LastName.Text = profile.LastName;
            DisplayName.Text = profile.DisplayName;
        }

        /// <summary>
        /// Handles the Click event of the cmdUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CmdUpdateClick(object sender, EventArgs e)
        {
            try
            {
                if (MembershipData != null)
                {
                    var profile = new WebProfile().GetProfile(MembershipData.UserName);
                    profile.DisplayName = DisplayName.Text;
                    profile.FirstName = FirstName.Text;
                    profile.LastName = LastName.Text;
                    profile.Save();

                    ActionMessage.ShowSuccessMessage(GetLocalResourceObject("UpdateProfile").ToString());
                    OnAction(new ActionEventArgs { Trigger = Globals.ActionTriggers.Save });
                }
            }
            catch
            {
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("ProfileUpdateError"));
            }
        }

        protected void CmdCancelClick(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Administration/Users/UserList.aspx");
        }
    }
}