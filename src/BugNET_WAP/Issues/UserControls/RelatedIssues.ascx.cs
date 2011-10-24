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
        public RelatedIssues()
        {
            ProjectId = 0;
            IssueId = 0;
        }

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
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

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
            var issues = RelatedIssueManager.GetRelatedIssues(IssueId);

            if (issues.Count == 0)
            {
                RelatedIssuesLabel.Text = GetLocalResourceObject("NoRelatedIssues").ToString();
                RelatedIssuesLabel.Visible = true;
                RelatedIssuesDataGrid.Visible = false;
            }
            else
            {
                RelatedIssuesDataGrid.DataSource = issues;
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
        protected void GrdIssueItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var currentBug = (RelatedIssue)e.Item.DataItem;

            var lblIssueId = (Label)e.Item.FindControl("IssueIdLabel");
            lblIssueId.Text = currentBug.IssueId.ToString();

            var lblIssueStatus = (Label)e.Item.FindControl("IssueStatusLabel");
            lblIssueStatus.Text = currentBug.Status;

            var lblIssueResolution = (Label)e.Item.FindControl("IssueResolutionLabel");
            lblIssueResolution.Text = currentBug.Resolution;
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

            if (!Page.IsValid) return;

            RelatedIssuesMessage.Visible = false;

            var secondaryIssueId = Int32.Parse(txtRelatedIssue.Text);

            RelatedIssueManager.CreateNewRelatedIssue(IssueId, secondaryIssueId);

            txtRelatedIssue.Text = String.Empty;

            var history = new IssueHistory
                              {
                                  IssueId = IssueId,
                                  CreatedUserName = Security.GetUserName(),
                                  DateChanged = DateTime.Now,
                                  FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "RelatedIssue", "Related Issue"),
                                  OldValue = string.Empty,
                                  NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added")
                              };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            BindRelatedIssues();
        }

        /// <summary>
        /// Handles the ItemCommand event of the dtgRelatedIssues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void RelatedIssuesDataGrid_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            var currentIssueId = (int)RelatedIssuesDataGrid.DataKeys[e.Item.ItemIndex];

            RelatedIssueManager.DeleteRelatedIssue(this.IssueId, currentIssueId);

            var history = new IssueHistory
            {
                IssueId = IssueId,
                CreatedUserName = Security.GetUserName(),
                DateChanged = DateTime.Now,
                FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "RelatedIssue", "Related Issue"),
                OldValue = string.Empty,
                NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Deleted", "Deleted")
            };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            BindRelatedIssues();
        }
    }
}