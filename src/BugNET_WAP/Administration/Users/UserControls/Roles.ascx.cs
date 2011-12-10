using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Users.UserControls
{
    public partial class Roles : BaseUserControlUserAdmin, IEditUserControl
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public event ActionEventHandler Action;

        void OnAction(ActionEventArgs args)
        {
            if (Action != null)
                Action(this, args);
        }

        public Guid UserId
        {
            get { return ViewState.Get("UserId", Guid.Empty); }
            set { ViewState.Set("UserId", value); }
        }

        public void Initialize()
        {
            LoadControlData();
            RoleList.Items.Clear();
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void LoadControlData(bool loadProjects = true)
        {
            GetMembershipData(UserId);

            if (MembershipData == null) return;

            if (loadProjects)
            {
                dropProjects.DataSource = ProjectManager.GetAllProjects();
                dropProjects.DataBind();
            }

            if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE)) return;

            chkSuperUsers.Visible = true;
            chkSuperUsers.Checked = UserManager.IsInRole(MembershipData.UserName, 0, Globals.SUPER_USER_ROLE);
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the ddlProjects control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void DdlProjectsSelectedIndexChanged(object sender, EventArgs e)
        {
            if (dropProjects.SelectedValue != 0)
            {
                GetMembershipData(UserId);

                RoleList.Items.Clear();
                var projectId = dropProjects.SelectedValue;
                var roles = RoleManager.GetByProjectId(projectId);

                foreach (var r in roles)
                {
                    if (r.ProjectId == 0) continue;

                    var roleListItem = new ListItem
                                           {
                                               Text = r.Name,
                                               Value = r.Id.ToString(),
                                               Selected = UserManager.IsInRole(MembershipData.UserName, projectId, r.Name)
                                           };
                    RoleList.Items.Add(roleListItem);
                }
            }
            else
            {
                RoleList.Items.Clear();
            }
        }

        /// <summary>
        /// Handles the CheckChanged event of the chkSuperUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ChkSuperUsersCheckChanged(object sender, EventArgs e)
        {
            GetMembershipData(UserId);

            var userName = MembershipData.UserName;

            if (chkSuperUsers.Checked && !UserManager.IsInRole(userName, 0, Globals.SUPER_USER_ROLE))
                RoleManager.AddUser(userName, 1);

            else if (!chkSuperUsers.Checked && UserManager.IsInRole(userName, 0, Globals.SUPER_USER_ROLE))
                RoleManager.RemoveUser(userName, 1);
        }
        /// <summary>
        /// CMDs the update roles.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CmdUpdateRolesClick(object sender, EventArgs e)
        {
            UpdateRolesFromList();
            LoadControlData(false);
        }

        /// <summary>
        /// Updates the roles from list.
        /// </summary>
        private void UpdateRolesFromList()
        {
            GetMembershipData(UserId);

            var userName = MembershipData.UserName;

            //if (chkSuperUsers.Visible && !ITUser.IsInRole(userName,0,Globals.SuperUserRole))
            //    Role.AddUserToRole(userName, 1);
            //else if (chkSuperUsers.Visible && !ITUser.IsInRole(userName, 0, Globals.SuperUserRole))
            //    Role.RemoveUser(userName, 1);

            foreach (ListItem roleListItem in RoleList.Items)
            {
                var roleName = roleListItem.Text;                           
                var enableRole = roleListItem.Selected;

                if (enableRole && !UserManager.IsInRole(userName,dropProjects.SelectedValue, roleName))
                {
                    RoleManager.AddUser(userName, Convert.ToInt32(roleListItem.Value));
                }
                else if (!enableRole && UserManager.IsInRole(userName,dropProjects.SelectedValue, roleName))
                {
                    RoleManager.RemoveUser(userName, Convert.ToInt32(roleListItem.Value));
                }
            }

            ActionMessage.ShowSuccessMessage(GetLocalResourceObject("UserRolesUpdateSuccess").ToString());
        }

        protected void CmdCancelClick(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Administration/Users/UserList.aspx");
        }
    }
}