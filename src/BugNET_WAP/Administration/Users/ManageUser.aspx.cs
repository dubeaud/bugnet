using System;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Users
{
    public partial class ManageUser : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (TabId == 2)
                ShowRolesPanel(this, new EventArgs());
            else
                ShowMembershipPanel(this, new EventArgs());
        }

        /// <summary>
        /// Gets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        private int TabId
        {
            get { return Request.QueryString.Get("tabid", 0); }
        }

        /// <summary>
        /// Shows the panel.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ShowMembershipPanel(object sender, EventArgs e)
        {
            ctlMembership.DataBind();
            pnlMembership.Visible = true;
            pnlPassword.Visible = false;
            pnlProfile.Visible = false;
            pnlDelete.Visible = false;
            pnlRoles.Visible = false;
            cmdManageDetails.Enabled = false;
            ibMembership.Enabled = false;
            cmdManageRoles.Enabled = true;
            ibManageRoles.Enabled = true;
            cmdManageProfile.Enabled = true;
            ibManageProfile.Enabled = true;
            cmdManagePassword.Enabled = true;
            ibManagePassword.Enabled = true;
            cmdDelete.Enabled = true;
            ibDelete.Enabled = true;
        }

        /// <summary>
        /// Shows the roles panel.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ShowRolesPanel(object sender, EventArgs e)
        {
            ctlRoles.DataBind();
            pnlMembership.Visible = false;
            pnlPassword.Visible = false;
            pnlProfile.Visible = false;
            pnlRoles.Visible = true;
            pnlDelete.Visible = false;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageRoles.Enabled = false;
            ibManageRoles.Enabled = false;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageProfile.Enabled = true;
            ibManageProfile.Enabled = true;
            cmdManagePassword.Enabled = true;
            ibManagePassword.Enabled = true;
            cmdDelete.Enabled = true;
            ibDelete.Enabled = true;
        }

        /// <summary>
        /// Shows the profile panel.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ShowProfilePanel(object sender, EventArgs e)
        {
            ctlProfile.DataBind();
            pnlMembership.Visible = false;
            pnlPassword.Visible = false;
            pnlDelete.Visible = false;
            pnlProfile.Visible = true;
            pnlRoles.Visible = false;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageRoles.Enabled = true;
            ibManageRoles.Enabled = true;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageProfile.Enabled = false;
            ibManageProfile.Enabled = false;
            cmdManagePassword.Enabled = true;
            ibManagePassword.Enabled = true;
            cmdDelete.Enabled = true;
            ibDelete.Enabled = true;
        }

        /// <summary>
        /// Shows the delete panel.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ShowDeletePanel(object sender, EventArgs e)
        {
            ctlDeleteUser.DataBind();
            pnlMembership.Visible = false;
            pnlPassword.Visible = false;
            pnlProfile.Visible = false;
            pnlDelete.Visible = true;
            pnlRoles.Visible = false;
            cmdManageDetails.Enabled = true;
            cmdDelete.Enabled = false;
            ibDelete.Enabled = false;
            ibMembership.Enabled = true;
            cmdManageRoles.Enabled = true;
            ibManageRoles.Enabled = true;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageProfile.Enabled = true;
            ibManageProfile.Enabled = true;
            cmdManagePassword.Enabled = true;
            ibManagePassword.Enabled = true;
        }

        /// <summary>
        /// Shows the password panel.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ShowPasswordPanel(object sender, EventArgs e)
        {
            ctlPassword.DataBind();
            pnlMembership.Visible = false;
            pnlPassword.Visible = true;
            pnlProfile.Visible = false;
            pnlDelete.Visible = false;
            pnlRoles.Visible = false;
            cmdManageDetails.Enabled = true;
            cmdDelete.Enabled = true;
            ibDelete.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageRoles.Enabled = true;
            ibManageRoles.Enabled = true;
            cmdManageDetails.Enabled = true;
            ibMembership.Enabled = true;
            cmdManageProfile.Enabled = true;
            ibManageProfile.Enabled = true;
            cmdManagePassword.Enabled = false;
            ibManagePassword.Enabled = false;
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

        /// <summary>
        /// Handles the Click event of the AddUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddNewUserClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Users/AddUser.aspx");
        }
    }
}
