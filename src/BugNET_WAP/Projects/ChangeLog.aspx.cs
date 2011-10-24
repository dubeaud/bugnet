using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.Common;

namespace BugNET.Projects
{

    /// <summary>
    /// Summary description for ChangeLog.
    /// </summary>
	public partial class ChangeLog : BugNET.UserInterfaceLayer.BasePage 
	{
		protected string VersionTitle;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!Page.IsPostBack)
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
                PreviousMilestones.ForeColor = Color.Black;
                PreviousMilestones.Enabled = false;
                Linkbutton5.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton5.Enabled = true;
                ViewMode = 1;
                Linkbutton7.ForeColor = Color.Black;
                Linkbutton7.Enabled = false;
                Linkbutton9.ForeColor = ColorTranslator.FromHtml("#00489E");
                Linkbutton9.Enabled = true;
                SortMilestonesAscending = false;


                BindChangeLog();
			}

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve +=
              new SiteMapResolveEventHandler(this.ExpandProjectPaths);		
		}

        /// <summary>
        /// Handles the Click event of the SwitchViewMode control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SwitchViewMode_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            if (button.CommandArgument == "1")
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
            LinkButton button = (LinkButton)sender;
            bool Ascending = Boolean.Parse(button.CommandArgument);
            if (Ascending)
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
            SortMilestonesAscending = Ascending;
            BindChangeLog();

        }

        /// <summary>
        /// Gets or sets the view mode.
        /// </summary>
        /// <value>The view mode.</value>
        int ViewMode
        {
            get
            {
                object o = ViewState["ViewMode"];
                if (o == null)
                {
                    return 1;
                }
                return (int)o;
            }

            set
            {
                ViewState["ViewMode"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort milestones ascending].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [sort milestones ascending]; otherwise, <c>false</c>.
        /// </value>
        bool SortMilestonesAscending
        {
            get
            {
                object o = ViewState["SortMilestonesAscending"];
                if (o == null)
                {
                    return true;
                }
                return (bool)o;
            }

            set
            {
                ViewState["SortMilestonesAscending"] = value;
            }
        }

        /// <summary>
        /// Binds the project summary.
        /// </summary>
        private void BindChangeLog()
        {
            string ascending = SortMilestonesAscending == true ? "" : " desc";
            List<Milestone> milestones = MilestoneManager.GetByProjectId(ProjectId).Sort<Milestone>("SortOrder" + ascending).ToList();
            if (ViewMode == 1)
                ChangeLogRepeater.DataSource = milestones.Take(5);
            else
                ChangeLogRepeater.DataSource = milestones;

            ChangeLogRepeater.DataBind();
        }

        /// <summary>
        /// Handles the ItemCreated event of the rptChangeLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptChangeLog_ItemCreated(object sender, RepeaterItemEventArgs e)
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
        /// Sorts the category click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortCategoryClick(object sender, EventArgs e)
        {
          
            SortField = "Category";
            BindChangeLog();
        }


        /// <summary>
        /// Sorts the issue id click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortIssueIdClick(object sender, EventArgs e)
        {

            SortField = "Id";
            BindChangeLog();
        }

        /// <summary>
        /// Sorts the status click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortStatusClick(object sender, EventArgs e)
        {
            SortField = "Status";
            BindChangeLog();
        }

        /// <summary>
        /// Sorts the assigned user click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortAssignedUserClick(object sender, EventArgs e)
        {
            SortField = "Assigned";
            BindChangeLog();
        }

        /// <summary>
        /// Sorts the priority click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortPriorityClick(object sender, EventArgs e)
        {
            SortField = "Priority";
            BindChangeLog();
        }

        /// <summary>
        /// Sorts the title click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortTitleClick(object sender, EventArgs e)
        {
            SortField = "Title";
            BindChangeLog();
        }

        /// <summary>
        /// Sorts the issue type click.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SortIssueTypeClick(object sender, EventArgs e)
        {
            SortField = "IssueType";
            BindChangeLog();
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
                    return String.Empty;
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
        protected void Page_Unload(object sender, System.EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -=
             new SiteMapResolveEventHandler(this.ExpandProjectPaths);
        }

		#region Web Form Designer generated code
        /// <summary>
        /// Overrides the default OnInit to provide a security check for pages
        /// </summary>
        /// <param name="e"></param>
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
	
		}
		#endregion

        /// <summary>
        /// Handles the ItemDataBound event of the ChangeLogRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void ChangeLogRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

               

               

                Milestone m = (Milestone)e.Item.DataItem;
                ((Label)e.Item.FindControl("MilestoneNotes")).Text = m.Notes;
                ((HyperLink)e.Item.FindControl("ReleaseNotes")).NavigateUrl = string.Format(Page.ResolveUrl("~/Projects/ReleaseNotes.aspx") + "?pid={0}&m={1}", ProjectId, m.Id);
                if (m.ReleaseDate.HasValue)
                {
                    DateTime date = (DateTime)m.ReleaseDate;
                    ((Label)e.Item.FindControl("lblReleaseDate")).Text = string.Format(GetLocalResourceObject("ReleasedOn").ToString(), date.ToShortDateString());
                }
                else
                {
                    ((Label)e.Item.FindControl("lblReleaseDate")).Text = GetLocalResourceObject("NoReleaseDate").ToString(); 
                }

                Repeater list = (Repeater)e.Item.FindControl("IssuesList");
                List<QueryClause> queryClauses = new List<QueryClause>();
                queryClauses.Add(new QueryClause("AND", "IssueMilestoneId", "=", m.Id.ToString(), SqlDbType.Int, false));
                //int closedStatusId = 0;

                List<Status> closedStatus = StatusManager.GetByProjectId(ProjectId).FindAll(s => !s.IsClosedState);
                foreach (Status status in closedStatus)
                {
                    //closedStatusId = status.Id;
                    queryClauses.Add(new QueryClause("AND", "IssueStatusId", "<>", status.Id.ToString(), SqlDbType.Int, false));
                }
                List<Issue> issueList = IssueManager.PerformQuery(queryClauses, ProjectId);
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
                            }
                            return r;

                        });
                    }

                    list.DataSource = issueList;
                    list.DataBind();
                }
                else
                    e.Item.Visible = false;

                ((HyperLink)e.Item.FindControl("IssuesCount")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}&s=-1", ProjectId, m.Id);
                ((HyperLink)e.Item.FindControl("IssuesCount")).Text = issueList.Count.ToString() + GetLocalResourceObject("Issues").ToString();
                ((HyperLink)e.Item.FindControl("MilestoneLink")).NavigateUrl = string.Format(Page.ResolveUrl("~/Issues/IssueList.aspx") + "?pid={0}&m={1}&s=-1", ProjectId, m.Id);
                ((HyperLink)e.Item.FindControl("MilestoneLink")).Text = m.Name;
            }
        }
	}
}
