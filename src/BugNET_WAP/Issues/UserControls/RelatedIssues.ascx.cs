using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class RelatedIssues : System.Web.UI.UserControl, IIssueTab
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
            BindRelatedIssues();

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteRelated.ToString()))
                RelatedIssuesDataGrid.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddRelated.ToString()))
                AddRelatedIssuePanel.Visible = false;
        }

        #endregion

        /// <summary>
        /// Binds the related issues.
        /// </summary>
        private void BindRelatedIssues()
        {
            List<RelatedIssue> Issues = RelatedIssueManager.GetRelatedIssues(IssueId);
            if (Issues.Count == 0)
            {
                RelatedIssuesLabel.Text = GetLocalResourceObject("NoRelatedIssues").ToString();
                RelatedIssuesLabel.Visible = true;
                RelatedIssuesDataGrid.Visible = false;
            }
            else
            {
                RelatedIssuesDataGrid.DataSource = Issues;
                RelatedIssuesDataGrid.DataKeyField = "IssueId";
                RelatedIssuesDataGrid.DataBind();
                RelatedIssuesLabel.Visible = false;
                RelatedIssuesDataGrid.Visible = true;
            }

        }

        /// <summary>
        /// GRDs the issue item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdIssueItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                RelatedIssue currentBug = (RelatedIssue)e.Item.DataItem;

                Label lblIssueId = (Label)e.Item.FindControl("IssueIdLabel");
                lblIssueId.Text = currentBug.IssueId.ToString();
                Label lblIssueStatus = (Label)e.Item.FindControl("IssueStatusLabel");
                lblIssueStatus.Text = currentBug.Status;
                Label lblIssueResolution = (Label)e.Item.FindControl("IssueResolutionLabel");
                lblIssueResolution.Text = currentBug.Resolution;
            }
        }


        /// <summary>
        /// Handles the Click event of the cmdUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdAddRelatedIssue_Click(object sender, EventArgs e)
        {
            if (txtRelatedIssue.Text == String.Empty)
                return;

            if (Page.IsValid)
            {
                RelatedIssuesMessage.Visible = false;
                int secondaryIssueId = Int32.Parse(txtRelatedIssue.Text);
                RelatedIssueManager.CreateNewRelatedIssue(_IssueId, secondaryIssueId);
                txtRelatedIssue.Text = String.Empty;

                IssueHistory history = new IssueHistory(_IssueId, Security.GetUserName(), Resources.SharedResources.RelatedIssue.ToString(), string.Empty, Resources.SharedResources.Added);
                IssueHistoryManager.SaveIssueHistory(history);

                List<IssueHistory> changes = new List<IssueHistory>();
                changes.Add(history);

                IssueNotificationManager.SendIssueNotifications(_IssueId, changes);

                BindRelatedIssues();   
            }

        }

        /// <summary>
        /// Handles the ItemCommand event of the dtgRelatedIssues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void RelatedIssuesDataGrid_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            int currentIssueId = (int)RelatedIssuesDataGrid.DataKeys[e.Item.ItemIndex];
            RelatedIssueManager.DeleteRelatedIssue(this.IssueId, currentIssueId);

            IssueHistory history = new IssueHistory(_IssueId, Security.GetUserName(), Resources.SharedResources.RelatedIssue.ToString(), string.Empty, Resources.SharedResources.Deleted);
            IssueHistoryManager.SaveIssueHistory(history);

            List<IssueHistory> changes = new List<IssueHistory>();
            changes.Add(history);

            IssueNotificationManager.SendIssueNotifications(_IssueId, changes);

            BindRelatedIssues();
        }
    }
}