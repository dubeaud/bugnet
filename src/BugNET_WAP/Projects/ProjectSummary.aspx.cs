using System;
using System.Web;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Projects
{
	/// <summary>
	/// Summary description for BrowseProject.
	/// </summary>
	public partial class ProjectSummary : BasePage
	{
	    /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, EventArgs e)
		{
			// Put user code to initialize the page here
	        if (Page.IsPostBack) return;

            ProjectId = Request.Get("pid", -1);

            // BGN-1379
            if (ProjectId.Equals(-1))
                ErrorRedirector.TransferToNotFoundPage(Page);
 
	        BindProjectSummary();

            SiteMap.SiteMapResolve += ExpandPaths;
		}

        protected void Page_Unload(object sender, EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -= ExpandPaths;
        }

        private SiteMapNode ExpandPaths(Object sender, SiteMapResolveEventArgs e)
        {
            if (SiteMap.CurrentNode == null) return null;

            var currentNode = SiteMap.CurrentNode.Clone(true);
            var tempNode = currentNode;

            if ((null != (tempNode = tempNode.ParentNode)))
            {
                tempNode.Url = string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId);
            }

            return currentNode;
        }

	    /// <summary>
        /// Binds the project summary.
        /// </summary>
        void BindProjectSummary()
        {
            lnkRSSIssuesByCategory.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=2",ProjectId);
            lnkRSSIssuesByAssignee.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=6",ProjectId);
            lnkRSSIssuesByStatus.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=3",ProjectId);
            lnkRSSIssuesByMilestone.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=1",ProjectId);
            lnkRSSIssuesByPriority.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=4",ProjectId);
            lnkRSSIssuesByType.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=5",ProjectId);

            //Milestone
            var lsVersion = IssueManager.GetMilestoneCountByProjectId(ProjectId);

            //Status
            var lsStatus = IssueManager.GetStatusCountByProjectId(ProjectId);

            //Priority
            var lsPriority = IssueManager.GetPriorityCountByProjectId(ProjectId);

            //User
            var lsUser = IssueManager.GetUserCountByProjectId(ProjectId);

            //Type
            var lsType = IssueManager.GetTypeCountByProjectId(ProjectId);

            CategoryTreeView1.ProjectId = ProjectId;
            CategoryTreeView1.BindData();

            rptMilestonesOpenIssues.DataSource = lsVersion;
            rptIssueStatus.DataSource = lsStatus;
            rptPriorityOpenIssues.DataSource = lsPriority;
            rptAssigneeOpenIssues.DataSource = lsUser;
            rptTypeOpenIssues.DataSource = lsType;

            rptMilestonesOpenIssues.DataBind();
            rptIssueStatus.DataBind();
            rptPriorityOpenIssues.DataBind();
            rptAssigneeOpenIssues.DataBind();
           
            rptTypeOpenIssues.DataBind();

            var p = ProjectManager.GetById(ProjectId);
            litProject.Text = p.Name;
            litProjectCode.Text = p.Code;

        }

		/// <summary>
		/// Binds the data for the versions repeater
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
        protected void SummaryItemDataBound(object sender, RepeaterItemEventArgs e)
		{
		    switch (e.Item.ItemType)
		    {
		        case ListItemType.AlternatingItem:
		        case ListItemType.Item:
		            {
		                var data = e.Item.DataItem as IssueCount;

                        if (data == null) return;

                        var summaryImage = e.Item.FindControl("summaryImage") as TextImage;
                        var summaryLink = e.Item.FindControl("summaryLink") as HyperLink;
                        var summaryCount = e.Item.FindControl("summaryCount") as Label;
                        var summaryPercent = e.Item.FindControl("summaryPercent") as Label;

                        if (summaryImage != null)
                        {
                            summaryImage.Text = data.Name;

                            if (data.ImageUrl.Length > 0)
                                summaryImage.ImageUrl = data.ImageUrl;

                            if (data.Id.ToString().Equals(Globals.NEW_ID.ToString()) || data.Id.ToString().Equals(Globals.EMPTY_GUID))
                                summaryImage.Visible = false;
                        }

                        if (summaryLink != null)
                        {
                            summaryLink.Text = data.Name.Trim();

                            // if the item is unassigned then apply the item name from the resource file
                            if (data.Id.Equals(0))
                                summaryLink.Text = GetGlobalResourceObject("SharedResources", "Unassigned").ToString();
                        }

                        if (summaryCount != null)
                        {
                            summaryCount.Text = data.Count.ToString();
                        }

                        if (summaryPercent != null)
                        {
                            summaryPercent.Text = String.Format("({0}%)", data.Percentage);
                        }
		            }
		            break;
		    }
		}
	}
}
