using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using System.Data;
using System.Linq;

namespace BugNET
{
    /// <summary>
    /// 
    /// </summary>
    public partial class SearchResults : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // if (User.Identity.IsAuthenticated)
                // {
                //      ctlBugs.PageSize = WebProfile.Current.IssuesPageSize;
                //  }

                //IssueListState state = (IssueListState)Session[ISSUELISTSTATE];

                //if (state != null)
                //{
                //    if (Request.QueryString.Count == 1 && state.ViewIssues == string.Empty) state.ViewIssues = "Open";

                //    //if ((ProjectId > 0) && (ProjectId != state.ProjectId))
                //    //{
                //    //    Session.Remove(ISSUELISTSTATE);
                //    //}
                //    //else
                //    //{
                //    if (Request.QueryString.Count > 1) state.ViewIssues = string.Empty;
                //    ctlBugs.CurrentPageIndex = state.IssueListPageIndex;
                //    ctlBugs.SortField = state.SortField;
                //    ctlBugs.SortAscending = state.SortAscending;
                //    ctlBugs.PageSize = state.PageSize;

                //    //}
                //}
                //else
                //{
                //    // if (Request.QueryString.Count > 1) dropView.SelectedValue = string.Empty;
                //}

                if (Request.QueryString["cr"] != null)
                    _mainIssues.Sort(new IssueComparer("Created", true));

