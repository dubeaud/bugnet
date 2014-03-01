using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;

namespace BugNET.UserInterfaceLayer.WebControls
{
    public class SuckerFishMenuHelper : MenuHelperRoot
    {

        /// <summary>
        /// Initializes a new instance of the <see cref="SuckerFishMenuHelper"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        public SuckerFishMenuHelper(int projectId)
        {
            //Setup menu... 
            Items.Add(new SuckerMenuItem("~/Default.aspx", Resources.SharedResources.Home, this));
            Items.Add(new SuckerMenuItem("~/Issues/IssueSearch.aspx", Resources.SharedResources.Search, this));

            if (projectId > Globals.NEW_ID)
            {
                var oItemProject = new SuckerMenuItem("#", Resources.SharedResources.Project, this, "dropdown");

                Items.Insert(1, oItemProject);
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectSummary.aspx?pid={0}", projectId), "Project Summary", this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/Roadmap.aspx?pid={0}", projectId),Resources.SharedResources.Roadmap,this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ChangeLog.aspx?pid={0}", projectId), Resources.SharedResources.ChangeLog, this));

                Items.Add(new SuckerMenuItem(string.Format("~/Issues/IssueList.aspx?pid={0}", projectId), Resources.SharedResources.Issues, this));
                Items.Add(new SuckerMenuItem(string.Format("~/Queries/QueryList.aspx?pid={0}", projectId), Resources.SharedResources.Queries, this));

                if (!string.IsNullOrEmpty(ProjectManager.GetById(projectId).SvnRepositoryUrl))
                    Items.Add(new SuckerMenuItem(string.Format("~/SvnBrowse/SubversionBrowser.aspx?pid={0}", projectId),Resources.SharedResources.Repository,this));

                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //check add issue permission
                    if (UserManager.HasPermission(projectId, Common.Permission.AddIssue.ToString()))
                        Items.Add(new SuckerMenuItem(string.Format("~/Issues/CreateIssue.aspx?pid={0}", projectId),Resources.SharedResources.NewIssue,this));

                    if (UserManager.HasPermission(projectId, Common.Permission.ViewProjectCalendar.ToString()))
                        oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectCalendar.aspx?pid={0}", projectId),Resources.SharedResources.Calendar, this));
                }
            }

            if (!HttpContext.Current.User.Identity.IsAuthenticated) return;

            Items.Add(new SuckerMenuItem("~/Issues/MyIssues.aspx", Resources.SharedResources.MyIssues, this));

            if (projectId > Globals.NEW_ID && (UserManager.IsInRole(projectId, Globals.ProjectAdminRole) || UserManager.IsSuperUser()))
                Items.Add(new SuckerMenuItem(string.Format("~/Administration/Projects/EditProject.aspx?pid={0}", projectId), Resources.SharedResources.EditProject, this,"admin"));

            if (!UserManager.IsSuperUser()) return;

            var oItemAdmin = new SuckerMenuItem("#", Resources.SharedResources.Admin, this, "navbar-admin");
            Items.Add(oItemAdmin);
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Projects/ProjectList.aspx", Resources.SharedResources.Projects,this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Users/UserList.aspx", Resources.SharedResources.UserAccounts, this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/Settings.aspx", Resources.SharedResources.ApplicationConfiguration, this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/LogViewer.aspx", Resources.SharedResources.LogViewer, this));
        }
   
    }
}