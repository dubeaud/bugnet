using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Projects
{
    public partial class ReleaseNotes : BasePage
    {
        int MilestoneId
        {
            get { return ViewState.Get("MilestoneId", 0); }
            set { ViewState.Set("MilestoneId", value); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Literal1.Text = GetLocalResourceObject("Page.Title").ToString();

            if (!IsPostBack)
            {
                ProjectId = Request.Get("pid", Globals.NEW_ID);
                MilestoneId = Request.Get("m", Globals.NEW_ID);

                // If don't know project or issue then redirect to something missing page
                if (ProjectId == 0 || MilestoneId == 0)
                {
                    ErrorRedirector.TransferToSomethingMissingPage(Page);
                    return;
                }

                var p = ProjectManager.GetById(ProjectId);

                if (p == null || p.Disabled)
                {
                    ErrorRedirector.TransferToSomethingMissingPage(Page);
                    return;
                }

                litMilestone.Text = MilestoneManager.GetById(MilestoneId).Name;
                litProject.Text = ProjectManager.GetById(ProjectId).Name;
            }

            rptReleaseNotes.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            rptReleaseNotes.DataBind();

            Output.Text = string.Format("<h1>{2} - {0} - {1}</h1>", litProject.Text, litMilestone.Text, GetLocalResourceObject("Page.Title"));
            Output.Text += RenderControl(rptReleaseNotes);
        }

        /// <summary>
        /// Handles the ItemDataBound event of the rptReleaseNotes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptReleaseNotes_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var it = (Literal)e.Item.FindControl("IssueType");
            var issuesList = (Repeater)e.Item.FindControl("IssuesList");
            var issueType = (IssueType)e.Item.DataItem;
            it.Text = issueType.Name;

            var queryClauses = new List<QueryClause>
        	{
        	    new QueryClause("AND", "iv.[IssueTypeId]", "=", issueType.Id.ToString(), SqlDbType.Int),
                new QueryClause("AND", "iv.[IssueMilestoneId]", "=", MilestoneId.ToString(), SqlDbType.Int),
				new QueryClause("AND", "iv.[IsClosed]", "=", "1", SqlDbType.Int)
        	};

            var sortList = new List<KeyValuePair<string, string>>
        	{
				new KeyValuePair<string, string>("iv.[IssueId]", "DESC")
        	};

            var issueList = IssueManager.PerformQuery(queryClauses, sortList, ProjectId);

            if (issueList.Count > 0)
            {
                issuesList.DataSource = issueList;
                issuesList.DataBind();
            }
            else
            {
                e.Item.Visible = false;
            }
        }

        /// <summary>
        /// Renders the control.
        /// </summary>
        /// <param name="ctrl">The CTRL.</param>
        /// <returns></returns>
        private static string RenderControl(Control ctrl)
        {
            var sb = new StringBuilder();
            var tw = new StringWriter(sb);
            var hw = new HtmlTextWriter(tw);

            ctrl.RenderControl(hw);
            return sb.ToString();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the IssuesList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void IssueList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var it = (Literal)e.Item.FindControl("Issue");
            var issue = (Issue)e.Item.DataItem;

            it.Text = string.Format("<a href=\"{3}Issues/IssueDetail.aspx?id={2}\">{0}</a> - {1}", issue.FullId, issue.Title, issue.Id, HostSettingManager.DefaultUrl);
        }
    }
}