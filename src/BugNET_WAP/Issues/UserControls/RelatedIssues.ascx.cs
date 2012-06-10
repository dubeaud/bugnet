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
        protected RelatedIssues()
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

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteRelated.ToString()))
                grdIssueItems.Columns[4].Visible = false;

            //check users role permission for adding a related issue
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddRelated.ToString()))
                AddRelatedIssuePanel.Visible = false;
        }

        #endregion

        /// <summary>
        /// Binds the related issues.
        /// </summary>
        private void BindRelated()
        {
            var issues = RelatedIssueManager.GetRelatedIssues(IssueId);

            if (issues.Count == 0)
            {
                NoIssuesLabel.Text = GetLocalResourceObject("NoRelatedIssues").ToString();
                NoIssuesLabel.Visible = true;
                grdIssueItems.Visible = false;
            }
            else
            {
                grdIssueItems.DataSource = issues;
                grdIssueItems.DataKeyField = "IssueId";
                grdIssueItems.DataBind();
                NoIssuesLabel.Visible = false;
                grdIssueItems.Visible = true;
            }
        }

        /// <summary>
        /// GRDs the issue item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void GrdIssueItemsDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var cmdDelete = e.Item.FindControl("cmdDelete") as ImageButton;
            if (cmdDelete != null)
                cmdDelete.OnClientClick = string.Format("return confirm('{0}');", GetLocalResourceObject("RemoveRelatedIssue"));
        }


        /// <summary>
        /// Handles the Click event of the cmdUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void CmdAddRelatedIssueClick(object sender, EventArgs e)
        {
            if (IssueIdTextBox.Text == String.Empty)
                return;

            if (!Page.IsValid) return;

            RelatedIssuesMessage.Visible = false;

            var secondaryIssueId = Int32.Parse(IssueIdTextBox.Text);

            RelatedIssueManager.CreateNewRelatedIssue(IssueId, secondaryIssueId);

            IssueIdTextBox.Text = String.Empty;

            var history = new IssueHistory
            {
                IssueId = IssueId,
                CreatedUserName = Security.GetUserName(),
                DateChanged = DateTime.Now,
                FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "RelatedIssue", "Related Issue"),
                OldValue = string.Empty,
                NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added"),
                TriggerLastUpdateChange = true
            };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            BindRelated();
        }

        /// <summary>
        /// Handles the ItemCommand event of the dtgRelatedIssues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void GrdIssueItemsItemCommand(object source, DataGridCommandEventArgs e)
        {
            var commandArgument = e.CommandArgument.ToString();
            var commandName = e.CommandName.ToLower().Trim();
            var currentIssueId = Globals.NEW_ID;

            switch (commandName)
            {
                case "delete":
                    currentIssueId = int.Parse(commandArgument);
                    RelatedIssueManager.DeleteRelatedIssue(IssueId, currentIssueId);
                    break;
            }

            if (currentIssueId > Globals.NEW_ID)
            {
                var history = new IssueHistory
                {
                    IssueId = IssueId,
                    CreatedUserName = Security.GetUserName(),
                    DateChanged = DateTime.Now,
                    FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "RelatedIssue", "Related Issue"),
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
    }
}