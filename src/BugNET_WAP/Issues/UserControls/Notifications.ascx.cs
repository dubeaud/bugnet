using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class Notifications : System.Web.UI.UserControl, IIssueTab
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
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return ViewState.Get("IssueId", 0); }
            set { ViewState.Set("IssueId", value); }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ViewState.Get("ProjectId", 0); }
            set { ViewState.Set("ProjectId", value); }
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            BindNotifications();

            //check users role permission for subscribing to an issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.SubscribeIssue.ToString()))
                pnlNotifications.Visible = false;

            if (UserManager.IsInRole(Globals.SUPER_USER_ROLE) || UserManager.IsInRole(Globals.ProjectAdminRole))
            {
                pnlNotificationAdmin.Visible = true;
            }
            else
            {
                pnlNotificationAdmin.Visible = false;
            }
        }

        /// <summary>
        /// Binds the notifications.
        /// </summary>
        private void BindNotifications()
        {
            NotificationsDataGrid.DataSource = IssueNotificationManager.GetByIssueId(IssueId);
            NotificationsDataGrid.DataBind();

            lstProjectUsers.DataSource = UserManager.GetUsersByProjectId(ProjectId);
            lstProjectUsers.DataBind();
            List<IssueNotification> CurrentUsers = IssueNotificationManager.GetByIssueId(IssueId);
            foreach (IssueNotification item in CurrentUsers)
            {
                if (lstProjectUsers.Items.FindByValue(item.NotificationUsername) != null)
                {
                    ListItem DelIndex = null;
                    DelIndex = lstProjectUsers.Items.FindByValue(item.NotificationUsername);
                    lstProjectUsers.Items.Remove(DelIndex);
                }
            }
           
            lstNotificationUsers.DataSource = CurrentUsers;
            lstNotificationUsers.DataBind();
        }

        /// <summary>
        /// Handles the Click event of the btnDontRecieveNotfictaions control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void btnDontRecieveNotfictaions_Click(object sender, EventArgs e)
        {
            var notify = new IssueNotification { IssueId = IssueId, NotificationUsername = Page.User.Identity.Name };
            IssueNotificationManager.Delete(notify);
            BindNotifications();
        }

        /// <summary>
        /// Handles the Click event of the btnReceiveNotifications control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void btnReceiveNotifications_Click(object sender, EventArgs e)
        {
            var notify = new IssueNotification { IssueId = IssueId, NotificationUsername = Page.User.Identity.Name};
            IssueNotificationManager.SaveOrUpdate(notify);

            BindNotifications();
        }

        /// <summary>
        /// Admin Notification List edit Add Button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAddNot_Click(object sender, EventArgs e)
        {
            if (lstProjectUsers.SelectedItem == null) return;

            var notify = new IssueNotification { IssueId = IssueId, NotificationUsername = lstProjectUsers.SelectedItem.Value};
            IssueNotificationManager.SaveOrUpdate(notify);
            BindNotifications();
        }

        /// <summary>
        /// Admin Notification List edit Remove Button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelNot_Click(object sender, EventArgs e)
        {
            if (lstNotificationUsers.SelectedItem == null) return;

            var notify = new IssueNotification { IssueId = IssueId, NotificationUsername = lstNotificationUsers.SelectedItem.Value };
            IssueNotificationManager.Delete(notify);
            BindNotifications();
        }
    }
}