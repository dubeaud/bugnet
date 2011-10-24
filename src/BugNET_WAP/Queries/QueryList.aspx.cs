using System;
using System.Collections.Generic;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Queries
{
	/// <summary>
	/// This page displays a list of existing queries
	/// </summary>
	public partial class QueryList : BugNET.UserInterfaceLayer.BasePage 
	{

		private static readonly ILog Log = LogManager.GetLogger(typeof(QueryList));
        private const string QUERY_LIST_STATE = "QueryListState";
		protected DisplayIssues ctlDisplayIssues;
		protected PickQuery dropQueries;

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.ctlDisplayIssues.RebindCommand += new System.EventHandler(IssuesRebind);
		}
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
                Results.Visible = false;

				// Set Project ID from Query String
				if (Request.QueryString["pid"] != null)
				{
					try
					{
						ProjectId = Int32.Parse(Request.QueryString["pid"]);
					}
					catch { }
				}

                QueryListState state = (QueryListState)Session[QUERY_LIST_STATE];

                BindQueries();

                if (state != null)
                {
                    if ((ProjectId > 0) && (ProjectId != state.ProjectId))
                    {
                        Session.Remove(QUERY_LIST_STATE);
                    }
                    else
                    {
                        if (state.QueryId != 0)
                            dropQueries.SelectedValue = state.QueryId;
                        ProjectId = state.ProjectId;
                        ctlDisplayIssues.CurrentPageIndex = state.IssueListPageIndex;
                        ctlDisplayIssues.SortField = state.SortField;
                        ctlDisplayIssues.SortAscending = state.SortAscending;
                        ctlDisplayIssues.PageSize = state.PageSize;
                    }

                    ExecuteQuery();
                }
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
            QueryListState state = (QueryListState)Session[QUERY_LIST_STATE];
            if (state == null) state = new QueryListState();
            state.QueryId = dropQueries.SelectedValue;
            state.ProjectId = ProjectId;
            state.IssueListPageIndex = ctlDisplayIssues.CurrentPageIndex;
            state.SortField = ctlDisplayIssues.SortField;
            state.SortAscending = ctlDisplayIssues.SortAscending;
            state.PageSize = ctlDisplayIssues.PageSize;
            Session[QUERY_LIST_STATE] = state;
        }

		/// <summary>
		/// Projects the selected index changed.
		/// </summary>
		/// <param name="s">The s.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		void ProjectSelectedIndexChanged(Object s, EventArgs e) 
		{
			BindQueries();
		}

		/// <summary>
		/// Rebinds the issues
		/// </summary>
		/// <param name="s">The s.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		void IssuesRebind(Object s, EventArgs e) 
		{
			ExecuteQuery();
		}

		/// <summary>
		/// Binds the queries.
		/// </summary>
		void BindQueries() 
		{         
			dropQueries.DataSource = QueryManager.GetByUsername(User.Identity.Name,ProjectId);
			dropQueries.DataBind();

			if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteQuery.ToString()))
				btnDeleteQuery.Visible = false;

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.EditQuery.ToString()))
                EditQueryButton.Visible = false;
		}

		/// <summary>
		/// BTNs the perform query click.
		/// </summary>
		/// <param name="s">The s.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void btnPerformQueryClick(object s, EventArgs e) 
		{
			ExecuteQuery();
		}

		/// <summary>
		/// Edits the query.
		/// </summary>
		protected void EditQuery(object s, EventArgs e)
		{
			if (dropQueries.SelectedValue == 0)
				return;

			Response.Redirect("~/Queries/QueryDetail.aspx?id=" + dropQueries.SelectedValue.ToString() + "&pid="+ ProjectId.ToString(),true);
		}
		/// <summary>
		/// Executes the query.
		/// </summary>
		void ExecuteQuery() 
		{
			if (dropQueries.SelectedValue == 0)
				return;


			try 
			{
				List<Issue> colIssues = IssueManager.PerformSavedQuery(ProjectId,dropQueries.SelectedValue);
				ctlDisplayIssues.DataSource = colIssues;
				ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?pid={1}&q={0}&channel=13",dropQueries.SelectedValue,ProjectId);

				// Moved by SMOSS
				// 8-Apr-2010
				// 
				// Only bind results if there is no error.                
				ctlDisplayIssues.DataBind();
				// The error message has been moved out of the "Results" panel and into the 
				// content area.
				// 
				Results.Visible = true;
			} 
			catch (Exception ex)
			{
				lblError.Text = GetLocalResourceObject("QueryError").ToString();
				if (Log.IsErrorEnabled)                    
					Log.Warn(string.Format("Error Running Saved Query. Project Id:{0} Query Id:{1}" , ProjectId.ToString(),dropQueries.SelectedValue.ToString()), ex);
			}

		}

		/// <summary>
		/// Adds the query.
		/// </summary>
		/// <param name="s">The s.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void AddQuery(object s, EventArgs e) 
		{
			Response.Redirect(string.Format("QueryDetail.aspx?pid={0}",ProjectId));
		}

		/// <summary>
		/// Deletes the query.
		/// </summary>
		/// <param name="s">The s.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void DeleteQuery(object s, EventArgs e) 
		{
			if (dropQueries.SelectedValue == 0)
				return;

			QueryManager.Delete(dropQueries.SelectedValue);
			BindQueries();
		}


	
	}
}
