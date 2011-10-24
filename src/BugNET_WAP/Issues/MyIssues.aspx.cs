using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues
{
    public partial class MyIssues : BasePage
    {
        string BooleanOperator = "AND";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity == null || !User.Identity.IsAuthenticated)
                ErrorRedirector.TransferToLoginPage(this);

            if (!Page.IsPostBack)
            {
                ctlDisplayIssues.PageSize = WebProfile.Current.IssuesPageSize;
                ctlDisplayIssues.CurrentPageIndex = 0;

                DisplayNameLabel.Text = string.Format(this.GetLocalResourceObject("MyIssuesPage_Title.Text").ToString(), Security.GetDisplayName());

                ProjectListBoxFilter.DataSource = ProjectManager.GetProjectsByMemberUserName(Context.User.Identity.Name);
                ProjectListBoxFilter.DataTextField = "Name";
                ProjectListBoxFilter.DataValueField = "Id";
                ProjectListBoxFilter.DataBind();
                ProjectListBoxFilter.Items.Insert(0, new ListItem(this.GetLocalResourceObject("ProjectListBoxFilter_SelectAll.Text").ToString()));
                ProjectListBoxFilter.SelectedIndex = 0;

                if (ViewIssuesDropDownFilter.SelectedValue == "Closed")
                {
                    ExcludeClosedIssuesFilter.Enabled = false;
                }
                else
                {
                    ExcludeClosedIssuesFilter.Enabled = true;
                }
                BindIssues();
            }
        }

        /// <summary>
        /// Handles the Changed event of the ProjectListBoxFilter control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ProjectListBoxFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindIssues();
        }

        /// <summary>
        /// Issueses the rebind.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void IssuesRebind(Object s, EventArgs e)
        {
            BindIssues();
        }

        /// <summary>
        /// Views the selected index changed.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void MyIssuesFilterChanged(Object s, EventArgs e)
        {
            ctlDisplayIssues.CurrentPageIndex = 0;

            if (ViewIssuesDropDownFilter.SelectedValue == "Closed")
                ExcludeClosedIssuesFilter.Enabled = false;
            else
                ExcludeClosedIssuesFilter.Enabled = true;

            BindIssues();
        }

        /// <summary>
        /// Gets the total assigned issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalAssignedIssueCount()
        {
            MembershipUser user = Membership.GetUser();
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause(BooleanOperator, "IssueAssignedUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
            return IssueManager.PerformQuery(queryClauses).Count.ToString();

        }

        /// <summary>
        /// Gets the total created issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalCreatedIssueCount()
        {
            MembershipUser user = Membership.GetUser();
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause(BooleanOperator, "IssueCreatorUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
            return IssueManager.PerformQuery(queryClauses).Count.ToString();
        }

        /// <summary>
        /// Gets the total closed issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalClosedIssueCount()
        {
            MembershipUser user = Membership.GetUser();
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause(BooleanOperator, "IssueAssignedUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
            foreach (Project p in ProjectManager.GetProjectsByMemberUserName(Context.User.Identity.Name))
            {
                List<Status> status = StatusManager.GetByProjectId(p.Id).FindAll(s => !s.IsClosedState);
                foreach (Status st in status)
                {
                    queryClauses.Add(new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false));
                }

            }
            return IssueManager.PerformQuery(queryClauses).Count.ToString();
        }

        /// <summary>
        /// Gets the total owned issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalOwnedIssueCount()
        {
            MembershipUser user = Membership.GetUser();
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause(BooleanOperator, "IssueOwnerUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
            return IssueManager.PerformQuery(queryClauses).Count.ToString();
        }

        /// <summary>
        /// Gets the total monitored issues count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalMonitoredIssuesCount()
        {
            return IssueManager.GetMonitoredIssuesByUserName(Security.GetUserName(), false).Count.ToString();
        }

        /// <summary>
        /// Binds the issues.
        /// </summary>
        private void BindIssues()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            MembershipUser user = Membership.GetUser();
            if (ViewIssuesDropDownFilter.SelectedValue == "Monitored")
            {
                ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=15&ec={0}", ExcludeClosedIssuesFilter.Checked);
                ctlDisplayIssues.DataSource = IssueManager.GetMonitoredIssuesByUserName(Security.GetUserName(), ExcludeClosedIssuesFilter.Checked);
                ctlDisplayIssues.DataBind();
            }
            else
            {
                switch (ViewIssuesDropDownFilter.SelectedValue)
                {
                    case "Assigned":
                        queryClauses.Add(new QueryClause(BooleanOperator, "IssueAssignedUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=16&ec={0}", ExcludeClosedIssuesFilter.Checked);
                        break;
                    case "Closed":
                        queryClauses.Add(new QueryClause(BooleanOperator, "IssueAssignedUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
                        foreach (Project p in ProjectManager.GetProjectsByMemberUserName(Context.User.Identity.Name))
                        {
                            List<Status> status = StatusManager.GetByProjectId(p.Id).FindAll(s => !s.IsClosedState);
                            foreach (Status st in status)
                            {
                                queryClauses.Add(new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false));
                            }
                        }
                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=17");
                        break;
                    case "Owned":
                        queryClauses.Add(new QueryClause(BooleanOperator, "IssueOwnerUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=18&ec={0}", ExcludeClosedIssuesFilter.Checked);
                        break;
                    case "Created":
                        queryClauses.Add(new QueryClause(BooleanOperator, "IssueCreatorUserId", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));
                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=19&ec={0}", ExcludeClosedIssuesFilter.Checked);
                        break;
                }

                if (ExcludeClosedIssuesFilter.Checked && ViewIssuesDropDownFilter.SelectedValue != "Closed")
                {
                    foreach (Project p in ProjectManager.GetProjectsByMemberUserName(Context.User.Identity.Name))
                    {
                        var status = StatusManager.GetByProjectId(p.Id).FindAll(s => s.IsClosedState);
                        queryClauses.AddRange(status.Select(st => new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false)));
                    }
                }

                //List<Issue> issues = Issue.PerformQuery(0, queryClauses);
                if (ProjectListBoxFilter.SelectedIndex != 0)
                    ctlDisplayIssues.DataSource = IssueManager.PerformQuery(queryClauses).FindAll(i => PresentationUtils.GetSelectedItemsIntegerList(ProjectListBoxFilter).Contains(i.ProjectId));
                else
                    ctlDisplayIssues.DataSource = IssueManager.PerformQuery(queryClauses);
                ctlDisplayIssues.DataBind();

            }

        }
    }
}