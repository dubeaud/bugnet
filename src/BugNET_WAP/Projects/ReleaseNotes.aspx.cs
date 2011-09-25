using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Projects
{
    public partial class ReleaseNotes : BasePage
    {
        private int MilestoneId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Literal1.Text = GetLocalResourceObject("Page.Title").ToString();
            ProjectId = Convert.ToInt32(Request.QueryString["pid"]);
            MilestoneId = Convert.ToInt32(Request.QueryString["m"]);
            litMilestone.Text = MilestoneManager.GetMilestoneById(MilestoneId).Name;
            litProject.Text = ProjectManager.GetProjectById(ProjectId).Name;

            rptReleaseNotes.DataSource = IssueTypeManager.GetIssueTypesByProjectId(ProjectId);
            rptReleaseNotes.DataBind();

            Output.Text = string.Format("<h1>{2} - {0} - {1}</h1>", litProject.Text, litMilestone.Text, GetLocalResourceObject("Page.Title").ToString());
            Output.Text += RenderControl(rptReleaseNotes);
        }

        /// <summary>
        /// Handles the ItemDataBound event of the rptReleaseNotes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptReleaseNotes_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal it = (Literal)e.Item.FindControl("IssueType");
                IssueType issueType = (IssueType)e.Item.DataItem;
                it.Text = issueType.Name;

                List<QueryClause> queryClauses = new List<QueryClause>();
                int MilestoneId = Convert.ToInt32(Request.QueryString["m"]);

                Repeater list = (Repeater)e.Item.FindControl("IssuesList");
                queryClauses.Add( new QueryClause("AND", "IssueTypeId", "=", issueType.Id.ToString(), SqlDbType.Int, false));
                queryClauses.Add(new QueryClause("AND", "IssueMilestoneId", "=", MilestoneId.ToString(), SqlDbType.Int, false));

                List<Status> openStatus = StatusManager.GetStatusByProjectId(ProjectId).FindAll(s => !s.IsClosedState);
                foreach (Status st in openStatus)
                {
                    queryClauses.Add(new QueryClause("AND", "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false));
                }

                List<Issue> issueList = IssueManager.PerformQuery(ProjectId, queryClauses);
                if (issueList.Count > 0)
                {
                    list.DataSource = issueList;
                    list.DataBind();
                }
                else
                {
                    e.Item.Visible = false;
                }
            }
        }

        /// <summary>
        /// Renders the control.
        /// </summary>
        /// <param name="ctrl">The CTRL.</param>
        /// <returns></returns>
        public string RenderControl(Control ctrl)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter tw = new StringWriter(sb);
            HtmlTextWriter hw = new HtmlTextWriter(tw);

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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal it = (Literal)e.Item.FindControl("Issue");
                Issue issue = (Issue)e.Item.DataItem;
                it.Text = string.Format("<a href=\"{3}Issues/IssueDetail.aspx?id={2}\">{0}</a> - {1}", issue.FullId, issue.Title,issue.Id,HostSettingManager.DefaultUrl);

            }
        }
    }
}