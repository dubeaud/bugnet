using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    /// <summary>
	///		Summary description for ParentBugs.
	/// </summary>
	public partial class ParentIssues : System.Web.UI.UserControl, IIssueTab
	{
        public ParentIssues()
        {
            ProjectId = 0;
            IssueId = 0;
        }

        /// <summary>
        /// Binds the related.
        /// </summary>
		protected void BindRelated() 
		{
			IssuesDataGrid.DataSource = RelatedIssueManager.GetParentIssues(IssueId);
            IssuesDataGrid.DataKeyField = "IssueId";
            IssuesDataGrid.DataBind();
		}


        /// <summary>
        /// GRDs the bugs item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		protected void GrdIssueItemDataBound(Object s, DataGridItemEventArgs e) 
		{
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var currentBug = (RelatedIssue)e.Item.DataItem;

            var labelIssueId = (Label)e.Item.FindControl("IssueIdLabel");
            labelIssueId.Text = currentBug.IssueId.ToString();

            var lblIssueStatus = (Label)e.Item.FindControl("IssueStatusLabel");
            lblIssueStatus.Text = currentBug.Status;

            var lblIssueResolution = (Label)e.Item.FindControl("IssueResolutionLabel");
            lblIssueResolution.Text = currentBug.Resolution;
		}

        /// <summary>
        /// GRDs the bugs item command.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		protected void GrdBugsItemCommand(Object s, DataGridCommandEventArgs e) 
		{
            var currentIssueId = (int)IssuesDataGrid.DataKeys[e.Item.ItemIndex];

            RelatedIssueManager.DeleteParentIssue(IssueId, currentIssueId);

            var history = new IssueHistory
            {
                IssueId = IssueId,
                CreatedUserName = Security.GetUserName(),
                DateChanged = DateTime.Now,
                FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ParentIssue", "Parent Issue"),
                OldValue = string.Empty,
                NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Deleted", "Deleted")
            };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

			BindRelated();
		}

        /// <summary>
        /// Adds the related issue.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void AddRelatedIssue(Object s, EventArgs e) 
		{
			if (IssueIdTextBox.Text == String.Empty)
				return;

            if (!Page.IsValid) return;

            RelatedIssueManager.CreateNewParentIssue(IssueId, Int32.Parse(IssueIdTextBox.Text) );

            var history = new IssueHistory
                              {
                                  IssueId = IssueId,
                                  CreatedUserName = Security.GetUserName(),
                                  DateChanged = DateTime.Now,
                                  FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ParentIssue", "Parent Issue"),
                                  OldValue = string.Empty,
                                  NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added")
                              };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            IssueIdTextBox.Text = String.Empty;
            BindRelated();
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
            BindRelated();

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteParentIssue.ToString()))
                IssuesDataGrid.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddParentIssue.ToString()))
                AddParentIssuePanel.Visible = false;
        }


        #endregion
    }
}
