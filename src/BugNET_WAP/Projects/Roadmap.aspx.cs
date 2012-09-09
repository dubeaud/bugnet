using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Projects
{
    /// <summary>
    /// Project Road Map
    /// </summary>
    public partial class Roadmap : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ProjectId = Request.Get("pid", Globals.NEW_ID);

                // If don't know project or issue then redirect to something missing page
                if (ProjectId == 0)
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

                SortHeader = "Id";
                SortAscending = false;
                SortField = "iv.[IssueId]";

                ltProject.Text = p.Name;
                litProjectCode.Text = p.Code;

                BindRoadmap();             
            }

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve += ExpandProjectPaths;
        }

        /// <summary>
        /// Binds the roadmap.
        /// </summary>
        private void BindRoadmap()
        {
            RoadmapRepeater.DataSource = MilestoneManager.GetByProjectId(ProjectId,false);
            RoadmapRepeater.DataBind();
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
                if (value == SortField)
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

            BindRoadmap();
        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, System.EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -= ExpandProjectPaths;
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
            // dynamic querystring information relevant to the currently
            // executing request.
            if (ProjectId != 0)
            {
                tempNode.Url = string.Format("{0}?pid={1}", tempNode.Url, ProjectId);
            }

            if ((null != (tempNode = tempNode.ParentNode)) &&
                (ProjectId != 0))
            {
                tempNode.Url = string.Format("{0}?pid={1}", tempNode.Url, ProjectId);
            }

            return currentNode;
        }

        /// <summary>
        /// Handles the ItemCreated event of the rptRoadMap control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptRoadMap_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    foreach (Control c in e.Item.Controls)
                    {
                        if (c.GetType() != typeof (HtmlTableCell) || c.ID != string.Format("td{0}", SortHeader)) continue;
                        var img = new Image
                        {
                            ImageUrl = string.Format("~/images/{0}.png", (SortAscending ? "bullet_arrow_up" : "bullet_arrow_down")),
                            CssClass = "icon"
                        };
                        // setting the dynamically URL of the image
                        c.Controls.Add(img);
                    }
                    break;
                case ListItemType.Item:
                    ((HtmlTableRow)e.Item.FindControl("Row")).Attributes.Add("onmouseout", "this.style.background=''");
                    ((HtmlTableRow)e.Item.FindControl("Row")).Attributes.Add("onmouseover", "this.style.background='#F7F7EC'");
                    break;
                case ListItemType.AlternatingItem:
                    ((HtmlTableRow)e.Item.FindControl("AlternateRow")).Attributes.Add("onmouseover", "this.style.background='#F7F7EC'");
                    ((HtmlTableRow)e.Item.FindControl("AlternateRow")).Attributes.Add("onmouseout", "this.style.background='#fafafa'");
                    break;
            }
        }

        /// <summary>
        /// Creates descriptive text for milestone due date
        /// </summary>
        /// <param name="dueDate">Milestone due date</param>
        /// <param name="completed">Milestone completed flag</param>
        /// <returns>Descriptive text</returns>
        private string GetDueDateDescription(DateTime? dueDate, bool completed)
        {
            var response = GetLocalResourceObject("NoDueDate").ToString();

            if (dueDate != null)
            {
                var date = (DateTime)dueDate;
                if (date.Date.Equals(DateTime.Now.Date))
                {
                    response = string.Format("{0} <b>{1}</b>", Resources.SharedResources.Due, Resources.SharedResources.Today);
                }
                else if (date.Date.Equals(DateTime.Now.AddDays(1).Date))
                {
                    response = string.Format("{0} <b>{1}</b>", Resources.SharedResources.Due, Resources.SharedResources.Tomorrow);
                }
                else if (date.Date.Equals(DateTime.Now.AddDays(-1).Date))
                {
                    response = string.Format("{0} <b>{1}</b>", Resources.SharedResources.Due, Resources.SharedResources.Yesterday);
                }
                else
                {
                    string diffName;
                    var diffDays = (date.Date - DateTime.Now.Date).Days;

                    if (Math.Abs(diffDays) < 14)
                    {
                        diffName = string.Format("{0} {1}", Math.Abs(diffDays), Resources.SharedResources.Days);
                    }
                    else if (Math.Abs(diffDays) < 61)
                    {
                        diffName = string.Format("{0} {1}", Math.Abs(Math.Round((decimal)diffDays / 7)), Resources.SharedResources.Weeks);
                    }
                    else if (Math.Abs(diffDays) < 730)
                    {
                        diffName = string.Format("{0} {1}", Math.Abs(Math.Round((decimal)diffDays / 30)), Resources.SharedResources.Months);
                    }
                    else
                    {
                        diffName = string.Format("{0} {1}", Math.Abs(Math.Round((decimal)diffDays / 365)), Resources.SharedResources.Years);
                    }

                    if (diffDays < 0)
                    {
                        response = completed ? 
                            Resources.SharedResources.Finished : 
                            String.Format("<b>{0}</b> {1}", diffName, Resources.SharedResources.Late);
                    }
                    else
                    {
                        response = String.Format("{1} {0}", diffName, Resources.SharedResources.DueIn);
                    }
                }
                response += String.Format(" ({0})", date.Date.ToShortDateString());
            }
            return response;
        }

        /// <summary>
        /// Handles the ItemDataBound event of the RoadmapRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void RoadmapRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var m = e.Item.DataItem as Milestone;

            if (m == null) return;

            ((Label)e.Item.FindControl("MilestoneNotes")).Text = m.Notes;
            var dueDate = (Label)e.Item.FindControl("lblDueDate");

                
            if (m.DueDate.HasValue)
            {
                var date = (DateTime)m.DueDate;
                dueDate.Text = GetDueDateDescription(date, false);
            }
            else
            {
                dueDate.Text = GetLocalResourceObject("NoReleaseDate").ToString();
            }

            var list = e.Item.FindControl("IssuesList") as Repeater;

            if (list == null) return;

            var queryClauses = new List<QueryClause>
        	{
        	    new QueryClause("AND", "iv.[IssueMilestoneId]", "=", m.Id.ToString(), SqlDbType.Int),
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

            var nfi = new NumberFormatInfo { PercentDecimalDigits = 0 };

            var progressValues = ProjectManager.GetRoadMapProgress(ProjectId, m.Id);
            var issueCount = progressValues[1];
            var resolvedCount = progressValues[0];
            var percent = (issueCount.Equals(0)) ? 0 : resolvedCount.To<double>() / issueCount.To<double>();
            var pct = percent.ToString("P", nfi);

            var match = Regex.Match(pct, @"\d+").Value.ToOrDefault(0);

            ((Label)e.Item.FindControl("lblProgress")).Text = string.Format(GetLocalResourceObject("ProgressMessage").ToString(), progressValues[0], progressValues[1]);
            ((Label)e.Item.FindControl("PercentLabel")).Text = pct;
            ((HtmlControl)e.Item.FindControl("ProgressBar")).Attributes.CssStyle.Add("width", string.Format("{0}%", match));
            ((HyperLink)e.Item.FindControl("MilestoneLink")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}", ProjectId, m.Id);
            ((HyperLink)e.Item.FindControl("MilestoneLink")).Text = m.Name;
        }
    }
}