                if (Request.QueryString["ur"] != null)
                    _mainIssues.Sort(new IssueComparer("LastUpdate", true));

            }

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve += ExpandIssuePaths;


        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -= ExpandIssuePaths;
        }

        private SiteMapNode ExpandIssuePaths(Object sender, SiteMapResolveEventArgs e)
        {
            var currentNode = SiteMap.CurrentNode.Clone(true);
            var tempNode = currentNode;

            if ((null != (tempNode = tempNode.ParentNode)))
            {
                tempNode.Url = string.Empty;
            }

            return currentNode;
        }

        //  private const string ISSUELISTSTATE = "SearchIssueListState";

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void Page_PreRender(object sender, System.EventArgs e)
        {
            // Intention is to restore IssueList page state when if it is redirected back to.
            // Put all necessary data in IssueListState object and save it in the session.

            //IssueListState state = (IssueListState)Session[ISSUELISTSTATE];
            //if (state == null) state = new IssueListState();            
            //state.IssueListPageIndex = ctlBugs.CurrentPageIndex;
            //state.IssueListPageIndex = ctlBugs.CurrentPageIndex;
            //state.SortField = ctlBugs.SortField;
            //state.SortAscending = ctlBugs.SortAscending;
            //state.PageSize = ctlBugs.PageSize;
            //Session[ISSUELISTSTATE] = state;
        }

        List<Issue> _mainIssues = null;
        List<IssueComment> _mainComments = null;

        /// <summary>
        /// Handles the Click event of the Button1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Button1_Click(object sender, EventArgs e)
        {
            //don't search on empty string
            if (string.IsNullOrEmpty(txtSearch.Text))
                return;

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
        /// Binds the issues.
        /// </summary>
        private void BindIssues()
        {
            _mainIssues = new List<Issue>();
            _mainComments = new List<IssueComment>();

            // The problem is in Version 0.8, global searches accross all projects for the same integer 
            // codes (for things like status and priority) are meaningless. 
            // So you have to search only with wildcards and keywords across all projects.

            // ---------------------------------------------------------------
            // Prepare a list of projects which the user has access to.             
            //
            // ---------------------------------------------------------------

            var searchProjects = new List<Project>();

            // are we logged in ?
            searchProjects = String.IsNullOrEmpty(Context.User.Identity.Name) ? 
                ProjectManager.GetPublicProjects() : 
                ProjectManager.GetByMemberUserName(Context.User.Identity.Name);

            searchProjects.Sort(new ProjectComparer("Name", false));

            // ---------------------------------------------------------------
            //
            // Perform the actual search using a method which populates mainIssues
            // and mainComment.
            //
            // ---------------------------------------------------------------

            PerformIssueSearch(searchProjects);

            // ---------------------------------------------------------------
            // 
            // Bind the UI controls
            //
            // ---------------------------------------------------------------
            SearchProjectRepeater.DataSource = searchProjects;

            SearchProjectRepeater.DataBind();

            lblSearchSummary.Text = _mainComments.Count > 0 ? 
                string.Format("{0} Issues found.<br />{1} Matching Comment(s) found.", _mainIssues.Count, _mainComments.Count) : 
                string.Format("{0} Issues found.", _mainIssues.Count);

        }

        /// <summary>
        /// Performs the issue search and populates mainIssues and mainComment.
        /// </summary>
        /// <param name="searchProjects">A List of projects to search through.</param>
        private void PerformIssueSearch(IEnumerable<Project> searchProjects)
        {

            var foundComments = new List<IssueComment>();
            var issueComments = new List<IssueComment>();
            var lstMainHistory = new List<IssueHistory>();

            // Our search strings on normal and "like" comparators
            // Note: these are deliberately not trimmed!
            // to the users, "test" might be different from "test "
            var strSearch = txtSearch.Text;
            var strLike = "%" + strSearch + "%";
            var strHtmlSearch = Server.HtmlEncode(strSearch);
            var strHtmlLike = "%" + strHtmlSearch + "%";

            // if the two strings are equal srchHtmlcode is false
            // If they are not equal, then I need to search for the HTML encoded 
            // variants later on.
            var srchHtmlcode = strHtmlSearch != strSearch;


            var srchComments = chkComments.Checked;
            var srchOpenIssues = chkExcludeClosedIssues.Checked;
            var srchUserName = false;//= chkUsername.Checked ; // not implemented

            var srchHistory = false; //  chkHistory.Checked;

            // Sort the projects using LINQ
            foreach (var p in searchProjects)
            {
                // now search each project with wildcard parameters 
                // (except for the search string)            

                // ---------------------------------------------------------------
                // Normal Search
                //
                // Searches Description, Issue Title using a LIKE query
                // If you are searching username it adds the LastUpdateUsername,
                // AssignedUsername, CreatorUserName, OwnerUserName to the list.
                //
                // ---------------------------------------------------------------

                var queryClauses = new List<QueryClause>();

                // NOTE WE ARE OPENING A PARENTHISES using the 
                // "William Highfield" trick ;)
                //
                // SQL Statement constructed by the QueryBuilder will nned to be something like
                // SELECT something FROM somewhere WHERE 1=1 AND ( IssueDescription LIKE '%test%' OR IssueTitle LIKE '%test%' )
                // 
                // The parenthesis ensure this, however you need to close the parenthesis off properly.

                var q = new QueryClause("AND (", "IssueDescription", "LIKE", strLike, SqlDbType.NVarChar, false);
                queryClauses.Add(q);
                q = new QueryClause("OR", "IssueTitle", "LIKE", strLike, SqlDbType.NVarChar, false);
                queryClauses.Add(q);

                if (srchHtmlcode)
                {
                    q = new QueryClause("OR", "IssueDescription", "LIKE", strHtmlLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);
                    q = new QueryClause("OR", "IssueTitle", "LIKE", strHtmlLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);
                }

                // USERNAME 
                if (srchUserName)
                {
                    /*
                     * 
                    q = new QueryClause("OR", "LastUpdateUsername", "LIKE", strLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);

                    q = new QueryClause("OR", "AssignedUsername", "LIKE", strLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);

                    q = new QueryClause("OR", "CreatorUserName", "LIKE", strLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);

                    q = new QueryClause("OR", "OwnerUserName", "LIKE", strLike, SqlDbType.NVarChar, false);
                    queryClauses.Add(q);
                     * 
                     */
                }

                // NOW TO CLOSE PARENTHISES
                //
                // Using the "William Highfield" trick ;)
                //

                q = new QueryClause(")", "", "", "", SqlDbType.NVarChar, false);
                queryClauses.Add(q);


                // Use the new Generic way to search with those QueryClauses
                var issues = IssueManager.PerformQuery(queryClauses, p.Id);

                // Now we can quicjkly filter out open issues
                if (srchOpenIssues)
                {
                    // get list of open issues for the project using LINQ                 
                    var tmpIssues = from iss in issues
                                    join st in StatusManager.GetByProjectId(p.Id)
                                    on iss.StatusId equals st.Id
                                    where st.IsClosedState == false
                                    select iss;

                    _mainIssues.AddRange(tmpIssues);
                }
                else
                {
                    _mainIssues.AddRange(issues);
                }

                //if (srchComments /*|| srchHistory*/ )
                //{
                //    // Get the Issues by Project now so 
                //    // we dont have repeated fetches if the user
                //    // selects multiple options.

                //    // we need to search the projects again becuase bc only contains our search results
                //    Issues = Issue.GetByProjectId(p.Id);
                //}

                // ---------------------------------------------------------------
                // Search History
                //
                // ---------------------------------------------------------------
                // List<IssueHistory> lstprjHistory = null;
                if (srchHistory)
                {
                    /*                      
                    lstprjHistory = new List<IssueHistory>();
                    queryClauses.Clear();
                    // bug need highfield method
                    queryClauses.Add(new QueryClause("AND", "OldValue", "LIKE", strLike , SqlDbType.VarChar, false));
                    queryClauses.Add(new QueryClause("OR", "NewValue", "LIKE", strLike, SqlDbType.VarChar, false));
                    queryClauses.Add(new QueryClause("AND", "c.ProjectID", "=", p.Id.ToString(), SqlDbType.Int, false));
                    lstprjHistory = IssueHistory.PerformQuery(queryClauses);

                    // Now we can quicjkly filter out open issues
                    if (srchOpenIssues)
                    {

                        // get list of open issues with matching history items for the project using LINQ                 
                        var tmpIssues = from hist in lstprjHistory
                                        join iss1 in Issue.GetByProjectId(p.Id)
                                        on hist.Id equals iss1.Id
                                        join st in Status.GetByProjectId(p.Id)
                                        on iss1.StatusId equals st.Id
                                        where st.IsClosedState = false
                                        select iss1;

                        mainIssues.AddRange(tmpIssues);

                    }
                    else
                    {
                        mainIssues.AddRange(Issues);
                    }

                    throw new NotImplementedException();
                    */
                }

                // ---------------------------------------------------------------
                // Search Comments
                //
                // ---------------------------------------------------------------

                if (srchComments)
                {
                    issueComments.Clear();
                    foundComments.Clear();

                    // Get ALL issues
                    issues = IssueManager.GetByProjectId(p.Id);

                    // Now filter out the Closed issues if we need to
                    if (srchOpenIssues)
                    {
                        // get list of open issues with matching history items for the project using LINQ                 
                        var tmpIssues = from Iss in issues
                                        join st in StatusManager.GetByProjectId(p.Id)
                                        on Iss.StatusId equals st.Id
                                        where st.IsClosedState = false
                                        select Iss;

                        List<Issue> tmpIssueList = new List<Issue>();
                        tmpIssueList.AddRange(tmpIssues);

                        issues.Clear();
                        issues.AddRange(tmpIssueList);
                        // Issues now only has open issues
                    }

                    foreach (Issue iss in issues)
                    {
                        // New Way
                        // Using the Generic Interface
                        List<QueryClause> qryComment = new List<QueryClause>();

                        // NOTE WE ARE OPENING A PARENTHISES using the 
                        // "William Highfield" trick ;)
                        // see earlier in this code

                        q = new QueryClause("AND (", "Comment", "LIKE", strLike, SqlDbType.VarChar, false);
                        qryComment.Add(q);

                        if (srchHtmlcode)
                        {
                            q = new QueryClause("OR", "Comment", "LIKE", strHtmlLike, SqlDbType.VarChar, false);
                            qryComment.Add(q);
                        }

                        // NOW TO CLOSE PARENTHISES
                        //
                        // Using the "William Highfield" trick ;)
                        //
                        q = new QueryClause(")", "", "", "", SqlDbType.NVarChar, false);
                        qryComment.Add(q);

                        //if (srchUserName)
                        //{
                        //    q = new QueryClause("OR", "CreatorUsername", "LIKE", "%" + strSearch + "%", SqlDbType.VarChar, false);
                        //    qryComment.Add(q);
                        //}

                        issueComments = IssueCommentManager.PerformQuery(iss.Id, qryComment);

                        // Did we find anything?
                        if (issueComments.Count > 0)
                        {
                            _mainComments.AddRange(issueComments);
                            _mainIssues.Add(iss);
                            // make sure we record the parent issue of the comment(s)
                        }
                    }
                }

                //if (srchHistory && (lstprjHistory != null))
                //{
                //   // lstMainHistory.AddRange(lstprjHistory);
                //}
            } // foreach project

            // ---------------------------------------------------------------
            // Clean up duplicates and sort
            // 
            // mainIssues and mainComments
            // Sorry for the horrible variable names
            //
            // --------------------------------------------------------------- 


            var tmpIss = (from iss1 in _mainIssues
                          orderby iss1.ProjectId, iss1.Id descending
                          select iss1).Distinct(new DistinctIssueComparer());


            List<Issue> tmpIssues1 = new List<Issue>();
            tmpIssues1.AddRange(tmpIss);
            _mainIssues.Clear();
            _mainIssues.AddRange(tmpIssues1);

            // mainIssues list should be pure now

            var tmpComm = (from comm in _mainComments
                           orderby comm.IssueId, comm.Id
                           select comm)
                           .Distinct();

            List<IssueComment> tmpComm1 = new List<IssueComment>();
            tmpComm1.AddRange(tmpComm);
            _mainComments.Clear();
            _mainComments.AddRange(tmpComm1);


        }

        /// <summary>
        /// A LINQ helper method that Returns a list of distinct projects from a list of issues.
        /// </summary>
        /// <param name="issues">The issues.</param>
        /// <returns></returns>
        private List<Project> GetDistinctProjects(IEnumerable<Issue> issues)
        {
            var prjs = (from p in issues
                        join proj in ProjectManager.GetAllProjects()
                        on p.ProjectId equals proj.Id
                        select proj).Distinct();
            var projList = new List<Project>(prjs);
            return projList;
        }

        protected void chkHistory_CheckedChanged(object sender, EventArgs e)
        {
        }

        protected void chkCommentUsername_CheckedChanged(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Binds the project summary.
        /// </summary>
        private void BindSearchProject()
        {

            /*  List<Milestone> milestones = Milestone.GetByProjectId(ProjectId).Sort<Milestone>("SortOrder" + ascending).ToList();
              if (ViewMode == 1)
                  ChangeLogRepeater.DataSource = milestones.Take(5);
              else
                  ChangeLogRepeater.DataSource = milestones;

              ChangeLogRepeater.DataBind(); */
        }

        Project curProj = null;

        /// <summary>
        /// Handles the ItemDataBound event of the SearchProjectRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void SearchProjectRepeater_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {


            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                Project p = (Project)e.Item.DataItem;

                ((HyperLink)e.Item.FindControl("ProjectLink")).Text = p.Name + " (" + p.Code + ")";

                // Chop description at 50 chars
                ((Label)e.Item.FindControl("ProjectDescription")).Text = (p.Description.Length > 100 ? p.Description.Substring(0, 100) + "..." : p.Description);


                // Only get this projects issues using LINQ
                List<Issue> FilteredIssues = new List<Issue>(from iss in _mainIssues
                                                             where p.Id == iss.ProjectId
                                                             select iss);

                // Are there any results
                if (FilteredIssues.Count > 0)
                {

                    ((HyperLink)e.Item.FindControl("IssuesCount")).Text = FilteredIssues.Count.ToString() + (FilteredIssues.Count == 1 ? " Issues found." : " Issues found.");
                    Repeater rptr = ((Repeater)e.Item.FindControl("IssuesList"));

                    rptr.DataSource = FilteredIssues;
                    rptr.DataBind();
                }
                else
                {
                    e.Item.Visible = false;
                }

            }
        }

        /// <summary>
        /// Handles the ItemDataBound event of the IssuesCommentListRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void IssuesCommentListRepeater_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                Label lblcomm = ((Label)e.Item.FindControl("lblComment"));
                IssueComment ic = (IssueComment)e.Item.DataItem;

                // Prevent XSS
                lblcomm.Text = Server.HtmlEncode(IssueCommentManager.GetShortTextComment(ic.Comment));
            }
        }


        /// <summary>
        /// Handles the ItemDataBound event of the IssuesListRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void IssuesListRepeater_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Issue i = (Issue)e.Item.DataItem;
                // Only get this projects issues using LINQ
                List<IssueComment> FilteredComm = new List<IssueComment>(from comm in _mainComments
                                                                         where i.Id == comm.IssueId
                                                                         select comm);

                Panel pnl1 = (Panel)(e.Item.FindControl("pnlIssueComments"));

                // Are there any results
                if (FilteredComm.Count > 0)
                {
                    //((HyperLink)e.Item.FindControl("IssuesCount")).Text = FilteredIssues.Count.ToString() + (FilteredIssues.Count == 1 ? " Issues found." : " Issues found.");
                    Repeater rptr = ((Repeater)e.Item.FindControl("IssuesCommentList"));

                    Label lbl1 = (Label)pnl1.FindControl("lblCommentCount");
                    lbl1.Text = string.Format("<em>{0} matching comment(s) found for <a href='../Issues/IssueDetail.aspx?id={2}'>{1}</a>.</em>", FilteredComm.Count.ToString(), i.FullId, i.Id.ToString());

                    rptr.DataSource = FilteredComm;
                    rptr.DataBind();

                    pnl1.Visible = true;
                }
                else
                {
                    Repeater rptr = ((Repeater)e.Item.FindControl("IssuesCommentList"));
                    rptr.Visible = false;
                    pnl1.Visible = false;
                }
            }

        }
    }
}
