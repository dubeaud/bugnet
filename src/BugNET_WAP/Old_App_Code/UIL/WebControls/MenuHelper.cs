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
            Items.Add(new SuckerMenuItem("~/Default", Resources.SharedResources.Home, this));
    
           

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Items.Add(new SuckerMenuItem("~/Issues/MyIssues", Resources.SharedResources.MyIssues, this));
            }

            if (projectId > Globals.NEW_ID)
            {
                var oItemProject = new SuckerMenuItem("#", Resources.SharedResources.Project, this, "dropdown");

                Items.Insert(1, oItemProject);
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectSummary/{0}", projectId), Resources.SharedResources.ProjectSummary, this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/Roadmap/{0}", projectId), Resources.SharedResources.Roadmap,this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ChangeLog/{0}", projectId), Resources.SharedResources.ChangeLog, this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectCalendar/{0}", projectId), Resources.SharedResources.Calendar, this));

                if (!string.IsNullOrEmpty(ProjectManager.GetById(projectId).SvnRepositoryUrl))
                    oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/SvnBrowse/SubversionBrowser.aspx?pid={0}", projectId), Resources.SharedResources.Repository, this));

                var oItemIssues = new SuckerMenuItem("#", Resources.SharedResources.Issues, this, "dropdown");

                oItemIssues.Items.Add(new SuckerMenuItem(string.Format("~/Issues/IssueList.aspx?pid={0}", projectId), Resources.SharedResources.Issues, this));
                oItemIssues.Items.Add(new SuckerMenuItem(string.Format("~/Queries/QueryList.aspx?pid={0}", projectId), Resources.SharedResources.Queries, this));
                Items.Insert(2, oItemIssues);

                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //check add issue permission
                    if (UserManager.HasPermission(projectId, Common.Permission.AddIssue.ToString()))
                        Items.Add(new SuckerMenuItem(string.Format("~/Issues/CreateIssue/{0}", projectId), Resources.SharedResources.NewIssue, this));
                }
            }

            if (!HttpContext.Current.User.Identity.IsAuthenticated) return;

            var oItemAdmin = new SuckerMenuItem("#", Resources.SharedResources.Admin, this, "navbar-admin");

            if (projectId > Globals.NEW_ID && (UserManager.IsInRole(projectId, Globals.ProjectAdminRole) || UserManager.IsSuperUser()))
            {            
                oItemAdmin.Items.Add(new SuckerMenuItem(string.Format("~/Administration/Projects/EditProject/{0}", projectId), Resources.SharedResources.EditProject, this, "admin"));
            }
            
            if (UserManager.IsSuperUser())
            {
                oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Projects/ProjectList", Resources.SharedResources.Projects, this));
                oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Users/UserList", Resources.SharedResources.UserAccounts, this));
                oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/Settings", Resources.SharedResources.ApplicationConfiguration, this));
                oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/LogViewer", Resources.SharedResources.LogViewer, this));
            }

            if(oItemAdmin.Items.Count > 0)
            {
                Items.Add(oItemAdmin);
            }


        }
   
    }
}