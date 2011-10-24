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
	///		Summary description for SubIssues.
	/// </summary>
	public partial class SubIssues : System.Web.UI.UserControl, IIssueTab
	{
        protected SubIssues()
        {
            ProjectId = 0;
            IssueId = 0;
        }

        /// <summary>
        /// Binds the related.
        /// </summary>
        private void BindRelated() 
		{
			grdIssues.DataSource = RelatedIssueManager.GetChildIssues(IssueId);
			grdIssues.DataKeyField = "IssueId";
			grdIssues.DataBind();
		}


        /// <summary>
        /// GRDs the bugs item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		protected void GrdIssuesItemDataBound(Object s, DataGridItemEventArgs e) 
		{
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var currentIssue = (RelatedIssue)e.Item.DataItem;

            var labelIssueId = (Label)e.Item.FindControl( "lblIssueId" );
            labelIssueId.Text = currentIssue.IssueId.ToString();

            var lblIssueStatus = (Label)e.Item.FindControl("IssueStatusLabel");
            lblIssueStatus.Text = currentIssue.Status;

            var lblIssueResolution = (Label)e.Item.FindControl("IssueResolutionLabel");
            lblIssueResolution.Text = currentIssue.Resolution;
		}

        /// <summary>
        /// GRDs the bugs item command.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		protected void GrdIssuesItemCommand(Object s, DataGridCommandEventArgs e) 
		{
			var issueId = (int)grdIssues.DataKeys[e.Item.ItemIndex];
			RelatedIssueManager.DeleteChildIssue(IssueId, issueId);

            var history = new IssueHistory
                              {
                                  IssueId = IssueId,
                                  DateChanged = DateTime.Now,
                                  CreatedUserName = Security.GetUserName(),
                                  FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ChildIssue", "Child Issue"),
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
			if (txtIssueId.Text == String.Empty) return;

            if (!Page.IsValid) return;

            RelatedIssueManager.CreateNewChildIssue(IssueId, Int32.Parse(txtIssueId.Text) );

            var history = new IssueHistory
            {
                IssueId = IssueId,
                DateChanged = DateTime.Now,
                CreatedUserName = Security.GetUserName(),
                FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ChildIssue", "Child Issue"),
                OldValue = string.Empty,
                NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added")
            };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            txtIssueId.Text = String.Empty;
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

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteSubIssue.ToString()))
                grdIssues.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddSubIssue.ToString()))
                AddSubIssuePanel.Visible = false;
        }
        #endregion
    }
}
