using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects
{
	/// <summary>
	/// Edit project administration page.
	/// </summary>
	public partial class EditProject :  BugNET.UserInterfaceLayer.BasePage 
	{
		private Control contentControl;
        Dictionary<string, string> _MenuItems = new Dictionary<string, string>();

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.AdminEditProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

			if (!Page.IsPostBack)
			{
				//get project id
				if (Request.QueryString["id"] != null)
					ProjectId = Convert.ToInt32(Request.QueryString["id"]);

				litProjectName.Text = ProjectManager.GetProjectById(ProjectId).Name;


                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), litProjectName.Text);
                Image1.OnClientClick = String.Format("return confirm('{0}');", message);
                message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), litProjectName.Text);
                DeleteButton.OnClientClick = String.Format("return confirm('{0}');", message);

                if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.AdminDeleteProject.ToString()))
                {
                    DeleteButton.Visible = false;
                    Image1.Visible = false;
                }

                Project p = ProjectManager.GetProjectById(ProjectId);
                ProjectDisableEnable(p.Disabled);
			}

            _MenuItems.Add(GetLocalResourceObject("Details").ToString(), "application_home.png");
            _MenuItems.Add(GetLocalResourceObject("Categories").ToString(), "plugin.gif");
            _MenuItems.Add(GetLocalResourceObject("Status").ToString(), "greencircle.png");
            _MenuItems.Add(GetLocalResourceObject("Priorities").ToString(), "Critical.gif");
            _MenuItems.Add(GetLocalResourceObject("Milestones").ToString(), "package.gif");
            _MenuItems.Add(GetLocalResourceObject("IssueTypes").ToString(), "bug.gif");
            _MenuItems.Add(GetLocalResourceObject("Resolutions").ToString(), "accept.gif");
            _MenuItems.Add(GetLocalResourceObject("Members").ToString(), "users_group.png");
            _MenuItems.Add(GetLocalResourceObject("SecurityRoles").ToString(), "shield.gif");
            _MenuItems.Add(GetLocalResourceObject("Notifications").ToString(), "email_go.gif");
            _MenuItems.Add(GetLocalResourceObject("CustomFields").ToString(), "textfield.gif");
            _MenuItems.Add(GetLocalResourceObject("Mailboxes").ToString(), "email.gif");
            _MenuItems.Add(GetLocalResourceObject("Subversion").ToString(), "svnLogo_sm.jpg");

            AdminMenu.DataSource = _MenuItems;
            AdminMenu.DataBind();    

            if (TabId != -1)
                LoadTab(TabId);      
		}

        /// <summary>
        /// Changes the Enabled/Disabled Icon
        /// </summary>
        /// <param name="disabled"></param>
        private void ProjectDisableEnable(bool disabled)
        {
            if (disabled)
            {
                DisableButton.Visible = false;
                DisableImage.Visible = false;
                RestoreButton.Visible = true;
                ImageButton1.Visible = true;
            }
            else
            {
                DisableButton.Visible = true;
                DisableImage.Visible = true;
                RestoreButton.Visible = false;
                ImageButton1.Visible = false;
            }
        }

        /// <summary>
        /// Handles the ItemCommand event of the AdminMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterCommandEventArgs"/> instance containing the event data.</param>
        protected void AdminMenu_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            TabId = e.Item.ItemIndex;
            LoadTab(TabId);
        }


        /// <summary>
        /// Handles the ItemDataBound event of the AdminMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void AdminMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                KeyValuePair<string, string> dataItem = (KeyValuePair<string, string>)e.Item.DataItem;
                HtmlGenericControl listItem = e.Item.FindControl("ListItem") as HtmlGenericControl;
                LinkButton lb = e.Item.FindControl("MenuButton") as LinkButton;
                listItem.Attributes.Add("style", string.Format("background: #C4EFA1 url(../../images/{0}) no-repeat 5px 4px;", dataItem.Value));
                lb.Text = dataItem.Key;
            }
        }

        /// <summary>
        /// Gets or sets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        int TabId 
		{
			get 
			{
				if (ViewState["TabId"] == null)
					return 0;
				else
					return (int)ViewState["TabId"];
			}

			set { ViewState["TabId"] = value; }
		}

        /// <summary>
        /// Loads the tab.
        /// </summary>
        /// <param name="selectedTab">The selected tab.</param>
		private void LoadTab(int selectedTab) 
		{
			string controlName = "ProjectDescription.ascx";

			switch (selectedTab) 
			{
				case 0:
					controlName = "ProjectDescription.ascx";
					break;
				case 1:
					controlName = "ProjectCategories.ascx";
					break;
				case 2:
                    controlName = "ProjectStatus.ascx";
					break;
				case 3:
                    controlName = "ProjectPriorities.ascx";		
					break;
				case 4:
                    controlName = "ProjectMilestones.ascx";			
					break;
				case 5:
                    controlName = "ProjectIssueTypes.ascx";
					break;
                case 6:
                    controlName = "ProjectResolutions.ascx";
                    break;
                case 7:
                    controlName = "ProjectMembers.ascx";
                    break;
                case 8:
                    controlName = "ProjectRoles.ascx";
                    break;
                case 9:
                    controlName = "ProjectNotifications.ascx";
                    break;
                case 10:
                    controlName = "ProjectCustomFields.ascx";
                    break;
                case 11:
                    controlName = "ProjectMailbox.ascx";
                    break;
                case 12:
                    controlName = "ProjectSubversion.ascx";
                    break;
				
			}

            for (int i = 0; i < _MenuItems.Count; i++)
            {
                if (i == TabId)
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "on");
                else
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "off");
            }

			contentControl = Page.LoadControl("~/Administration/Projects/UserControls/" + controlName);
			((IEditProjectControl)contentControl).ProjectId = ProjectId;
			plhContent.Controls.Clear();
			plhContent.Controls.Add( contentControl );
			contentControl.ID = "ctlContent";
            Image2.Visible = ((IEditProjectControl)contentControl).ShowSaveButton;
            SaveButton.Visible = ((IEditProjectControl)contentControl).ShowSaveButton;
            ((IEditProjectControl)contentControl).Initialize();
            plhContent.Visible = true;
		}

        /// <summary>
        /// Handles the Click event of the DeleteButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void DisableButton_Click(Object s, EventArgs e) 
		{
            Project p = ProjectManager.GetProjectById(ProjectId);
            p.Disabled = true;
            ProjectManager.SaveProject(p);

            ProjectDisableEnable(true);
		}

        /// <summary>
        /// Handles the Click event of the DeleteButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void DeleteButton_Click(Object s, EventArgs e)
        {
            ProjectManager.DeleteProject(ProjectId);
            Response.Redirect("~/Administration/Projects/ProjectList.aspx");
        }

        /// <summary>
        /// Handles the Click event of the RestoreButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RestoreButton_Click(Object s, EventArgs e)
        {
            Project p = ProjectManager.GetProjectById(ProjectId);
            p.Disabled = false;
            ProjectManager.SaveProject(p);

            ProjectDisableEnable(false);
        }

        /// <summary>
        /// Handles the Click event of the SaveButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveButton_Click(object s, EventArgs e)
        {
            Control c = plhContent.FindControl("ctlContent");
            if (c != null)
            {
                if (((IEditProjectControl)c).Update())
                    Message1.ShowInfoMessage(GetLocalResourceObject("ProjectUpdated").ToString());

            }

        }
	}
}
