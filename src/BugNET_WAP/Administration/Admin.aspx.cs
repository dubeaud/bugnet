using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration
{
    /// <summary>
    /// 
    /// </summary>
    public partial class Admin : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE) && !UserManager.IsInRole(Globals.ProjectAdminRole))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (!Page.IsPostBack)
            {
                //hide log viewer and host settings for non superusers
                if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE))
                {
                    lnkConfiguration.Visible = false;
                    Image4.Visible = false;
                    Image5.Visible = false;
                    lnkLogViewer.Visible = false;
                    //lnkNewProject.Visible = false;
                    //Image3.Visible = false;
                }
            }
        }
    }
}
