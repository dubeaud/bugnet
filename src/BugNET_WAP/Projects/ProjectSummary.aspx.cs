using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserControls;

namespace BugNET.Projects
{
	/// <summary>
	/// Summary description for BrowseProject.
	/// </summary>
	public partial class ProjectSummary : BugNET.UserInterfaceLayer.BasePage
	{
		protected System.Web.UI.WebControls.Repeater rptComponents;
		protected LinkButton lnkComponent;
		protected Label lblUnassignedCount;
		protected Label lblVersionCount;
		protected System.Web.UI.WebControls.Image  imgType;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
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
                
                BindProjectSummary();			
			}
		}

        /// <summary>
        /// Projects the selected index changed.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ProjectSelectedIndexChanged(Object s, EventArgs e)
        {
            BindProjectSummary();
        }

        /// <summary>
        /// Binds the project summary.
        /// </summary>
        private void BindProjectSummary()
        {
            lnkRSSIssuesByCategory.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=2",ProjectId);
            lnkRSSIssuesByAssignee.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=6",ProjectId);
            lnkRSSIssuesByStatus.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=3",ProjectId);
            lnkRSSIssuesByMilestone.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=1",ProjectId);
            lnkRSSIssuesByPriority.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=4",ProjectId);
            lnkRSSIssuesByType.NavigateUrl = string.Format("~/Feed.aspx?pid={0}&channel=5",ProjectId);
            //Milestone
            List<IssueCount> lsVersion = IssueManager.GetIssueMilestoneCountByProject(ProjectId);
            //Status
            List<IssueCount> lsStatus = IssueManager.GetIssueStatusCountByProject(ProjectId);
            //Priority
            List<IssueCount> lsPriority = IssueManager.GetIssuePriorityCountByProject(ProjectId);
            //User
            List<IssueCount> lsUser = IssueManager.GetIssueUserCountByProject(ProjectId);
            //Type
            List<IssueCount> lsType = IssueManager.GetIssueTypeCountByProject(ProjectId);

            CategoryTreeView1.ProjectId = ProjectId;
            CategoryTreeView1.BindData();

            rptVersions.DataSource = lsVersion;
            rptSummary.DataSource = lsStatus;
            rptOpenIssues.DataSource = lsPriority;
            rptAssignee.DataSource = lsUser;
            rptType.DataSource = lsType;

            rptVersions.DataBind();
            rptSummary.DataBind();
            rptOpenIssues.DataBind();
            rptAssignee.DataBind();
           
            rptType.DataBind();

            Project p = ProjectManager.GetById(ProjectId);
            litProject.Text = p.Name;
            litProjectCode.Text = p.Code;
            //DataBind();
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
			this.rptVersions.ItemDataBound+=new RepeaterItemEventHandler(rptVersions_ItemDataBound);
			this.rptSummary.ItemDataBound +=new RepeaterItemEventHandler(rptSummary_ItemDataBound);
			this.rptOpenIssues.ItemDataBound +=new RepeaterItemEventHandler(rptOpenIssues_ItemDataBound);
			this.rptAssignee.ItemDataBound+=new RepeaterItemEventHandler(rptAssignee_ItemDataBound);
            this.rptType.ItemDataBound += new RepeaterItemEventHandler(rptType_ItemDataBound); 
		}

     
		#endregion

		/// <summary>
		/// Binds the data for the versions repeater
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void rptVersions_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueCount bc = (IssueCount)e.Item.DataItem;
				((Label)e.Item.FindControl("lblVersionCount")).Text = bc.Count.ToString();
                ((Label)e.Item.FindControl("lblPercent")).Text = String.Format("({0}%)", bc.Percentage.ToString());
                TextImage ti = (TextImage)e.Item.FindControl("MilestoneImage");
                ti.Text = bc.Name;
                if(bc.ImageUrl.Length > 0)
                    ti.ImageUrl = bc.ImageUrl;
            }
            else if (e.Item.ItemType == ListItemType.Footer)
            {
                ((Label)e.Item.FindControl("lblUnscheduledCount")).Text = IssueManager.GetIssueUnscheduledMilestoneCountByProject(ProjectId).ToString();
                //((Label)e.Item.FindControl("lblPercent")).Text = String.Format("({0}%)", bc.Percentage.ToString());
            }
		}

        /// <summary>
        /// Handles the ItemDataBound event of the rptSummary control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
		private void rptSummary_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueCount bc = (IssueCount)e.Item.DataItem;
				((Label)e.Item.FindControl("lblCount")).Text = bc.Count.ToString();
                ((Label)e.Item.FindControl("lblPercent")).Text = String.Format("({0}%)", bc.Percentage.ToString());
                TextImage ti = (TextImage)e.Item.FindControl("StatusImage");
                ti.Text = bc.Name;    
                ti.ImageUrl = bc.ImageUrl;
                if (bc.ImageUrl.Length == 0)
                    ti.Visible = false;
			}
		}

        /// <summary>
        /// Handles the ItemDataBound event of the rptOpenIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
		private void rptOpenIssues_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueCount bc = (IssueCount)e.Item.DataItem;
				((Label)e.Item.FindControl("lblCount")).Text = bc.Count.ToString();
                TextImage ti = (TextImage)e.Item.FindControl("PriorityImage");
                ti.Text = bc.Name;
                ti.ImageUrl = bc.ImageUrl;
                if (bc.ImageUrl.Length == 0)
                    ti.Visible = false;
			}
		}

        /// <summary>
        /// Handles the ItemDataBound event of the rptAssignee control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
		private void rptAssignee_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueCount bc = (IssueCount)e.Item.DataItem;
				((Label)e.Item.FindControl("lblCount")).Text = bc.Count.ToString();
			}
			else if(e.Item.ItemType == ListItemType.Footer)
			{
				((Label)e.Item.FindControl("lblUnassignedCount")).Text = IssueManager.GetIssueUnassignedCountByProject(ProjectId).ToString();
			}
		}

        /// <summary>
        /// Handles the ItemDataBound event of the rptType control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
		private void rptType_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueCount bc = (IssueCount)e.Item.DataItem;
				((Label)e.Item.FindControl("lblCount")).Text = bc.Count.ToString();
                TextImage ti = (TextImage)e.Item.FindControl("IssueTypeImage");
                ti.Text = bc.Name;
                ti.ImageUrl = bc.ImageUrl;
                if (bc.ImageUrl.Length == 0)
                    ti.Visible = false;
			}
		}

        //Iman Mayes: Added member/role listing
        protected void rptMembers_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                MemberRoles mr = (MemberRoles)e.Item.DataItem;               
                ((Label)e.Item.FindControl("lblMember")).Text = mr.Username;            
                ((Label)e.Item.FindControl("lblRoles")).Text = mr.RoleString;
            }
        }

	}
}
