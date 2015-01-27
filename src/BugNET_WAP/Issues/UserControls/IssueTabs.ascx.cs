using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class IssueTabs : UserControl
    {

        private readonly string[] _tabNames = {
                                         "TabAttachments",
                                         "TabComments",
                                         "TabHistory",
                                         "TabNotifications",
                                         "TabParentIssues",
                                         "TabRelatedIssues",
                                         "TabRevisions",
                                         "TabSubIssues",
                                         "TabTimeTracking"
                                     };

        protected IssueTabs()
        {
            ProjectId = 0;
            IssueId = 0;
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
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        void Page_Load(object sender, EventArgs e)
        {
            if (IssueId == 0)
                return;

            if (!Page.IsPostBack)
            {
                IssueTabsMenu.Items.Add(new MenuItem(GetTabName(GetLocalResourceObject("Comments").ToString(), "0"), "TabComments", "~/images/comment.gif"));
                if(HostSettingManager.Get(HostSettingNames.AllowAttachments, false) && ProjectManager.GetById(ProjectId).AllowAttachments)
                {
                    IssueTabsMenu.Items.Add(new MenuItem(GetTabName(GetLocalResourceObject("Attachments").ToString(), "1"), "TabAttachments", "~/images/attach.gif"));
                }
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("History").ToString(), "TabHistory", "~/images/history.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("Notifications").ToString(), "TabNotifications", "~/images/email.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("SubIssues").ToString(), "TabSubIssues", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("ParentIssues").ToString(), "TabParentIssues", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("RelatedIssues").ToString(), "TabRelatedIssues", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("Revisions").ToString(), "TabRevisions", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("TimeTracking").ToString(), "TabTimeTracking", "~/images/time.gif"));
                IssueTabsMenu.Items[0].Selected = true;
                LoadTab(IssueTabsMenu.SelectedValue);
            }
        }

        /// <summary>
        /// Refreshes the tab names.
        /// </summary>
        private void RefreshTabNames()
        {
            foreach (MenuItem item in IssueTabsMenu.Items)
            {
                item.Text = GetTabName(item.Text.LastIndexOf('(') != -1 ? 
                    item.Text.Substring(0,item.Text.LastIndexOf('(')) : 
                    item.Text, item.Value);
            }
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
           RefreshTabNames();
        }

        /// <summary>
        /// Handles the Click event of the IssueTabsMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.MenuEventArgs"/> instance containing the event data.</param>
        protected void IssueTabsMenu_Click(object sender, MenuEventArgs e)
        {
            LoadTab(e.Item.Value);

        }

        /// <summary>
        /// Loads the tab.
        /// </summary>
        void LoadTab(string selectedTab)
        {
            var updatePanel = FindControl("IssueTabsUpdatePanel");

            foreach (var tabControl in _tabNames.Select(updatePanel.FindControl).OfType<UserControl>())
            {
                tabControl.Visible = false;
                if (!selectedTab.Equals(tabControl.ID)) continue;

                tabControl.Visible = true;
                ((IIssueTab)tabControl).IssueId = IssueId;
                ((IIssueTab)tabControl).ProjectId = ProjectId;
                ((IIssueTab)tabControl).Initialize();
            }
        }

        /// <summary>
        /// Gets the name of the tab.
        /// </summary>
        /// <param name="tabName"></param>
        /// <param name="tabValue"></param>
        /// <returns></returns>
        private string GetTabName(string tabName, string tabValue)
        {
            int cnt ;
            switch (tabValue.ToLower())
            {
                case "tabcomments":
                    cnt = IssueId == 0 ? 0 : IssueCommentManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "bold");
                case "tabhistory":
                    cnt = IssueId == 0 ? 0 : IssueHistoryManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "normal");
                case "tabattachments":
                    cnt = IssueId == 0 ? 0 : IssueAttachmentManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "bold");
                case "tabnotifications":
                    cnt = IssueId == 0 ? 0 : IssueNotificationManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "normal");
                case "tabrelatedissues":
                    cnt = IssueId == 0 ? 0 : RelatedIssueManager.GetRelatedIssues(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "bold");
                case "tabparentissues":
                    cnt = IssueId == 0 ? 0 : RelatedIssueManager.GetParentIssues(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "bold");
                case "tabsubissues":
                    cnt = IssueId == 0 ? 0 : RelatedIssueManager.GetChildIssues(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "bold");
                case "tabrevisions":
                    cnt = IssueId == 0 ? 0 : IssueRevisionManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "normal");
                case "tabtimetracking":
                    cnt = IssueId == 0 ? 0 : IssueWorkReportManager.GetByIssueId(IssueId).Count;
                    return string.Format("<span class='{2}'>{0} ({1})</span>", tabName, cnt, cnt == 0 ? "normal" : "normal");
                default:
                    return tabName;
            }
        }

        protected void Unnamed_ServerClick(object sender, EventArgs e)
        {
            ((System.Web.UI.HtmlControls.HtmlAnchor)sender).Attributes.Add("class", "active");
        }
    }
}