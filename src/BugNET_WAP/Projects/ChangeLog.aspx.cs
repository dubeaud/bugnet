using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Microsoft.AspNet.FriendlyUrls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Projects
{

    /// <summary>
    /// Summary description for ChangeLog.
    /// </summary>
    public partial class ChangeLog : BasePage 
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                try
                {
                    IList<string> segments = Request.GetFriendlyUrlSegments();
                    ProjectId = Int32.Parse(segments[0]);
                }
                catch
                {
                    ProjectId = Request.QueryString.Get("pid", 0);
                }

                // If don't know project or issue then redirect to something missing page
                if(ProjectId == 0)
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

                ltProject.Text = p.Name;
                litProjectCode.Text = p.Code;

                PreviousMilestones.ForeColor = Color.Black;
                PreviousMilestones.Enabled = false;
                Linkbutton5.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton5.Enabled = true;

                Linkbutton7.ForeColor = Color.Black;
                Linkbutton7.Enabled = false;
                Linkbutton9.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton9.Enabled = true;

                ViewMode = 1;
                SortMilestonesAscending = false;
                SortHeader = "Id";
                SortAscending = false;
                SortField = "iv.[IssueId]";

                BindChangeLog();
            }

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            // SiteMap.SiteMapResolve += ExpandProjectPaths;		
        }

        /// <summary>
        /// Handles the Click event of the SwitchViewMode control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SwitchViewMode_Click(object sender, EventArgs e)
        {
            var button = sender as LinkButton;

            if (button != null && button.CommandArgument == "1")
            {
                PreviousMilestones.ForeColor = Color.Black;
                PreviousMilestones.Enabled = false;
                Linkbutton5.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton5.Enabled = true;
                ViewMode = 1;
            }
            else
            {
                PreviousMilestones.ForeColor = ColorTranslator.FromHtml("#00489E");
                PreviousMilestones.Enabled = true;
                Linkbutton5.Enabled = false;
                Linkbutton5.ForeColor = Color.Black;
                ViewMode = 2;
            }
          
            BindChangeLog();
        }

        /// <summary>
        /// Handles the Click event of the SortMilestone control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortMilestone_Click(object sender, EventArgs e)
        {
            var button = sender as LinkButton;
            var ascending = true;

            if(button != null)
            {
                ascending = Boolean.Parse(button.CommandArgument);
            }

            if (ascending)
            {
                Linkbutton9.ForeColor = Color.Black;
                Linkbutton9.Enabled = false;
                Linkbutton7.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton7.Enabled = true;
            }
            else
            {
                Linkbutton9.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton9.Enabled = true;
                Linkbutton7.Enabled = false;
                Linkbutton7.ForeColor = Color.Black;
            }

            SortMilestonesAscending = ascending;
            BindChangeLog();

        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get { return ViewState.Get("SortField", string.Empty); }
            set
            {
                if(value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }

                ViewState.Set("SortField", value);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get { return ViewState.Get("SortAscending", true); }
            set { ViewState.Set("SortAscending", value); }
        }


        /// <summary>
        /// Gets or sets the view mode.
        /// </summary>
        /// <value>The view mode.</value>
        int ViewMode
        {
            get { return ViewState.Get("ViewMode", 1); }
            set { ViewState.Set("ViewMode", value); }
        }

        string SortHeader
        {
            get { return ViewState.Get("SortHeader", string.Empty); }
            set { ViewState.Set("SortHeader", value); }
        }

        protected void SortIssueClick(object sender, EventArgs e)
        {
            var button = sender as LinkButton;

            if (button != null)
            {
                SortField = button.CommandArgument;
                SortHeader = button.CommandName;
            }

            BindChangeLog();
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort milestones ascending].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [sort milestones ascending]; otherwise, <c>false</c>.
        /// </value>
        bool SortMilestonesAscending
        {
            get { return ViewState.Get("SortMilestonesAscending", true); }
            set { ViewState.Set("SortMilestonesAscending", value); }
        }

        /// <summary>
        /// Binds the project summary.
        /// </summary>
        private void BindChangeLog()
        {
            var ascending = SortMilestonesAscending ? "" : " desc";
            var milestones = MilestoneManager.GetByProjectId(ProjectId).Sort("SortOrder" + ascending).ToList();

            ChangeLogRepeater.DataSource = ViewMode == 1 ? 
                milestones.Take(5) : 
                milestones;

            ChangeLogRepeater.DataBind();
        }

        /// <summary>
        /// Handles the ItemCreated event of the rptChangeLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptChangeLog_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    foreach (Control c in e.Item.Controls)
                    {
                        if (c.GetType() != typeof (HtmlTableCell) || c.ID != string.Format("td{0}", SortHeader)) continue;

                        var img = new System.Web.UI.WebControls.Image
                        {
                            ImageUrl = string.Format("~/images/{0}.png", (SortAscending ? "bullet_arrow_up" : "bullet_arrow_down")),
                            CssClass = "icon"
                        };

                        // setting the dynamically URL of the image
                        c.Controls.Add(img);
                    }
                    break;
            }
        }

        /// <summary>
        /// Expands the project paths.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.SiteMapResolveEventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        private SiteMapNode ExpandProjectPaths(Object sender, SiteMapResolveEventArgs e)
        {
            var currentNode = SiteMap.CurrentNode.Clone(true);
            var tempNode = currentNode;

            // The current node, and its parents, can be modified to include
            // dynamic query string information relevant to the currently
            // executing request.
            if (ProjectId != 0)
            {
                tempNode.Url = tempNode.Url + "?pid=" + ProjectId.ToString();
            }

            if ((null != (tempNode = tempNode.ParentNode)) &&
                (ProjectId != 0))
            {
                tempNode.Url = tempNode.Url + "?pid=" + ProjectId.ToString();
            }

            return currentNode;
        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, EventArgs e)
        {
            //remove the event handler
            //SiteMap.SiteMapResolve -= ExpandProjectPaths;
        }

        /// <summary>
        /// Handles the ItemDataBound event of the ChangeLogRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void ChangeLogRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var m = (Milestone)e.Item.DataItem;

            if (!string.IsNullOrWhiteSpace(m.Notes))
            {
                ((Label)e.Item.FindControl("MilestoneNotes")).Text = " - " + m.Notes;
            }

            ((HyperLink)e.Item.FindControl("ReleaseNotes")).NavigateUrl = string.Format(Page.ResolveUrl("~/Projects/ReleaseNotes.aspx") + "?pid={0}&m={1}", ProjectId, m.Id);
            if (m.ReleaseDate.HasValue)
            {
                var date = (DateTime)m.ReleaseDate;
                ((Label)e.Item.FindControl("lblReleaseDate")).Text = string.Format(GetLocalResourceObject("ReleasedOn").ToString(), date.ToShortDateString());
            }
            else
            {
                ((Label)e.Item.FindControl("lblReleaseDate")).Text = GetLocalResourceObject("NoReleaseDate").ToString(); 
            }

            var list = e.Item.FindControl("IssuesList") as Repeater;

            if(list == null) return;

            var queryClauses = new List<QueryClause>
            {
                new QueryClause("AND", "iv.[IssueMilestoneId]", "=", m.Id.ToString(), SqlDbType.Int),
                new QueryClause("AND", "iv.[IsClosed]", "=", "1", SqlDbType.Int),
                new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int)
            };

            var sortString = (SortAscending) ? "ASC" : "DESC";
            
            var sortList = new List<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>(SortField, sortString)
            };

            var issueList = IssueManager.PerformQuery(queryClauses, sortList, ProjectId);

            // private issue check
            issueList = IssueManager.StripPrivateIssuesForRequestor(issueList, Security.GetUserName()).ToList();

            if (issueList.Count > 0)
            {
                list.DataSource = issueList;
                list.DataBind();
            }
            else
                e.Item.Visible = false;

            ((HyperLink)e.Item.FindControl("IssuesCount")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}&s=-1", ProjectId, m.Id);
            // Set language-specific declination
            ((HyperLink)e.Item.FindControl("IssuesCount")).Text = GetIssuesCountText(issueList.Count);
            ((HyperLink)e.Item.FindControl("MilestoneLink")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}&s=-1", ProjectId, m.Id);
            ((HyperLink)e.Item.FindControl("MilestoneLink")).Text = m.Name;
        }

        private string GetIssuesCountText(int issuesCount)
        {
            if (System.Threading.Thread.CurrentThread.CurrentUICulture.Name == "ru-RU")
            {
                return GetIssuesCountText_ru_RU(issuesCount);
            }
            return issuesCount.ToString() + GetLocalResourceObject("Issues").ToString();
        }

        private string GetIssuesCountText_ru_RU(int issuesCount)
        {
            int n100 = issuesCount % 100;
            string resName;

            if (n100 >= 11 && n100 <= 19)
                resName = "RU_Issues3";
            else
            {
                int n10 = issuesCount % 10;
                if (n10 == 1)
                    resName = "RU_Issues1";
                else if (n10 == 2 || n10 == 3 || n10 == 4)
                    resName = "RU_Issues2";
                else
                    resName = "RU_Issues3";
            }
            return String.Format(GetLocalResourceObject(resName).ToString(), issuesCount);
        }
    }
}
