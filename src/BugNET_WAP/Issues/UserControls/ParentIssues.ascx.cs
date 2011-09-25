namespace BugNET.Issues.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;

    /// <summary>
	///		Summary description for ParentBugs.
	/// </summary>
	public partial class ParentIssues : System.Web.UI.UserControl, IIssueTab
	{
		
        private int _IssueId = 0;
        private int _ProjectId = 0;

        /// <summary>
        /// Binds the related.
        /// </summary>
		protected void BindRelated() 
		{
			IssuesDataGrid.DataSource = RelatedIssueManager.GetParentIssues(_IssueId);
            IssuesDataGrid.DataKeyField = "IssueId";
            IssuesDataGrid.DataBind();
		}


        /// <summary>
        /// GRDs the bugs item data bound.
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
        /// GRDs the bugs item command.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		protected void grdBugsItemCommand(Object s, DataGridCommandEventArgs e) 
		{
            int currentIssueId = (int)IssuesDataGrid.DataKeys[e.Item.ItemIndex];
            RelatedIssueManager.DeleteParentIssue(_IssueId, currentIssueId);

            IssueHistory history = new IssueHistory(_IssueId, Security.GetUserName(), Resources.SharedResources.ParentIssue.ToString(), string.Empty, Resources.SharedResources.Deleted);
            IssueHistoryManager.SaveIssueHistory(history);

            List<IssueHistory> changes = new List<IssueHistory>();
            changes.Add(history);

            IssueNotificationManager.SendIssueNotifications(_IssueId, changes);

			BindRelated();
		}

        /// <summary>
        /// Adds the related bug.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void AddRelatedIssue(Object s, EventArgs e) 
		{
			if (IssueIdTextBox.Text == String.Empty)
				return;

			if (Page.IsValid) 
			{
				RelatedIssueManager.CreateNewParentIssue(_IssueId, Int32.Parse(IssueIdTextBox.Text) );

                IssueHistory history = new IssueHistory(_IssueId, Security.GetUserName(), Resources.SharedResources.ParentIssue.ToString(), string.Empty, Resources.SharedResources.Added);
                IssueHistoryManager.SaveIssueHistory(history);

                List<IssueHistory> changes = new List<IssueHistory>();
                changes.Add(history);

                IssueNotificationManager.SendIssueNotifications(_IssueId, changes);

                IssueIdTextBox.Text = String.Empty;
				BindRelated();
			}
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
            BindRelated();

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DELETE_PARENT_ISSUE.ToString()))
                IssuesDataGrid.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.ADD_PARENT_ISSUE.ToString()))
                AddParentIssuePanel.Visible = false;
        }


        #endregion
    }
}
