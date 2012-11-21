using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET
{
	/// <summary>
	/// Summary description for _Default.
	/// </summary>
	public partial class _Default : Page
	{

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title"), HostSettingManager.Get(HostSettingNames.ApplicationTitle));

            if (!Page.IsPostBack)
            {
                lblApplicationTitle.Text = HostSettingManager.Get(HostSettingNames.ApplicationTitle);
                WelcomeMessage.Text = HostSettingManager.Get(HostSettingNames.WelcomeMessage);
                
            }

			if (!Context.User.Identity.IsAuthenticated)			
			{	
				//get all public available projects here
                if (Boolean.Parse(HostSettingManager.Get(HostSettingNames.AnonymousAccess)))
				{
					rptProject.DataSource = ProjectManager.GetPublicProjects();
				}
				else
				{
					rptProject.Visible=false;
                    lblMessage.Text = GetLocalResourceObject("AnonymousAccessDisabled").ToString();
                    lblMessage.Visible=true;
				}     
			}
			else
			{
				rptProject.DataSource = ProjectManager.GetByMemberUserName(User.Identity.Name);	
			}

			rptProject.DataBind();

            if (!UserMessage.Visible)
            // remember that we could have set the message already!
            {
                if (rptProject.Items.Count == 0)
                {
                    if (!Context.User.Identity.IsAuthenticated)
                    {
                        lblMessage.Text = GetLocalResourceObject("RegisterAndLoginMessage").ToString();
                        UserMessage.Visible = true;
                    }
                    else
                    {
                        lblMessage.Text = GetLocalResourceObject("NoProjectsToViewMessage").ToString();
                        UserMessage.Visible = true;
                    }
                }
            }

		
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
			this.rptProject.ItemDataBound+=new RepeaterItemEventHandler(rptProject_ItemDataBound);
		}
		#endregion

        /// <summary>
        /// Handles the ItemDataBound event of the rptProject control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
		private void rptProject_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{

			//check permissions
			if(e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
			{
				Project p = (Project)e.Item.DataItem;

				if(!Context.User.Identity.IsAuthenticated || !UserManager.HasPermission(p.Id,Common.Permission.AddIssue.ToString()))
					e.Item.FindControl("ReportIssue").Visible=false;

                if (!Context.User.Identity.IsAuthenticated || !UserManager.HasPermission(p.Id, Common.Permission.AdminEditProject.ToString()))
                    e.Item.FindControl("Settings").Visible = false;

                if (!Context.User.Identity.IsAuthenticated || !UserManager.HasPermission(p.Id, Common.Permission.ViewProjectCalendar.ToString()))
                    e.Item.FindControl("ProjectCalendar").Visible = false;

                Image ProjectImage = (Image)e.Item.FindControl("ProjectImage");                 
                ProjectImage.ImageUrl = string.Format("~/DownloadAttachment.axd?id={0}&mode=project",p.Id);
                
                Label OpenIssuesLink = (Label)e.Item.FindControl("OpenIssues");
                Label NextMilestoneDue = (Label)e.Item.FindControl("NextMilestoneDue");
                Label MilestoneComplete = (Label)e.Item.FindControl("MilestoneComplete");

                string milestone = string.Empty;

                List<Milestone> milestoneList = MilestoneManager.GetByProjectId(p.Id);
                milestoneList = milestoneList.FindAll(m => m.DueDate.HasValue && m.IsCompleted != true);

                if (milestoneList.Count > 0)
                {
                    List<Milestone> sortedMilestoneList = milestoneList.Sort<Milestone>("DueDate").ToList();
                    Milestone mileStone = sortedMilestoneList[0];
                    if (mileStone != null)
                    {
                        milestone = ((DateTime)mileStone.DueDate).ToShortDateString();
                        int[] progressValues = ProjectManager.GetRoadMapProgress(p.Id, mileStone.Id);
                        if (progressValues[0] != 0 || progressValues[1] != 0)
                        {
                            double percent = progressValues[0] * 100 / progressValues[1];
                            MilestoneComplete.Text = string.Format("{0}%", percent);
                        }
                        else
                        {
                            MilestoneComplete.Text = "0%";
                        }

                    } else
                        milestone = GetLocalResourceObject("None").ToString();

                    NextMilestoneDue.Text = string.Format(GetLocalResourceObject("NextMilestoneDue").ToString(), milestone);
                }
                else
                {
                    NextMilestoneDue.Text = string.Format(GetLocalResourceObject("NextMilestoneDue").ToString(),GetLocalResourceObject("NoDueDatesSet").ToString());
                }

                var status = StatusManager.GetByProjectId(p.Id);

                if (status.Count > 0)
                {
                    //get total open issues
                    var queryClauses = new List<QueryClause>
                    {
                        new QueryClause("AND", "iv.[IsClosed]", "=", "0", SqlDbType.Int),
                        new QueryClause("AND", "iv.[Disabled]", "=", "0", SqlDbType.Int)
                    };

                    var issueList = IssueManager.PerformQuery(queryClauses, null, p.Id);

                    OpenIssuesLink.Text = string.Format(GetLocalResourceObject("OpenIssuesCount").ToString(), issueList.Count);

                    var closedStatus = status.FindAll(s => s.IsClosedState);

                    if (closedStatus.Count.Equals(0))
                    {
                        // No open issue statuses means there is a problem with the setup of the system.
                        OpenIssuesLink.Text = GetLocalResourceObject("NoClosedStatus").ToString();
                    }
                }
                else
                {
                    // Warn users of a problem
                    OpenIssuesLink.Text = GetLocalResourceObject("NoStatusSet").ToString();
                }
               

				HyperLink atu = (HyperLink)e.Item.FindControl("AssignedToUser");
				Control AssignedUserFilter = e.Item.FindControl("AssignedUserFilter");
				if(Context.User.Identity.IsAuthenticated && ProjectManager.IsUserProjectMember(User.Identity.Name,p.Id))
				{
                    System.Web.Security.MembershipUser user = UserManager.GetUser(User.Identity.Name);

                    atu.NavigateUrl = string.Format("~/Issues/IssueList.aspx?pid={0}&u={1}", p.Id, user.UserName);
				}
				else
				{
					AssignedUserFilter.Visible=false;
				}
			}

		}

        
	}

    
}
