namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;

    /// <summary>
	///	Summary description for ProjectMemberRoles.
	/// </summary>
	public partial class ProjectRoles : System.Web.UI.UserControl, IEditProjectControl
	{
        private int _RoleId = -1;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
		
		}
        /// <summary>
        /// Role Id
        /// </summary>
        int RoleId
        {
            get
            {
                if (ViewState["RoleId"] == null)
                    return 0;
                else
                    return (int)ViewState["RoleId"];
            }
            set { ViewState["RoleId"] = value; }
        }

		#region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
            get { return ((BasePage)Page).ProjectId; }
            set { ((BasePage)Page).ProjectId = value; }
		}

        /// <summary>
        /// Inits this instance.
        /// </summary>
		public void Initialize()
		{
            SecurityRoles.SelectParameters.Clear();
            SecurityRoles.SelectParameters.Add("projectId",ProjectId.ToString());
            gvRoles.DataBind();
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

		#region Private Methods  

        /// <summary>
        /// Handles the Click event of the cmdAddUpdateRole control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void cmdAddUpdateRole_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    if (RoleId == 0)
                    {
                        string RoleName = txtRoleName.Text.Trim();
                        RoleId = RoleManager.CreateRole(RoleName, ProjectId, txtDescription.Text, chkAutoAssign.Checked);
                        UpdatePermissions(RoleId);
                    }
                    else
                    {
                        Role r = RoleManager.GetRoleById(RoleId);
                        r.Description = txtDescription.Text.Trim();
                        r.Name = txtRoleName.Text.Trim();
                        r.AutoAssign = chkAutoAssign.Checked;
                        RoleManager.SaveRole(r);
                        UpdatePermissions(RoleId);
                    }

                    AddRole.Visible = !AddRole.Visible;
                    Roles.Visible = !Roles.Visible;
                    Initialize();
                }
                catch
                {
                    lblError.Text = LoggingManager.GetErrorMessageResource("AddRoleError");
                }
            }	
        }
        /// <summary>
        /// Binds the role details.
        /// </summary>
        /// <param name="roleId">The role id.</param>
		private void BindRoleDetails(int roleId)
		{
            if (roleId == -1)
            {
                cmdAddUpdateRole.Text = "Add Role";
                cmdDelete.Visible = false;
                cancel.Visible = false;
                txtRoleName.Enabled = true;
                txtRoleName.Text = string.Empty;
                txtDescription.Text = string.Empty;
                txtDescription.Enabled = true;
                chkAddSubIssue.Checked = false;
                chkAddSubIssue.Enabled = true;
                chkAutoAssign.Enabled = true;
                chkAutoAssign.Checked = false;
                chkAssignIssue.Enabled = true;
                chkAssignIssue.Checked = false;
                chkCloseIssue.Enabled = true;
                chkCloseIssue.Checked = false;
                chkAddAttachment.Enabled = true;
                chkAddAttachment.Checked = false;
                chkAddComment.Enabled = true;
                chkAddComment.Checked = false;
                chkAddIssue.Enabled = true;
                chkAddIssue.Checked = false;
                chkAddRelated.Enabled = true;
                chkAddRelated.Checked = false;
                chkAddTimeEntry.Enabled = true;
                chkAddTimeEntry.Checked = false;
                chkAssignIssue.Enabled = true;
                chkAssignIssue.Checked = false;
                chkDeleteAttachment.Enabled = true;
                chkDeleteAttachment.Checked = false;
                chkDeleteComment.Enabled = true;
                chkDeleteComment.Checked = false;
                chkDeleteIssue.Enabled = true;
                chkDeleteIssue.Checked = false;
                chkDeleteRelated.Enabled = true;
                chkDeleteRelated.Checked = false;
                chkDeleteTimeEntry.Enabled = true;
                chkDeleteTimeEntry.Checked = false;
                chkEditComment.Enabled = true;
                chkEditComment.Checked = false;
                chkEditIssue.Enabled = true;
                chkEditIssue.Checked = false;
                chkEditIssueDescription.Enabled = true;
                chkEditIssueDescription.Checked = false;
                chkEditIssueSummary.Enabled = true;
                chkEditIssueSummary.Checked = false;
                chkEditOwnComment.Enabled = true;
                chkEditOwnComment.Checked = false;
                chkEditQuery.Enabled = true;
                chkEditQuery.Checked = false;
                chkReOpenIssue.Enabled = true;
                chkReOpenIssue.Checked = false;
                chkSubscribeIssue.Enabled = true;
                chkSubscribeIssue.Checked = false;
                chkDeleteQuery.Enabled = true;
                chkDeleteQuery.Checked = false;
                chkAddQuery.Enabled = true;
                chkAddQuery.Checked = false;
                chkEditProject.Checked = false;
                chkChangeIssueStatus.Checked = false;
                chkAddParentIssue.Checked = false;
                chkDeleteSubIssue.Checked = false;
                chkDeleteParentIssue.Checked = false;
                chkEditProject.Checked = false;
                chkDeleteProject.Checked = false;
                chkCloneProject.Checked = false;
                chkCreateProject.Checked = false;
                chkViewProjectCalendar.Checked = false;
            }
            else
            {
                RoleId = roleId;
                Role r = RoleManager.GetRoleById(roleId);

                foreach (string s in Globals.DefaultRoles)
                {
                    //if default role lock record
                    if (r.Name == s)
                    {
                        cmdDelete.Visible = false;
                        cancel.Visible = false;
                        txtRoleName.Enabled = false;
                        txtDescription.Enabled = false;
                    }
                }
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), r.Name);
                cmdDelete.OnClientClick = String.Format("return confirm('{0}');", message);
                cancel.OnClientClick = String.Format("return confirm('{0}');", message);
                AddRole.Visible = !AddRole.Visible;
                Roles.Visible = !Roles.Visible;
                cmdAddUpdateRole.Text = GetLocalResourceObject("UpdateRole").ToString();
                txtRoleName.Text = r.Name;
                txtDescription.Text = r.Description;
                chkAutoAssign.Checked = r.AutoAssign;
                RoleNameTitle.Text = GetLocalResourceObject("RoleNameTitle.Text").ToString() + " " + r.Name;
                ReBind();
            }
		}
		#endregion
   
        /// <summary>
        /// Handles the Click event of the AddRole control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void AddRole_Click(object sender, EventArgs e)
        {
            AddRole.Visible = !AddRole.Visible;
            Roles.Visible= !Roles.Visible;          
            txtRoleName.Visible = true;
            txtRoleName.Text = string.Empty;
            RoleNameTitle.Text = GetLocalResourceObject("AddNewRoleManager.Text").ToString();       
            cmdDelete.Visible = false;
            cancel.Visible = false;
            BindRoleDetails(-1);
        }

        /// <summary>
        /// Handles the RowCommand event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewCommandEventArgs"/> instance containing the event data.</param>
        protected void gvRoles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditRole":
                    //get roles details and bind to form
                    BindRoleDetails(Convert.ToInt32(e.CommandArgument));
                    break;
            }
        }

        /// <summary>
        /// Updates the permissions.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        private void UpdatePermissions(int roleId)
        {
            //adds
            if (chkAddIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_ISSUE); }
            if (chkAddComment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_COMMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_COMMENT); }
            if (chkAddAttachment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_ATTACHMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_ATTACHMENT); }
            if (chkAddRelated.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_RELATED); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_RELATED); }
            if (chkAddTimeEntry.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_TIME_ENTRY); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_TIME_ENTRY); }

            if (chkAddQuery.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_QUERY); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_QUERY);
            if (chkAddSubIssue.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_SUB_ISSUE); else RoleManager.DeleteRolePermission(roleId,(int)Globals.Permission.ADD_SUB_ISSUE);
            if (chkAddParentIssue.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADD_PARENT_ISSUE); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADD_PARENT_ISSUE);

            //edits
            if (chkEditProject.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADMIN_EDIT_PROJECT); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADMIN_EDIT_PROJECT);
            if (chkDeleteProject.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADMIN_DELETE_PROJECT); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADMIN_DELETE_PROJECT);
            if (chkDeleteProject.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADMIN_CLONE_PROJECT); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADMIN_CLONE_PROJECT);
            if (chkCreateProject.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ADMIN_CREATE_PROJECT); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ADMIN_CREATE_PROJECT);
            if (chkViewProjectCalendar.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.VIEW_PROJECT_CALENDAR); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.VIEW_PROJECT_CALENDAR);
            if (chkChangeIssueStatus.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.CHANGE_ISSUE_STATUS); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.CHANGE_ISSUE_STATUS);
            if (chkEditQuery.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.EDIT_QUERY); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.EDIT_QUERY);

            if (chkEditIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE); }
            if (chkEditComment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.EDIT_COMMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.EDIT_COMMENT); }
            if (chkEditOwnComment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.OWNER_EDIT_COMMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.OWNER_EDIT_COMMENT); }
            if (chkEditIssueDescription.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE_DESCRIPTION); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE_DESCRIPTION); }
            if (chkEditIssueSummary.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE_TITLE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.EDIT_ISSUE_TITLE); }

            //deletes
            if (chkDeleteIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_ISSUE); }
            if (chkDeleteComment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_COMMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_COMMENT); }
            if (chkDeleteAttachment.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_ATTACHMENT); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_ATTACHMENT); }
            if (chkDeleteRelated.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_RELATED); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_RELATED); }

            if (chkDeleteQuery.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_QUERY); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_QUERY);
            if (chkDeleteParentIssue.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_PARENT_ISSUE); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_PARENT_ISSUE);
            if (chkDeleteSubIssue.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_SUB_ISSUE); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_SUB_ISSUE);


            //misc
            if (chkAssignIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.ASSIGN_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.ASSIGN_ISSUE); }
            if (chkSubscribeIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.SUBSCRIBE_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.SUBSCRIBE_ISSUE); }

            if (chkReOpenIssue.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.REOPEN_ISSUE); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.REOPEN_ISSUE); }
            
            if (chkCloseIssue.Checked) RoleManager.AddRolePermission(roleId, (int)Globals.Permission.CLOSE_ISSUE); else RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.CLOSE_ISSUE); 

            if (chkDeleteTimeEntry.Checked)
            { RoleManager.AddRolePermission(roleId, (int)Globals.Permission.DELETE_TIME_ENTRY); }
            else
            { RoleManager.DeleteRolePermission(roleId, (int)Globals.Permission.DELETE_TIME_ENTRY); }
        }

        /// <summary>
        /// Rebinds the permission checkboxes.
        /// </summary>
        private void ReBind()
        {
            chkChangeIssueStatus.Checked = false;
            chkAssignIssue.Checked = false;
            chkCloseIssue.Checked = false;
            chkAddAttachment.Checked = false;
            chkAddComment.Checked = false;
            chkAddIssue.Checked = false;
            chkAddRelated.Checked = false;
            chkAddTimeEntry.Checked = false;            
            chkDeleteAttachment.Checked = false;
            chkDeleteComment.Checked = false;
            chkDeleteIssue.Checked = false;
            chkDeleteRelated.Checked = false;
            chkDeleteTimeEntry.Checked = false;
            chkEditComment.Checked = false;
            chkEditIssue.Checked = false;
            chkEditIssueDescription.Checked = false;
            chkEditIssueSummary.Checked = false;
            chkEditOwnComment.Checked = false;
            chkReOpenIssue.Checked = false;
            chkSubscribeIssue.Checked = false;
            chkAddQuery.Checked = false;
            chkDeleteQuery.Checked = false;
            chkEditProject.Checked = false;
            chkChangeIssueStatus.Checked = false;
            chkAddParentIssue.Checked = false;
            chkDeleteSubIssue.Checked = false;
            chkDeleteParentIssue.Checked = false;
            chkEditProject.Checked = false;
            chkDeleteProject.Checked = false;
            chkCloneProject.Checked = false;
            chkCreateProject.Checked = false;
            chkViewProjectCalendar.Checked = false;

            List<Permission> permissions = RoleManager.GetPermissionsByRoleId(RoleId);

            foreach (Permission p in permissions)
            {
                switch (p.Key)
                {                 
                    case "ADD_TIME_ENTRY":
                        chkAddTimeEntry.Checked = true;
                        break;
                    case "ADD_QUERY":
                        chkAddQuery.Checked = true;
                        break;
                    case "ADD_ISSUE":
                        chkAddIssue.Checked = true;
                        break;
                    case "ADD_PARENT_ISSUE":
                        chkAddParentIssue.Checked = true;
                        break;
                    case "ADD_SUB_ISSUE":
                        chkAddSubIssue.Checked = true;
                        break;
                    case "ADD_COMMENT":
                        chkAddComment.Checked = true;
                        break;
                    case "ADD_ATTACHMENT":
                        chkAddAttachment.Checked = true;
                        break;
                    case "ADD_RELATED":
                        chkAddRelated.Checked = true;
                        break;
                    case "EDIT_ISSUE":
                        chkEditIssue.Checked = true;
                        break;
                    case "EDIT_QUERY":
                        chkEditQuery.Checked = true;
                        break;
                    case "EDIT_COMMENT":
                        chkEditComment.Checked = true;
                        break;
                    case "OWNER_EDIT_COMMENT":
                        chkEditOwnComment.Checked = true;
                        break;
                    case "DELETE_ISSUE":
                        chkDeleteIssue.Checked = true;
                        break;
                    case "DELETE_COMMENT":
                        chkDeleteComment.Checked = true;
                        break;
                    case "DELETE_ATTACHMENT":
                        chkDeleteAttachment.Checked = true;
                        break;
                    case "DELETE_RELATED":
                        chkDeleteRelated.Checked = true;
                        break;
                    case "DELETE_PARENT_ISSUE":
                        chkDeleteParentIssue.Checked = true;
                        break;
                    case "DELETE_SUB_ISSUE":
                        chkDeleteSubIssue.Checked = true;
                        break;
                    case "DELETE_TIME_ENTRY":
                        chkDeleteTimeEntry.Checked = true;
                        break;
                    case "DELETE_QUERY":
                        chkDeleteQuery.Checked = true;
                        break;
                    case "ASSIGN_ISSUE":
                        chkAssignIssue.Checked = true;
                        break;
                    case "SUBSCRIBE_ISSUE":
                        chkSubscribeIssue.Checked = true;
                        break;
                    case "CHANGE_ISSUE_STATUS":
                        chkChangeIssueStatus.Checked = true;
                        break;
                    case "REOPEN_ISSUE":
                        chkReOpenIssue.Checked = true;
                        break;
                    case "CLOSE_ISSUE":
                        chkCloseIssue.Checked = true;
                        break;
                    case "EDIT_ISSUE_DESCRIPTION":
                        chkEditIssueDescription.Checked = true;
                        break;
                    case "EDIT_ISSUE_TITLE":
                        chkEditIssueSummary.Checked = true;
                        break;
                    case "ADMIN_EDIT_PROJECT":
                        chkEditProject.Checked = true;
                        break;
                    case "ADMIN_DELETE_PROJECT":
                        chkDeleteProject.Checked = true;
                        break;
                    case "ADMIN_CLONE_PROJECT":
                        chkCloneProject.Checked = true;
                        break;
                    case "ADMIN_CREATE_PROJECT":
                        chkCreateProject.Checked = true;
                        break;
                    case "VIEW_PROJECT_CALENDAR":
                        chkViewProjectCalendar.Checked = true;
                        break;
                }

            }
        }
        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            AddRole.Visible = !AddRole.Visible;
            Roles.Visible = !Roles.Visible;
            RoleId = -1;
        }

        /// <summary>
        /// Handles the Click event of the cmdDelete control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdDelete_Click(object sender, EventArgs e)
        {
            try
            {
                RoleManager.DeleteRole(RoleId);
                AddRole.Visible = !AddRole.Visible;
                Roles.Visible = !Roles.Visible;
                Initialize();
            }
            catch
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteRoleError"); 
            }
        }
	}
}
