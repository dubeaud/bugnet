using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
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
        /// The current version title.
        /// </summary>
        protected string VersionTitle;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
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
                    catch { }
                }

                Project p = ProjectManager.GetProjectById(ProjectId);
                ltProject.Text = p.Name;
                litProjectCode.Text = p.Code;

                BindRoadmap();             
            }

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve +=
              new SiteMapResolveEventHandler(this.ExpandProjectPaths);
        }

        /// <summary>
        /// Projects the selected index changed.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ProjectSelectedIndexChanged(Object s, EventArgs e)
        {
            BindRoadmap();
        }

        /// <summary>
        /// Binds the roadmap.
        /// </summary>
        private void BindRoadmap()
        {
            RoadmapRepeater.DataSource = MilestoneManager.GetMilestoneByProjectId(ProjectId,false);
            RoadmapRepeater.DataBind();
        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, System.EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -=
             new SiteMapResolveEventHandler(this.ExpandProjectPaths);
        }

        /// <summary>
        /// Expands the project paths.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.SiteMapResolveEventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        private SiteMapNode ExpandProjectPaths(Object sender, SiteMapResolveEventArgs e)
        {
            SiteMapNode currentNode = SiteMap.CurrentNode.Clone(true);
            SiteMapNode tempNode = currentNode;

            // The current node, and its parents, can be modified to include
            // dynamic querystring information relevant to the currently
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
        /// Handles the ItemCreated event of the rptRoadMap control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptRoadMap_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                foreach (Control c in e.Item.Controls)
                {
                    if (c.GetType() == typeof(HtmlTableCell) && c.ID == "td" + SortField)
                    {
                        
                        System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                        // setting the dynamically URL of the image
                        img.ImageUrl = "~/images/" + (SortAscending ? "bullet_arrow_up" : "bullet_arrow_down") + ".png";
                        img.CssClass = "icon";
                        c.Controls.Add(img);
                    }
                }
            }
            else if (e.Item.ItemType == ListItemType.Item)
            {
                ((HtmlTableRow)e.Item.FindControl("Row")).Attributes.Add("onmouseout", "this.style.background=''");
                ((HtmlTableRow)e.Item.FindControl("Row")).Attributes.Add("onmouseover", "this.style.background='#F7F7EC'");
            }
            else if (e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ((HtmlTableRow)e.Item.FindControl("AlternateRow")).Attributes.Add("onmouseover", "this.style.background='#F7F7EC'");
                ((HtmlTableRow)e.Item.FindControl("AlternateRow")).Attributes.Add("onmouseout", "this.style.background='#fafafa'");
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
            string response = GetLocalResourceObject("NoDueDate").ToString();

            if (dueDate != null)
            {
                DateTime date = (DateTime)dueDate;
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
                    int diffDays = (date.Date - DateTime.Now.Date).Days;

                    if (Math.Abs(diffDays) < 14)
                    {
                        diffName = Math.Abs(diffDays) + " " + Resources.SharedResources.Days;
                    }
                    else if (Math.Abs(diffDays) < 61)
                    {
                        diffName = Math.Abs(Math.Round((decimal)diffDays / 7)).ToString() + " " + Resources.SharedResources.Weeks;
                    }
                    else if (Math.Abs(diffDays) < 730)
                    {
                        diffName = Math.Abs(Math.Round((decimal)diffDays / 30)).ToString() + " " + Resources.SharedResources.Months;
                    }
                    else
                    {
                        diffName = Math.Abs(Math.Round((decimal)diffDays / 365)).ToString() + " " + Resources.SharedResources.Years;
                    }

                    if (diffDays < 0)
                    {
                        if (completed)
                        {
                            response = Resources.SharedResources.Finished;
                        }
                        else
                        {
                            response = String.Format("<b>{0}</b> {1}", diffName, Resources.SharedResources.Late);
                        }
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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Milestone m = (Milestone)e.Item.DataItem;
                ((Label)e.Item.FindControl("MilestoneNotes")).Text = m.Notes;
                Label DueDate = (Label)e.Item.FindControl("lblDueDate");

                
                    if (m.DueDate.HasValue)
                    {
                        DateTime date = (DateTime)m.DueDate;
                        DueDate.Text = GetDueDateDescription(date, false);
                    }
                    else
                    {
                        DueDate.Text = GetLocalResourceObject("NoReleaseDate").ToString();
                    }

                    Repeater list = (Repeater)e.Item.FindControl("IssuesList");
                    List<QueryClause> queryClauses = new List<QueryClause>();
                    queryClauses.Add(new QueryClause("AND", "IssueMilestoneId", "=", m.Id.ToString(), SqlDbType.Int, false));
                    List<Issue> issueList = IssueManager.PerformQuery(ProjectId, queryClauses);
                    if (issueList.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(SortField))
                        {
                            issueList.Sort(delegate(Issue l1, Issue l2)
                            {

                                int r = l1.MilestoneId.CompareTo(l2.MilestoneId);
                                switch (SortField)
                                {
                                    case "Category":
                                        if (r == 0 && l1.CategoryName != null)
                                            r = l1.CategoryName.CompareTo(l2.CategoryName) * (SortAscending ? -1 : 1);
                                        break;
                                    case "IssueType":
                                        if (r == 0 && l1.IssueTypeName != null)
                                            r = l1.IssueTypeName.CompareTo(l2.IssueTypeName) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Status":
                                        if (r == 0 && l1.StatusName != null)
                                            r = l1.StatusName.CompareTo(l2.StatusName) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Priority":
                                        if (r == 0 && l1.PriorityName != null)
                                            r = l1.PriorityName.CompareTo(l2.PriorityName) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Assigned":
                                        if (r == 0 && l1.AssignedUserName != null)
                                            r = l1.AssignedUserName.CompareTo(l2.AssignedUserName) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Progress":
                                        if (r == 0)
                                            r = l1.Progress.CompareTo(l2.Progress) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Title":
                                        if (r == 0 && l1.Title != null)
                                            r = l1.Title.CompareTo(l2.Title) * (SortAscending ? -1 : 1);
                                        break;
                                    case "Id":
                                        if (r == 0)
                                            r = l1.Id.CompareTo(l2.Id) * (SortAscending ? -1 : 1);
                                        break;
                                    case "DueDate":
                                        if (r == 0)
                                            r = l1.DueDate.CompareTo(l2.DueDate) * (SortAscending ? -1 : 1);
                                        break;

                                }
                                return r;

                            });
                        }
                        int[] progressValues = ProjectManager.GetRoadMapProgress(ProjectId, m.Id);
                        double percent = progressValues[0] * 100 / progressValues[1];
                      
                        ((Label)e.Item.FindControl("lblProgress")).Text = string.Format(GetLocalResourceObject("ProgressMessage").ToString(), progressValues[0], progressValues[1]);
                        ((Label)e.Item.FindControl("PercentLabel")).Text = percent.ToString() + "%";
                        ((HtmlControl)e.Item.FindControl("ProgressBar")).Attributes.CssStyle.Add("width", percent.ToString() + "%");

                        list.DataSource = issueList;
                        list.DataBind();

                    }
                    else
                        e.Item.Visible = false;

                    ((HyperLink)e.Item.FindControl("MilestoneLink")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}", ProjectId, m.Id);
                    ((HyperLink)e.Item.FindControl("MilestoneLink")).Text = m.Name;
               
            }
        }

        /// <summary>
        /// Sorts the category click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortCategoryClick(object sender, EventArgs e)
        {
            SortField = "Category";
            BindRoadmap();
        }

        protected void SortDueDateClick(object sender, EventArgs e)
        {
            SortField = "DueDate";
            BindRoadmap();
        }


        /// <summary>
        /// Sorts the issue id click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortIssueIdClick(object sender, EventArgs e)
        {

            SortField = "Id";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the status click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortStatusClick(object sender, EventArgs e)
        {
            SortField = "Status";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the assigned user click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortAssignedUserClick(object sender, EventArgs e)
        {
            SortField = "Assigned";
            BindRoadmap();
        }

        protected void SortPriorityClick(object sender, EventArgs e)
        {
            SortField = "Priority";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the progress click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortProgressClick(object sender, EventArgs e)
        {
            SortField = "Progress";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the title click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortTitleClick(object sender, EventArgs e)
        {
            SortField = "Title";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the issue type click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortIssueTypeClick(object sender, EventArgs e)
        {
            SortField = "IssueType";
            BindRoadmap();
        }

        /// <summary>
        /// Sorts the estimation click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortEstimationClick(object sender, EventArgs e)
        {
            SortField = "Estimation";
            BindRoadmap();
        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get
            {
                object o = ViewState["SortField"];
                if (o == null)
                {
                    return "Status";
                }
                return (string)o;
            }

            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }
                ViewState["SortField"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get
            {
                object o = ViewState["SortAscending"];
                if (o == null)
                {
                    return true;
                }
                return (bool)o;
            }

            set
            {
                ViewState["SortAscending"] = value;
            }
        }
    }
}
