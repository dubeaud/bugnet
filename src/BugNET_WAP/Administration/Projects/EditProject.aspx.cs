using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects
{
	/// <summary>
	/// Edit project administration page.
	/// </summary>
	public partial class EditProject : BasePage 
	{
		private Control _contentControl;
	    private readonly Dictionary<string, string> _menuItems = new Dictionary<string, string>();

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{

            if (!UserManager.HasPermission(ProjectId, Globals.Permission.AdminEditProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

			if (!Page.IsPostBack)
			{
				litProjectName.Text = ProjectManager.GetById(ProjectId).Name;

                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), litProjectName.Text);
                Image1.OnClientClick = String.Format("return confirm('{0}');", message);

                message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), litProjectName.Text);
                DeleteButton.OnClientClick = String.Format("return confirm('{0}');", message);

                if (!UserManager.HasPermission(ProjectId, Globals.Permission.AdminDeleteProject.ToString()))
                {
                    DeleteButton.Visible = false;
                    Image1.Visible = false;
                }

                var p = ProjectManager.GetById(ProjectId);
                ProjectDisableEnable(p.Disabled);
			}

            _menuItems.Add(GetLocalResourceObject("Details").ToString(), "application_home.png");
            _menuItems.Add(GetLocalResourceObject("Categories").ToString(), "plugin.gif");
            _menuItems.Add(GetLocalResourceObject("Status").ToString(), "greencircle.png");
            _menuItems.Add(GetLocalResourceObject("Priorities").ToString(), "Critical.gif");
            _menuItems.Add(GetLocalResourceObject("Milestones").ToString(), "package.gif");
            _menuItems.Add(GetLocalResourceObject("IssueTypes").ToString(), "bug.gif");
            _menuItems.Add(GetLocalResourceObject("Resolutions").ToString(), "accept.gif");
            _menuItems.Add(GetLocalResourceObject("Members").ToString(), "users_group.png");
            _menuItems.Add(GetLocalResourceObject("SecurityRoles").ToString(), "shield.gif");
            _menuItems.Add(GetLocalResourceObject("Notifications").ToString(), "email_go.gif");
            _menuItems.Add(GetLocalResourceObject("CustomFields").ToString(), "textfield.gif");
            _menuItems.Add(GetLocalResourceObject("Mailboxes").ToString(), "email.gif");
            _menuItems.Add(GetLocalResourceObject("Subversion").ToString(), "svnLogo_sm.jpg");

            AdminMenu.DataSource = _menuItems;
            AdminMenu.DataBind();    

            if (TabId != -1)
                LoadTab(TabId);      
		}

        /// <summary>
        /// Changes the Enabled/Disabled Icon
        /// </summary>
        /// <param name="disabled"></param>
        void ProjectDisableEnable(bool disabled)
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
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var dataItem = (KeyValuePair<string, string>)e.Item.DataItem;
            var listItem = e.Item.FindControl("ListItem") as HtmlGenericControl;
            var lb = e.Item.FindControl("MenuButton") as LinkButton;
            if (listItem != null)
                listItem.Attributes.Add("style", string.Format("background: #C4EFA1 url(../../images/{0}) no-repeat 5px 4px;", dataItem.Value));
            if (lb != null) lb.Text = dataItem.Key;
        }

        /// <summary>
        /// Gets or sets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        int TabId 
		{
			get { return ViewState.Get("TabId", 0); }
            set { ViewState.Set("TabId", value);}
		}

        /// <summary>
        /// Loads the tab.
        /// </summary>
        /// <param name="selectedTab">The selected tab.</param>
		void LoadTab(int selectedTab) 
		{
			var controlName = "ProjectDescription.ascx";

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

            for (var i = 0; i < _menuItems.Count; i++)
            {
                if (i == TabId)
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "on");
                else
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "off");
            }

			_contentControl = Page.LoadControl("~/Administration/Projects/UserControls/" + controlName);
			((IEditProjectControl)_contentControl).ProjectId = ProjectId;
			plhContent.Controls.Clear();
			plhContent.Controls.Add( _contentControl );
			_contentControl.ID = "ctlContent";
            Image2.Visible = ((IEditProjectControl)_contentControl).ShowSaveButton;
            SaveButton.Visible = ((IEditProjectControl)_contentControl).ShowSaveButton;
            ((IEditProjectControl)_contentControl).Initialize();
            plhContent.Visible = true;
		}

        /// <summary>
        /// Handles the Click event of the DeleteButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void DisableButton_Click(Object s, EventArgs e) 
		{
            var p = ProjectManager.GetById(ProjectId);
            p.Disabled = true;
            ProjectManager.SaveOrUpdate(p);

            ProjectDisableEnable(true);
		}

        /// <summary>
        /// Handles the Click event of the DeleteButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void DeleteButton_Click(Object s, EventArgs e)
        {
            ProjectManager.Delete(ProjectId);
            Response.Redirect("~/Administration/Projects/ProjectList.aspx");
        }

        /// <summary>
        /// Handles the Click event of the RestoreButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RestoreButton_Click(Object s, EventArgs e)
        {
            var p = ProjectManager.GetById(ProjectId);
            p.Disabled = false;
            ProjectManager.SaveOrUpdate(p);

            ProjectDisableEnable(false);
        }

        /// <summary>
        /// Handles the Click event of the SaveButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveButton_Click(object s, EventArgs e)
        {
            var c = plhContent.FindControl("ctlContent");
            if (c == null) return;

            if (((IEditProjectControl)c).Update())
                Message1.ShowInfoMessage(GetLocalResourceObject("ProjectUpdated").ToString());
        }
	}
}
