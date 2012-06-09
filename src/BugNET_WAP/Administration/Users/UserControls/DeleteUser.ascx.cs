using System;
using System.Web.UI;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Users.UserControls
{
    public partial class DeleteUser : BaseUserControlUserAdmin, IEditUserControl
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public event ActionEventHandler Action;

        void OnAction(ActionEventArgs args)
        {
            if (Action != null)
                Action(this, args);
        }

        public Guid UserId
        {
            get { return ViewState.Get("UserId", Guid.Empty); }
            set { ViewState.Set("UserId", value); }
        }

        public void Initialize()
        {
            GetMembershipData(UserId);
            cmdDeleteUser.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("ConfirmDeleteUser").ToString().Trim().JsEncode()));
            cmdUnauthorizeAccount.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("ConfirmUnauthorizeUser").ToString().Trim().JsEncode()));
        }

        /// <summary>
        /// Handles the Click event of the cmdUnauthorizeAccount control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void UnauthorizeAccountClick(object sender, EventArgs e)
        {
            try
            {
                GetMembershipData(UserId); 
                MembershipData.IsApproved = false;
                UserManager.UpdateUser(MembershipData);
                Response.Redirect("~/Administration/Users/UserList.aspx");
            }
            catch (Exception)
            {
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("UserUnAuthorizedError"));
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdDeleteUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void DeleteUserClick(object sender, EventArgs e)
        {
            try
            {
                GetMembershipData(UserId);
                System.Web.Security.Membership.DeleteUser(MembershipData.UserName);
                Response.Redirect("~/Administration/Users/UserList.aspx");
            }
            catch (Exception)
            {
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("DeleteUserError"));
            }
        }

        protected void CmdCancelClick(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Administration/Users/UserList.aspx");
        }
    }
}