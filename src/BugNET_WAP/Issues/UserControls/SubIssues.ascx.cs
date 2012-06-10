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
            var issues = RelatedIssueManager.GetChildIssues(IssueId);

            if (issues.Count == 0)
            {
                NoIssuesLabel.Text = GetLocalResourceObject("NoSubIssues").ToString();
                NoIssuesLabel.Visible = true;
                grdIssues.Visible = false;
            }
            else
            {
                grdIssues.DataSource = issues;
                grdIssues.DataKeyField = "IssueId";
                grdIssues.DataBind();
                NoIssuesLabel.Visible = false;
                grdIssues.Visible = true;
            }
		}


        /// <summary>
        /// GRDs the bugs item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		protected void GrdIssuesItemDataBound(Object s, DataGridItemEventArgs e) 
		{
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var cmdDelete = e.Item.FindControl("cmdDelete") as ImageButton;
            if (cmdDelete != null)
                cmdDelete.OnClientClick = string.Format("return confirm('{0}');", GetLocalResourceObject("RemoveSubIssue"));
		}

        /// <summary>
        /// GRDs the bugs item command.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		protected void GrdIssuesItemCommand(Object s, DataGridCommandEventArgs e)
        {
            var commandArgument = e.CommandArgument.ToString();
            var commandName = e.CommandName.ToLower().Trim();
            var currentIssueId = Globals.NEW_ID;

            switch (commandName)
            {
                case "delete":
                    currentIssueId = int.Parse(commandArgument);
                    RelatedIssueManager.DeleteChildIssue(IssueId, currentIssueId);
                    break;
            }

            if (currentIssueId > Globals.NEW_ID)
            {
                var history = new IssueHistory
                {
                    IssueId = IssueId,
                    DateChanged = DateTime.Now,
                    CreatedUserName = Security.GetUserName(),
                    FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ChildIssue", "Child Issue"),
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
            if (IssueIdTextBox.Text == String.Empty) return;

            if (!Page.IsValid) return;

            RelatedIssueManager.CreateNewChildIssue(IssueId, Int32.Parse(IssueIdTextBox.Text));

            var history = new IssueHistory
            {
                IssueId = IssueId,
                DateChanged = DateTime.Now,
                CreatedUserName = Security.GetUserName(),
                FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "ChildIssue", "Child Issue"),
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

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteSubIssue.ToString()))
                grdIssues.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddSubIssue.ToString()))
                AddSubIssuePanel.Visible = false;
        }
        #endregion
    }
}
