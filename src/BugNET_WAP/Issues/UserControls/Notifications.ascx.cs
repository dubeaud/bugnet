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
        private int _IssueId = 0;
        private int _ProjectId = 0;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IIssueTab Members

        /// <summary>
        /// Gets or sets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set { _IssueId = value; }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return _ProjectId; }
            set { _ProjectId = value; }
        }


        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            BindNotifications();

            //check users role permission for subscribing to an issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.SUBSCRIBE_ISSUE.ToString()))
                pnlNotifications.Visible = false;

            if (UserManager.IsInRole(Globals.SuperUserRole) || UserManager.IsInRole(Globals.ProjectAdminRole))
            {
                pnlNotificationAdmin.Visible = true;
            }
            else
            {
                pnlNotificationAdmin.Visible = false;
            }
        }

        #endregion


        /// <summary>
        /// Binds the notifications.
        /// </summary>
        private void BindNotifications()
        {
            NotificationsDataGrid.DataSource = IssueNotificationManager.GetIssueNotificationsByIssueId(IssueId);
            NotificationsDataGrid.DataBind();

            lstProjectUsers.DataSource = UserManager.GetUsersByProjectId(_ProjectId);
            lstProjectUsers.DataBind();
            List<IssueNotification> CurrentUsers = IssueNotificationManager.GetIssueNotificationsByIssueId(IssueId);
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
            IssueNotificationManager.DeleteIssueNotification(IssueId, Page.User.Identity.Name);
            BindNotifications();
        }

        /// <summary>
        /// Handles the Click event of the btnReceiveNotifications control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void btnReceiveNotifications_Click(object sender, EventArgs e)
        {
            IssueNotification notify = new IssueNotification(IssueId, Page.User.Identity.Name);
            IssueNotificationManager.SaveIssueNotification(notify);

            BindNotifications();
        }

        /// <summary>
        /// Admin Notification List edit Add Button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAddNot_Click(object sender, EventArgs e)
        {
            if (lstProjectUsers.SelectedItem != null)
            {
                IssueNotification notify = new IssueNotification(IssueId, lstProjectUsers.SelectedItem.Value);
                IssueNotificationManager.SaveIssueNotification(notify);
                BindNotifications();
            }
        }

        /// <summary>
        /// Admin Notification List edit Remove Button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDelNot_Click(object sender, EventArgs e)
        {
            if (lstNotificationUsers.SelectedItem != null)
            {
                IssueNotificationManager.DeleteIssueNotification(IssueId, lstNotificationUsers.SelectedItem.Value);
                BindNotifications();
            }
        }
    }
}