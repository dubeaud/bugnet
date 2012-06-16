using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues
{
    public partial class MyIssues : BasePage
    {
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

            ExcludeClosedIssuesFilter.Enabled = ViewIssuesDropDownFilter.SelectedValue != "Closed";

            BindIssues();
        }

        /// <summary>
        /// Returns a list of QueryClauses for items selected in the Project list (will handle the Select All too)
        /// </summary>
        /// <param name="returnAll">When true will return all project id's from the listbox, otherwise only the selected items</param>
        /// <returns></returns>
        private IEnumerable<QueryClause> GetProjectQueryClauses(bool returnAll)
        {
            var queryClauses = new List<QueryClause>();

            var projects = PresentationUtils.GetSelectedItemsIntegerList(ProjectListBoxFilter, returnAll).Where(project => project > Globals.NEW_ID).ToList();

            if (projects.Count > 0)
            {
                var first = true;

                queryClauses.Add(new QueryClause("AND (", "", "", "", SqlDbType.NVarChar, false));
                foreach (var project in projects)
                {
                    queryClauses.Add(new QueryClause((first) ? "" : "OR", "iv.[ProjectId]", "=", project.ToString(), SqlDbType.NVarChar, false));
                    first = false;
                }
                queryClauses.Add(new QueryClause(")", "", "", "", SqlDbType.NVarChar, false));
            }

            return queryClauses;
        }

        /// <summary>
        /// Gets the total assigned issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalAssignedIssueCount()
        {
            var user = Membership.GetUser();

            if (user == null) return "0";
            if (user.ProviderUserKey == null) return "0";

            var queryClauses = new List<QueryClause>
            {
                // do not include disabled projects
                new QueryClause("AND", "iv.[ProjectDisabled]", "=", "0", SqlDbType.Int, false),

                // do not include disabled issues
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int, false),

                // add the user id to the filtered field
                new QueryClause("AND", "iv.[IssueAssignedUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false)
            };

            // return the projects in the list box, this represents all the projects the user has access to
            // pre filtered on the page load
            queryClauses.AddRange(GetProjectQueryClauses(true));

            return IssueManager.PerformQuery(queryClauses, null).Count.ToString();
        }

        /// <summary>
        /// Gets the total created issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalCreatedIssueCount()
        {
            var user = Membership.GetUser();

            if (user == null) return "0";
            if (user.ProviderUserKey == null) return "0";

            var queryClauses = new List<QueryClause>
            {
                // do not include disabled projects
                new QueryClause("AND", "iv.[ProjectDisabled]", "=", "0", SqlDbType.Int, false),

                // do not include disabled issues
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int, false),

                // add the user id to the filtered field
                new QueryClause("AND", "iv.[IssueCreatorUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false)
            };

            // return the projects in the list box, this represents all the projects the user has access to
            // pre filtered on the page load
            queryClauses.AddRange(GetProjectQueryClauses(true));

            return IssueManager.PerformQuery(queryClauses, null).Count.ToString();
        }

        /// <summary>
        /// Gets the total closed issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalClosedIssueCount()
        {
            var user = Membership.GetUser();

            if (user == null) return "0";
            if (user.ProviderUserKey == null) return "0";

            var queryClauses = new List<QueryClause>
            {
                // do not include disabled projects
                new QueryClause("AND", "iv.[ProjectDisabled]", "=", "0", SqlDbType.Int, false),

                // do not include disabled issues
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int, false),

                // only closed issue
                new QueryClause("AND", "iv.[IsClosed]", "=", "1", SqlDbType.Int, false),

                // add the user id to the filtered field
                new QueryClause("AND", "iv.[IssueAssignedUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false)
            };

            // return the projects in the list box, this represents all the projects the user has access to
            // pre filtered on the page load
            queryClauses.AddRange(GetProjectQueryClauses(true));

            return IssueManager.PerformQuery(queryClauses, null).Count.ToString();
        }

        /// <summary>
        /// Gets the total owned issue count.
        /// </summary>
        /// <returns></returns>
        protected string GetTotalOwnedIssueCount()
        {
            var user = Membership.GetUser();

            if (user == null) return "0";
            if (user.ProviderUserKey == null) return "0";

            var queryClauses = new List<QueryClause>
            {
                // do not include disabled projects
                new QueryClause("AND", "iv.[ProjectDisabled]", "=", "0", SqlDbType.Int, false),

                // do not include disabled issues
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int, false),

                // add the user id to the filtered field
                new QueryClause("AND", "iv.[IssueOwnerUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false)
            };

            // return the projects in the list box, this represents all the projects the user has access to
            // pre filtered on the page load
            queryClauses.AddRange(GetProjectQueryClauses(true));

            return IssueManager.PerformQuery(queryClauses, null).Count.ToString();
        }

        /// <summary>
        /// Gets the total monitored issues count.
        /// </summary>
        /// <returns></returns>
        protected static string GetTotalMonitoredIssuesCount()
        {
            return IssueManager.GetMonitoredIssuesByUserName(Security.GetUserName(), false).Count.ToString();
        }

        /// <summary>
        /// Binds the issues.
        /// </summary>
        private void BindIssues()
        {
            var user = Membership.GetUser();

            if (user == null) return;
            if (user.ProviderUserKey == null) return;

            var queryClauses = new List<QueryClause>
            {
                // do not include disabled projects
                new QueryClause("AND", "iv.[ProjectDisabled]", "=", "0", SqlDbType.Int, false),

                // do not include disabled issues
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int, false),
            };

            // return the projects selected in the list box, this represents all the projects the user has access to
            // pre filtered on the page load
            var selectedProjects = GetProjectQueryClauses(false);

            // hack yes but does the trick to make sure that all projects are loaded when select all is selected
            queryClauses.AddRange(GetProjectQueryClauses(selectedProjects.Count().Equals(0)));

            if (ViewIssuesDropDownFilter.SelectedValue == "Monitored")
            {
                ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=15&ec={0}", ExcludeClosedIssuesFilter.Checked);
                ctlDisplayIssues.DataSource = 
                    IssueManager.GetMonitoredIssuesByUserName(Security.GetUserName(), ExcludeClosedIssuesFilter.Checked);
                ctlDisplayIssues.DataBind();
            }
            else
            {
                switch (ViewIssuesDropDownFilter.SelectedValue)
                {
                    case "Assigned":

                        if (ExcludeClosedIssuesFilter.Checked)
                        {
                            queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int, false));
                        }

                        queryClauses.Add(new QueryClause("AND", "iv.[IssueAssignedUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));

                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=16&ec={0}", ExcludeClosedIssuesFilter.Checked);

                        break;
                    case "Closed":

                        queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "1", SqlDbType.Int, false));

                        queryClauses.Add(new QueryClause("AND", "iv.[IssueAssignedUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));

                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=17");

                        break;
                    case "Owned":

                        if (ExcludeClosedIssuesFilter.Checked)
                        {
                            queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int, false));
                        }

                        queryClauses.Add(new QueryClause("AND", "iv.[IssueOwnerUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));

                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=18&ec={0}", ExcludeClosedIssuesFilter.Checked);

                        break;
                    case "Created":

                        if (ExcludeClosedIssuesFilter.Checked)
                        {
                            queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int, false));
                        }

                        queryClauses.Add(new QueryClause("AND", "iv.[IssueCreatorUserId]", "=", user.ProviderUserKey.ToString(), SqlDbType.NVarChar, false));

                        ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?channel=19&ec={0}", ExcludeClosedIssuesFilter.Checked);
                        break;
                    default:

                        if (ExcludeClosedIssuesFilter.Checked)
                        {
                            queryClauses.Add(new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int, false));
                        }
                        break;
                }

                var sortColumns = new List<KeyValuePair<string, string>>();
                var sorter = ctlDisplayIssues.SortString;

                foreach (var sort in sorter.Split(','))
                {
                    var args = sort.Split(new[] { " " }, StringSplitOptions.RemoveEmptyEntries);
                    if (args.Length.Equals(2))
                        sortColumns.Add(new KeyValuePair<string, string>(args[0], args[1]));

                }

                ctlDisplayIssues.DataSource = IssueManager.PerformQuery(queryClauses, sortColumns);
                ctlDisplayIssues.DataBind();
            }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                ErrorRedirector.TransferToLoginPage(this);

            if (Page.IsPostBack) return;

            ctlDisplayIssues.PageSize = UserManager.GetProfilePageSize();
            ctlDisplayIssues.CurrentPageIndex = 0;

            DisplayNameLabel.Text = string.Format(GetLocalResourceObject("MyIssuesPage_Title.Text").ToString(),
                                                  Security.GetDisplayName());

            ProjectListBoxFilter.DataSource = ProjectManager.GetByMemberUserName(Context.User.Identity.Name);
            ProjectListBoxFilter.DataTextField = "Name";
            ProjectListBoxFilter.DataValueField = "Id";
            ProjectListBoxFilter.DataBind();
            ProjectListBoxFilter.Items.Insert(0, new ListItem(GetLocalResourceObject("ProjectListBoxFilter_SelectAll.Text").ToString(), "0"));
            ProjectListBoxFilter.SelectedIndex = 0;

            ExcludeClosedIssuesFilter.Enabled = ViewIssuesDropDownFilter.SelectedValue != "Closed";
            BindIssues();
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
    }
}