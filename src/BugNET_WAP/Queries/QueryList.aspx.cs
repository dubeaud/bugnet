using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Queries
{
	/// <summary>
	/// This page displays a list of existing queries
	/// </summary>
	public partial class QueryList : BasePage 
	{

		private static readonly ILog Log = LogManager.GetLogger(typeof(QueryList));
        private const string QUERY_LIST_STATE = "QueryListState";

		/// <summary>
		/// Binds the queries.
		/// </summary>
		void BindQueries() 
		{         
			dropQueries.DataSource = QueryManager.GetByUsername(User.Identity.Name,ProjectId);
			dropQueries.DataBind();

			if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteQuery.ToString()))
			{
                pnlDeleteQuery.Visible = false;
			}

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.EditQuery.ToString()))
            {
                pnlEditQuery.Visible = false;
            }
		}

		/// <summary>
		/// Edits the query.
		/// </summary>
		void EditQuery()
		{
			if (dropQueries.SelectedValue == 0)
				return;

			Response.Redirect(string.Format("~/Queries/QueryDetail.aspx?id={0}&pid={1}", dropQueries.SelectedValue, ProjectId), true);
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
				var colIssues = IssueManager.PerformSavedQuery(ProjectId,dropQueries.SelectedValue);
				ctlDisplayIssues.DataSource = colIssues;
				ctlDisplayIssues.RssUrl = string.Format("~/Rss.aspx?pid={1}&q={0}&channel=13",dropQueries.SelectedValue,ProjectId);

				// Only bind results if there is no error.                
				ctlDisplayIssues.DataBind();

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
		void AddQuery() 
		{
			Response.Redirect(string.Format("QueryDetail.aspx?pid={0}",ProjectId));
		}

		/// <summary>
		/// Deletes the query.
		/// </summary>
		void DeleteQuery() 
		{
			if (dropQueries.SelectedValue == 0)
				return;

			QueryManager.Delete(dropQueries.SelectedValue);
			BindQueries();
		}

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
        protected void Page_Load(object sender, EventArgs e)
        {
            ProjectId = Request.Get("pid", Globals.NEW_ID);

            if (Page.IsPostBack) return;

            // If don't know project or issue then redirect to something missing page
            if (ProjectId == 0)
                ErrorRedirector.TransferToSomethingMissingPage(Page);

            ConfirmDeleteText.Value = GetLocalResourceObject("ConfirmDelete").ToString().JsEncode();

            btnDeleteQuery.OnClientClick = "return confirmDelete();";
            lbDeleteQuery.OnClientClick = "return confirmDelete();";

            ctlDisplayIssues.PageSize = UserManager.GetProfilePageSize();
            ctlDisplayIssues.CurrentPageIndex = 0;
            Results.Visible = false;

            var state = (QueryListState)Session[QUERY_LIST_STATE];

            BindQueries();

            if (state == null) return;

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

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void Page_PreRender(object sender, EventArgs e)
        {
            // Intention is to restore IssueList page state when if it is redirected back to.
            // Put all necessary data in IssueListState object and save it in the session.
            var state = (QueryListState)Session[QUERY_LIST_STATE] ?? new QueryListState();
            state.QueryId = dropQueries.SelectedValue;
            state.ProjectId = ProjectId;
            state.IssueListPageIndex = ctlDisplayIssues.CurrentPageIndex;
            state.SortField = ctlDisplayIssues.SortField;
            state.SortAscending = ctlDisplayIssues.SortAscending;
            state.PageSize = ctlDisplayIssues.PageSize;
            Session[QUERY_LIST_STATE] = state;
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

        protected void imgPerformQuery_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            ExecuteQuery();
        }

        protected void btnAddQuery_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            AddQuery();
        }

        protected void lbAddQuery_Click(object sender, EventArgs e)
        {
            AddQuery();
        }

        protected void btnDeleteQuery_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            DeleteQuery();
        }

        protected void lbDeleteQuery_Click(object sender, EventArgs e)
        {
            DeleteQuery();
        }

        protected void btnEditQuery_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            EditQuery();
        }

        protected void lbEditQuery_Click(object sender, EventArgs e)
        {
            EditQuery();
        }
	}
}
