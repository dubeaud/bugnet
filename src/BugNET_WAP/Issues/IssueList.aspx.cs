using System;
using System.Collections.Generic;
using System.Data;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues
{
    /// <summary>
    /// Summary description for Issue List.
    /// </summary>
    public partial class IssueList : BasePage
    {
        #region Private Variables

        private const string ISSUELISTSTATE = "IssueListState";

        #endregion

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;

            ProjectId = Request.Get("pid", -1);

            // BGN-1379
            if (ProjectId .Equals(-1))
                ErrorRedirector.TransferToNotFoundPage(Page);

            if (!User.Identity.IsAuthenticated)
            {
                dropView.Items.Remove(dropView.Items.FindByValue("Relevant"));
                dropView.Items.Remove(dropView.Items.FindByValue("Assigned"));
                dropView.Items.Remove(dropView.Items.FindByValue("Owned"));
                dropView.Items.Remove(dropView.Items.FindByValue("Created"));
                dropView.SelectedIndex = 1;
            }

            var state = (IssueListState)Session[ISSUELISTSTATE];

            if (state != null)
            {
                if (Request.QueryString.Count == 1 && state.ViewIssues == string.Empty) state.ViewIssues = "Open";

                if ((ProjectId > 0) && (ProjectId != state.ProjectId))
                {
                    Session.Remove(ISSUELISTSTATE);
                }
                else
                {
                    if (Request.QueryString.Count > 1) state.ViewIssues = string.Empty;
                    dropView.SelectedValue = state.ViewIssues;
                    ProjectId = state.ProjectId;
                    ctlDisplayIssues.CurrentPageIndex = state.IssueListPageIndex;
                    ctlDisplayIssues.SortField = state.SortField;
                    ctlDisplayIssues.SortAscending = state.SortAscending;
                    ctlDisplayIssues.PageSize = state.PageSize;
                }
            }
            else
            {
                if (Request.QueryString.Count > 1) dropView.SelectedValue = string.Empty;
            }

            BindIssues();
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void Page_PreRender(object sender, System.EventArgs e)
        {
            // Intention is to restore IssueList page state when if it is redirected back to.
            // Put all necessary data in IssueListState object and save it in the session.
            var state = (IssueListState)Session[ISSUELISTSTATE] ?? new IssueListState();

            state.ViewIssues = dropView.SelectedValue;
            state.ProjectId = ProjectId;
            state.IssueListPageIndex = ctlDisplayIssues.CurrentPageIndex;
            state.SortField = ctlDisplayIssues.SortField;
            state.SortAscending = ctlDisplayIssues.SortAscending;
            state.PageSize = ctlDisplayIssues.PageSize;
            Session[ISSUELISTSTATE] = state;
        }

        #region Querystring Properties
        /// <summary>
        /// Returns the component Id from the query string
        /// </summary>
        public string IssueCategoryId
        {
            get
            {
                return Request.Get("c", string.Empty);
            }
        }

        /// <summary>
        /// Returns the keywords from the query string
        /// </summary>
        public string Key
        {
            get
            {
                return Request.Get("key", string.Empty).Replace("+", " ");
            }
        }

        /// <summary>
        /// Returns the Milestone Id from the query string
        /// </summary>
        public string IssueMilestoneId
        {
            get
            {
                return Request.Get("m", string.Empty);
            }
        }

        /// <summary>
        /// Returns the priority Id from the query string
        /// </summary>
        public string IssuePriorityId
        {
            get
            {
                return Request.Get("p", string.Empty);
            }
        }

        /// <summary>
        /// Returns the Type Id from the query string
        /// </summary>
        public string IssueTypeId
        {
            get
            {
                return Request.Get("t", string.Empty);
            }
        }

        /// <summary>
        /// Returns the status Id from the query string
        /// </summary>
        public string IssueStatusId
        {
            get
            {
                return Request.Get("s", string.Empty);
            }
        }

        /// <summary>
        /// Returns the assigned to user Id from the query string
        /// </summary>
        public string AssignedUserId
        {
            get
            {
                return Request.Get("u", string.Empty);
            }
        }

        /// <summary>
        /// Gets the name of the reporter user.
        /// </summary>
        /// <value>The name of the reporter user.</value>
        public string ReporterUserName
        {
            get
            {
                return Request.Get("ru", string.Empty);
            }
        }

        /// <summary>
        /// Returns the hardware Id from the query string
        /// </summary>
        public string IssueResolutionId
        {
            get
            {
                return Request.Get("r", string.Empty);
            }
        }

        /// <summary>
        /// Gets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get
            {
                return Request.Get("bid", -1);
            }
        }
        #endregion

        /// <summary>
        /// Views the selected index changed.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ViewSelectedIndexChanged(Object s, EventArgs e)
        {
            ctlDisplayIssues.CurrentPageIndex = 0;

            BindIssues();
        }

        /// <summary>
        /// Issues the rebind.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void IssuesRebind(Object s, EventArgs e)
        {
            BindIssues();
        }

        /// <summary>
        /// Binds the issues.
        /// </summary>
        protected void BindIssues()
        {
            var isError = false;
            List<Issue> colIssues = null;

            if (Request.QueryString.Count > 1 && dropView.SelectedIndex == 0)
            {
                dropView.SelectedIndex = 0;
                QueryClause q;
                var isStatus = false;
                const string booleanOperator = "AND";

                var queryClauses = new List<QueryClause>();

                // add the disabled field
                q = new QueryClause(booleanOperator, "[Disabled]", "=", "0", SqlDbType.Int, false);

                queryClauses.Add(q);

                if (!string.IsNullOrEmpty(IssueCategoryId))
                {
                    q = IssueCategoryId == "0" ? 
                        new QueryClause(booleanOperator, "IssueCategoryId", "IS", null, SqlDbType.Int, false) : 
                        new QueryClause(booleanOperator, "IssueCategoryId", "=", IssueCategoryId, SqlDbType.Int, false);

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(IssueTypeId))
                {
                    q = IssueTypeId == "0" ?
                        new QueryClause(booleanOperator, "IssueTypeId", "IS", null, SqlDbType.Int, false) :
                        new QueryClause(booleanOperator, "IssueTypeId", "=", IssueTypeId, SqlDbType.Int, false);

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(IssuePriorityId))
                {
                    q = IssuePriorityId == "0" ?
                        new QueryClause(booleanOperator, "IssuePriorityId", "IS", null, SqlDbType.Int, false) :
                        new QueryClause(booleanOperator, "IssuePriorityId", "=", IssuePriorityId, SqlDbType.Int, false);

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(IssueMilestoneId))
                {
                    q = IssueMilestoneId == "0" ?
                        new QueryClause(booleanOperator, "IssueMilestoneId", "IS", null, SqlDbType.Int, false) :
                        new QueryClause(booleanOperator, "IssueMilestoneId", "=", IssueMilestoneId, SqlDbType.Int, false);

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(IssueResolutionId))
                {
                    q = IssueResolutionId == "0" ?
                        new QueryClause(booleanOperator, "IssueResolutionId", "IS", null, SqlDbType.Int, false) :
                        new QueryClause(booleanOperator, "IssueResolutionId", "=", IssueResolutionId, SqlDbType.Int, false);

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(AssignedUserId))
                {
                    Guid userId;
                    q = new QueryClause(booleanOperator, "IssueAssignedUserId", "IS", null, SqlDbType.NVarChar, false);

                    if (Guid.TryParse(AssignedUserId, out userId))
                    {
                        q = AssignedUserId == Globals.EMPTY_GUID ?
                            new QueryClause(booleanOperator, "IssueAssignedUserId", "IS", null, SqlDbType.Int, false) :
                            new QueryClause(booleanOperator, "IssueAssignedUserId", "=", AssignedUserId, SqlDbType.NVarChar, false);
                    }

                    queryClauses.Add(q);
                }

                if (!string.IsNullOrEmpty(IssueStatusId))
                {
                    if (IssueStatusId != "-1")
                    {
                        isStatus = true;

                        q = IssueStatusId == "0" ?
                            new QueryClause(booleanOperator, "IssueStatusId", "IS", null, SqlDbType.Int, false) :
                            new QueryClause(booleanOperator, "IssueStatusId", "=", IssueStatusId, SqlDbType.Int, false);

                        queryClauses.Add(q);
                    }
                    else
                    {
                        isStatus = true;
                        queryClauses.Add(new QueryClause("AND", "IsClosed", "=", "0", SqlDbType.Int, false));
                    }
                }

                // exclude all closed status's
                if (!isStatus)
                {
                    queryClauses.Add(new QueryClause("AND", "IsClosed", "=", "0", SqlDbType.Int, false));
                }

                try
                {
                    colIssues = IssueManager.PerformQuery(queryClauses, ProjectId);

                    // TODO: WARNING Potential Cross Site Scripting attack
                    // also this code only runs if the previous code does not freak out
                    ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?{0}&channel=7", Request.QueryString);
                }
                catch
                {
                    // BGN-1379
                    // This URL http://localhost/BugNET/Issues/IssueList.aspx?pid=96&c=4471%27;
                    // Generates a Input string was not in a correct format exception in
                    // Source File:  C:\Development\BugNET 0.7.921 SVN Source\branches\BugNET 0.8\src\BugNET_WAP\Old_App_Code\DAL\SqlDataProvider.cs    Line:  4932 
                    // Line 4932:                gcfr(sqlCmd.ExecuteReader(), ref List);
                    isError = true;

                    // perhaps this should rather ErrorRedirector.TransferToErrorPage(Page);
                    // but an empty grid with "There are no issues that match your criteria." looks 
                    // nice too
                }
            }
            else
            {

                switch (dropView.SelectedValue)
                {
                    case "Relevant":
                        colIssues = IssueManager.GetByRelevancy(ProjectId, User.Identity.Name);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=8", ProjectId);
                        break;
                    case "Assigned":
                        colIssues = IssueManager.GetByAssignedUserName(ProjectId, User.Identity.Name);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=9", ProjectId);
                        break;
                    case "Owned":
                        colIssues = IssueManager.GetByOwnerUserName(ProjectId, User.Identity.Name);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=10", ProjectId);
                        break;
                    case "Created":
                        colIssues = IssueManager.GetByCreatorUserName(ProjectId, User.Identity.Name);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=11", ProjectId);
                        break;
                    case "All":
                        colIssues = IssueManager.GetByProjectId(ProjectId);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=12", ProjectId);
                        break;
                    case "Open":
                        colIssues = IssueManager.GetOpenIssues(ProjectId);
                        ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=14", ProjectId);
                        break;
                    default:
                        colIssues = new List<Issue>();
                        break;
                }
            }

            if (isError) return;

            ctlDisplayIssues.DataSource = colIssues;

            if (Request.QueryString["cr"] != null)
                colIssues.Sort(new IssueComparer("Created", true));

            if (Request.QueryString["ur"] != null)
                colIssues.Sort(new IssueComparer("LastUpdate", true));

            ctlDisplayIssues.DataBind();
        }

        /// <summary>
        /// Adds the issue.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddIssue(Object s, EventArgs e)
        {
            Response.Redirect("~/Issues/IssueDetail.aspx?pid=" + ProjectId);
        }

    }
}
