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
        protected ParentIssues()
        {
            ProjectId = 0;
            IssueId = 0;
        }

        /// <summary>
        /// Binds the related.
        /// </summary>
        private void BindRelated() 
		{
            var issues = RelatedIssueManager.GetParentIssues(IssueId);

            if (issues.Count == 0)
            {
                NoIssuesLabel.Text = GetLocalResourceObject("NoParentIssues").ToString();
                NoIssuesLabel.Visible = true;
                IssuesDataGrid.Visible = false;
            }
            else
            {
                IssuesDataGrid.DataSource = issues;
                IssuesDataGrid.DataKeyField = "IssueId";
                IssuesDataGrid.DataBind();
                NoIssuesLabel.Visible = false;
                IssuesDataGrid.Visible = true;
            }
		}

        /// <summary>
        /// GRDs the bugs item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		protected void GrdIssueItemDataBound(Object s, DataGridItemEventArgs e) 
		{
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var cmdDelete = e.Item.FindControl("cmdDelete") as ImageButton;
            if (cmdDelete != null)
                cmdDelete.OnClientClick = string.Format("return confirm('{0}');", GetLocalResourceObject("RemoveParentIssue"));
		}

        /// <summary>
        /// GRDs the bugs item command.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		protected void GrdBugsItemCommand(Object s, DataGridCommandEventArgs e) 
		{
            var commandArgument = e.CommandArgument.ToString();
            var commandName = e.CommandName.ToLower().Trim();
            var currentIssueId = Globals.NEW_ID;

            switch (commandName)
            {
                case "delete":
                    currentIssueId = int.Parse(commandArgument);
                    RelatedIssueManager.DeleteParentIssue(IssueId, currentIssueId);
                    break;
            }

            if (currentIssueId > Globals.NEW_ID)
            {
                var history = new IssueHistory
                {
                    IssueId = IssueId,
                    CreatedUserName = Security.GetUserName(),
                    DateChanged = DateTime.Now,
                    FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ParentIssue", "Parent Issue"),
                    OldValue = string.Empty,
                    NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Deleted", "Deleted"),
                    TriggerLastUpdateChange = true
                };

                IssueHistoryManager.SaveOrUpdate(history);

                var changes = new List<IssueHistory> { history };

                IssueNotificationManager.SendIssueNotifications(IssueId, changes);
            }

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
                NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added"),
                TriggerLastUpdateChange = true
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
