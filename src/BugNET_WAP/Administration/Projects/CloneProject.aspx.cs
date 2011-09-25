using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects
{
    public partial class CloneProject : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.AdminCloneProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (!IsPostBack)
            {
                // Bind projects to dropdownlist
                ddlProjects.DataSource = ProjectManager.GetAllProjects();
                ddlProjects.DataBind();
            }
        }

        /// <summary>
        /// Handles the Click event of the btnClone control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnClone_Click(object sender, System.EventArgs e)
        {
            if (IsValid)
            {
                bool success = ProjectManager.CloneProject(Convert.ToInt32(ddlProjects.SelectedValue), txtNewProjectName.Text);
                if (success)
                    Response.Redirect("ProjectList.aspx");
                else
                    lblError.Text = LoggingManager.GetErrorMessageResource("CloneProjectError");
            }

        }

        /// <summary>
        /// Handles the Click event of the btnCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnCancel_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("ProjectList.aspx");
        }
    }
}
