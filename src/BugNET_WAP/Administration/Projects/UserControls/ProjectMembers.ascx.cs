namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;
    /// <summary>
	///		Summary description for ProjectMembers.
	/// </summary>
	public partial class ProjectMembers : System.Web.UI.UserControl, IEditProjectControl
	{
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}

		#region Web Form Designer generated code
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Init"></see> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.ddlProjectMembers.SelectedIndexChanged +=new EventHandler(ddlProjectMembers_SelectedIndexChanged);
			this.Button5.ServerClick+=new EventHandler(Button4_Click);
			this.Button3.ServerClick +=new EventHandler(Button3_Click);
		}
		#endregion

		#region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
            get{ return ((BasePage)Page).ProjectId;}
            set { ((BasePage)Page).ProjectId = value; }
		}


        /// <summary>
        /// Inits this instance.
        /// </summary>
		public void Initialize()
		{
			lstAllUsers.Items.Clear();
			lstSelectedUsers.Items.Clear(); 

			lstAllUsers.DataSource = UserManager.GetAllAuthorizedUsers();
			lstAllUsers.DataTextField = "DisplayName";
			lstAllUsers.DataValueField = "Username";
			lstAllUsers.DataBind();

			// Copy selected users into Selected Users List Box
            List<ITUser> projectUsers = UserManager.GetUsersByProjectId(ProjectId);
			foreach (ITUser currentUser in projectUsers) 
			{
				ListItem matchItem = lstAllUsers.Items.FindByValue(currentUser.UserName);
				if (matchItem != null) 
				{
					lstSelectedUsers.Items.Add(matchItem);
					lstAllUsers.Items.Remove(matchItem);
				}
			}

            //rebind the project members if it isn't populated
            if(ddlProjectMembers.Items.Count == 0)
              RebindProjectMembers();

		}

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
		{
			return true;
		}

        /// <summary>
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return false; }
        }

		#endregion

        /// <summary>
        /// Rebinds the project members.
        /// </summary>
		private void RebindProjectMembers()
		{
            ddlProjectMembers.DataSource = UserManager.GetUsersByProjectId(ProjectId);
			ddlProjectMembers.DataBind();
            ddlProjectMembers.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectUser").ToString(), "0"));
  
			lstSelectedRoles.Items.Clear();
			lstAllRoles.Items.Clear();
		}
        /// <summary>
        /// Adds the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void AddUser(Object s, EventArgs e) 
		{
            //The users must be added to a list first becuase the collection can not
            //be modified while we iterate through it.
            var usersToAdd = new List<ListItem>();

            foreach (ListItem item in lstAllUsers.Items)
                if (item.Selected)
                    usersToAdd.Add(item);


            foreach (var item in usersToAdd)
            {
                if (ProjectManager.AddUserToProject(item.Value, ProjectId))
                {
                    lstSelectedUsers.SelectedIndex = -1;
                    lstSelectedUsers.Items.Add(item);
                    lstAllUsers.Items.Remove(item);                 
                }
            }

            lstSelectedUsers.SelectedIndex = -1;
            RebindProjectMembers();
		}

        /// <summary>
        /// Removes the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void RemoveUser(Object s, EventArgs e) 
		{
            //The users must be added to a list first becuase the collection can not
            //be modified while we iterate through it.
            var usersToRemove = new List<ListItem>();

            foreach (ListItem item in lstSelectedUsers.Items)
                if (item.Selected)
                    usersToRemove.Add(item);


            foreach (var item in usersToRemove)
            {
                if (ProjectManager.RemoveUserFromProject(item.Value, ProjectId))
                {
                    lstAllUsers.Items.Add(item);
                    lstSelectedUsers.Items.Remove(item);
                    RebindProjectMembers();
                }
            }

            lstAllUsers.SelectedIndex = -1;
		}

        /// <summary>
        /// Handles the SelectedIndexChanged event of the ddlProjectMembers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		private void ddlProjectMembers_SelectedIndexChanged(object sender, EventArgs e)
		{
			lstSelectedRoles.Items.Clear();
			lstAllRoles.Items.Clear();

			if (ddlProjectMembers.SelectedIndex > 0) 
			{

				lstAllRoles.DataSource = RoleManager.GetByProjectId(ProjectId);
                lstAllRoles.DataTextField = "Name";
                lstAllRoles.DataValueField = "Id";
				lstAllRoles.DataBind();
 
				// Copy selected users into Selected Users List Box
                List<Role> UserRoles = RoleManager.GetForUser(ddlProjectMembers.SelectedValue, ProjectId);
				foreach (Role CurrentRole in UserRoles) 
				{
					ListItem matchItem = lstAllRoles.Items.FindByValue(CurrentRole.Id.ToString());
					if (matchItem != null) 
					{
						lstAllRoles.Items.Remove(matchItem);
						lstSelectedRoles.Items.Add(matchItem);
					}
				}

			}
		}

        /// <summary>
        /// Handles the Click event of the Button3 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		private void Button3_Click(object sender, EventArgs e)
		{
			if (lstAllRoles.SelectedIndex > -1) 
			{
                RoleManager.AddUser(ddlProjectMembers.SelectedValue, int.Parse(lstAllRoles.SelectedValue));
				lstSelectedRoles.SelectedIndex = -1;
				lstSelectedRoles.Items.Add( lstAllRoles.SelectedItem );
				lstAllRoles.Items.Remove(lstAllRoles.SelectedItem);
			}
		}

        /// <summary>
        /// Handles the Click event of the Button4 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		private void Button4_Click(object sender, EventArgs e)
		{
			if (lstSelectedRoles.SelectedIndex > -1) 
			{
                RoleManager.RemoveUser(ddlProjectMembers.SelectedValue, Int32.Parse(lstSelectedRoles.SelectedValue));
				lstAllRoles.SelectedIndex = -1;
				lstAllRoles.Items.Add( lstSelectedRoles.SelectedItem );
				lstSelectedRoles.Items.Remove(lstSelectedRoles.SelectedItem);
			
			}
		}

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Projects/EditProject.aspx?id=" + ProjectId.ToString());
        }
	}
}
