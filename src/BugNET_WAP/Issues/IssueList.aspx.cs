using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues
{
	/// <summary>
	/// Summary description for Issue List.
	/// </summary>
    public partial class IssueList : BugNET.UserInterfaceLayer.BasePage 
	{
		#region Private Variables
            /// <summary>
            /// 
            /// </summary>
		    protected CheckBox IncludeComments;
            private const string ISSUELISTSTATE = "IssueListState";
		#endregion

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!Page.IsPostBack)
            {
                // Set Project ID from Query String
                if (Request.QueryString["pid"] != null)
                {
                    try
                    {
                        ProjectId = Int32.Parse(Request.QueryString["pid"]);
                    }
                    catch 
                    {
                       // BGN-1379
                        ErrorRedirector.TransferToNotFoundPage(Page);
                    }
                }

                if (!User.Identity.IsAuthenticated)
                {
                    dropView.Items.Remove(dropView.Items.FindByValue("Relevant"));
                    dropView.Items.Remove(dropView.Items.FindByValue("Assigned"));
                    dropView.Items.Remove(dropView.Items.FindByValue("Owned"));
                    dropView.Items.Remove(dropView.Items.FindByValue("Created"));
                    dropView.SelectedIndex = 1;                   
                }
                else
                {
                    ctlDisplayIssues.PageSize = WebProfile.Current.IssuesPageSize;                     
                }

                IssueListState state = (IssueListState)Session[ISSUELISTSTATE];

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
            IssueListState state = (IssueListState)Session[ISSUELISTSTATE];
            if (state == null) state = new IssueListState();
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
                if (Request.QueryString["c"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["c"];
            }
        }
        /// <summary>
        /// Returns the keywords from the query string
        /// </summary>
        public string Key
        {
            get
            {
                if (Request.QueryString["key"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["key"].Replace("+", " ");
            }
        }
        /// <summary>
        /// Returns the Milestone Id from the query string
        /// </summary>
        public string IssueMilestoneId
        {
            get
            {
                if (Request.QueryString["m"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["m"].ToString();
            }
        }

       
        /// <summary>
        /// Returns the priority Id from the query string
        /// </summary>
        public string IssuePriorityId
        {
            get
            {
                if (Request.QueryString["p"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["p"].ToString();
            }
        }
        /// <summary>
        /// Returns the Type Id from the query string
        /// </summary>
        public string IssueTypeId
        {
            get
            {
                if (Request.QueryString["t"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["t"].ToString();
            }
        }
        /// <summary>
        /// Returns the status Id from the query string
        /// </summary>
        public string IssueStatusId
        {
            get { 
                if (Request.QueryString["s"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["s"].ToString(); }
        }
        /// <summary>
        /// Returns the assigned to user Id from the query string
        /// </summary>
        public string AssignedUserName
        {
            get
            {
                if (Request.QueryString["u"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["u"].ToString();
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
                if (Request.QueryString["ru"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["ru"].ToString();
            }
        }
        /// <summary>
        /// Returns the hardware Id from the query string
        /// </summary>
        public string IssueResolutionId
        {
            get
            {
                if (Request.QueryString["r"] == null)
                {
                    return string.Empty;
                }
                return Request.QueryString["r"].ToString();
            }
        }

        /// <summary>
        /// Gets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return Convert.ToInt32(Request.QueryString["bid"]); }
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
            bool isError = false;
            List<Issue> colIssues = null;
     
            //only do this if the user came from the project summary page.
           //only do this if the user came from the project summary or default page.
           //if ((Request.UrlReferrer != null) &&
            //   (Request.UrlReferrer.ToString().Contains("ProjectSummary") || Request.UrlReferrer.ToString().Contains("Default") && Request.QueryString.Count > 1))
           //if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().Contains("ProjectSummary") && Request.QueryString.Count > 1)

           //if ((Request.UrlReferrer != null) &&
              //(!Request.UrlReferrer.ToString().Contains("IssueList") && Request.QueryString.Count > 1 && dropView.SelectedIndex == 0))
           if (Request.QueryString.Count > 1 && dropView.SelectedIndex == 0)
           {
               dropView.SelectedIndex = 0;
               QueryClause q;            
               bool isStatus = false;
               string BooleanOperator = "AND";
               List<QueryClause> queryClauses = new List<QueryClause>();
               if (!string.IsNullOrEmpty(IssueCategoryId))
               {
                   if (IssueCategoryId == "0")
                   {
                       q = new QueryClause(BooleanOperator, "IssueCategoryId", "IS", null, SqlDbType.Int, false);
                   }
                   else
                   {
                       q = new QueryClause(BooleanOperator, "IssueCategoryId", "=", IssueCategoryId.ToString(), SqlDbType.Int, false);
                   }             
                   queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(IssueTypeId))
               {
                   q = new QueryClause(BooleanOperator, "IssueTypeId", "=", IssueTypeId.ToString(), SqlDbType.Int, false);
                   queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(IssueMilestoneId))
               {
                   //if zero, do a null comparison.
                   if (IssueMilestoneId == "0")
                   {
                       q = new QueryClause(BooleanOperator, "IssueMilestoneId", "IS", null, SqlDbType.Int, false);
                   }
                   else
                   {
                       q = new QueryClause(BooleanOperator, "IssueMilestoneId", "=", IssueMilestoneId, SqlDbType.Int, false);
                   }                  
                   queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(IssueResolutionId))
               {
                   q = new QueryClause(BooleanOperator, "IssueResolutionId", "=", IssueResolutionId.ToString(), SqlDbType.Int, false);
                   queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(IssuePriorityId))
               {
                   q = new QueryClause(BooleanOperator, "IssuePriorityId", "=", IssuePriorityId.ToString(), SqlDbType.Int, false);
                   queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(IssueStatusId))
               {
                   if (IssueStatusId != "-1")
                   {
                       isStatus = true;
                       q = new QueryClause(BooleanOperator, "IssueStatusId", "=", IssueStatusId.ToString(), SqlDbType.Int, false);
                       queryClauses.Add(q);
                   }
                   else
                   {
                       isStatus = true;
                       List<Status> closedStatus = StatusManager.GetStatusByProjectId(ProjectId).FindAll(s => !s.IsClosedState);
                       foreach (Status status in closedStatus)                     
                           queryClauses.Add(new QueryClause("AND", "IssueStatusId", "<>", status.Id.ToString(), SqlDbType.Int, false));
                   }
                 
                   //q = new QueryClause(BooleanOperator, "IssueStatusId", "=", IssueStatusId.ToString(), SqlDbType.Int, false);
                   //queryClauses.Add(q);
               }
               if (!string.IsNullOrEmpty(AssignedUserName))
               {
                   if (AssignedUserName == "0")
                       q = new QueryClause(BooleanOperator, "IssueAssignedUserId", "IS", null, SqlDbType.NVarChar, false); 
                   else
                       q = new QueryClause(BooleanOperator, "AssignedUsername", "=", AssignedUserName, SqlDbType.NVarChar, false);
                  
                   queryClauses.Add(q);
               }

               //exclude all closed status's
               if (!isStatus)
               {
                   List<Status> status = StatusManager.GetStatusByProjectId(ProjectId).FindAll(delegate(Status s) { return s.IsClosedState == true; });
                   foreach (Status st in status)
                   {
                       q = new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false);
                       queryClauses.Add(q);
                   }
               }
              
               //q = new QueryClause(BooleanOperator, "new", "=", "another one", SqlDbType.NVarChar, true);
               //queryClauses.Add(q);
               try
               {
                   colIssues = IssueManager.PerformQuery(ProjectId, queryClauses);
                   
                   // TODO: WARNING Potential Cross Site Scripting attack
                   // also this code only runs if the previous code does not freak out
                   ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?{0}&channel=7", Request.QueryString.ToString());
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
                       colIssues = IssueManager.GetIssuesByRelevancy(ProjectId, User.Identity.Name);
                       ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=8", ProjectId);
                       break;
                   case "Assigned":
                       colIssues = IssueManager.GetIssuesByAssignedUserName(ProjectId, User.Identity.Name);
                       ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=9", ProjectId);
                       break;
                   case "Owned":
                       colIssues = IssueManager.GetIssuesByOwnerUserName(ProjectId, User.Identity.Name);
                       ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=10", ProjectId);
                       break;
                   case "Created":
                       colIssues = IssueManager.GetIssuesByCreatorUserName(ProjectId, User.Identity.Name);
                       ctlDisplayIssues.RssUrl = string.Format("~/Feed.aspx?pid={0}&channel=11", ProjectId);
                       break;
                   case "All":
                       colIssues = IssueManager.GetIssuesByProjectId(ProjectId);
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

           if (!isError)
           {

               ctlDisplayIssues.DataSource = colIssues;

               if (Request.QueryString["cr"] != null)
                   colIssues.Sort(new IssueComparer("Created", true));

               if (Request.QueryString["ur"] != null)
                   colIssues.Sort(new IssueComparer("LastUpdate", true));

               ctlDisplayIssues.DataBind();
           }
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
