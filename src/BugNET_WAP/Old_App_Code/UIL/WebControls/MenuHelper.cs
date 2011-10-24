using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;

namespace BugNET.UserInterfaceLayer.WebControls
{
    public class SuckerFishMenuHelper : MenuHelperRoot
    {
       
        public SuckerFishMenuHelper()
        {
            //Setup menu... 
            Items.Add(new SuckerMenuItem("~/Default.aspx", Resources.SharedResources.Home, this));
            Items.Add(new SuckerMenuItem("~/Issues/IssueSearch.aspx", Resources.SharedResources.Search, this));

            if (ProjectId > Globals.NEW_ID)
            {
                var oItemProject = new SuckerMenuItem(string.Format("~/Projects/ProjectSummary.aspx?pid={0}", ProjectId), string.Concat(Resources.SharedResources.Project, " »"), this);

                Items.Insert(1, oItemProject);
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/Roadmap.aspx?pid={0}", ProjectId),Resources.SharedResources.Roadmap,this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ChangeLog.aspx?pid={0}", ProjectId), Resources.SharedResources.ChangeLog, this));

                Items.Add(new SuckerMenuItem(string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId), Resources.SharedResources.Issues, this));
                Items.Add(new SuckerMenuItem(string.Format("~/Queries/QueryList.aspx?pid={0}", ProjectId), Resources.SharedResources.Queries, this));

                if (!string.IsNullOrEmpty(ProjectManager.GetProjectById(ProjectId).SvnRepositoryUrl))
                    Items.Add(new SuckerMenuItem(string.Format("~/SvnBrowse/SubversionBrowser.aspx?pid={0}", ProjectId),Resources.SharedResources.Repository,this));

                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //check add issue permission
                    if (UserManager.HasPermission(ProjectId, Globals.Permission.AddIssue.ToString()))
                        Items.Add(new SuckerMenuItem(string.Format("~/Issues/IssueDetail.aspx?pid={0}", ProjectId),Resources.SharedResources.NewIssue,this));

                    if (UserManager.HasPermission(ProjectId, Globals.Permission.ViewProjectCalendar.ToString()))
                        oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectCalendar.aspx?pid={0}", ProjectId),Resources.SharedResources.Calendar, this));
                }
            }

            if (!HttpContext.Current.User.Identity.IsAuthenticated) return;

            Items.Add(new SuckerMenuItem("~/Issues/MyIssues.aspx", Resources.SharedResources.MyIssues, this));

            if (ProjectId > Globals.NEW_ID && UserManager.IsInRole(Globals.ProjectAdminRole))
                Items.Add(new SuckerMenuItem(string.Format("~/Administration/Projects/EditProject.aspx?pid={0}", ProjectId), Resources.SharedResources.EditProject, this,"admin"));

            if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE)) return;

            var oItemAdmin = new SuckerMenuItem("~/Administration/Admin.aspx", string.Concat(Resources.SharedResources.Admin, " »"), this, "admin");
            Items.Add(oItemAdmin);
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Projects/ProjectList.aspx", Resources.SharedResources.Projects,this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Users/UserList.aspx", Resources.SharedResources.UserAccounts, this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/Settings.aspx", Resources.SharedResources.ApplicationConfiguration, this));
            oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/LogViewer.aspx", Resources.SharedResources.LogViewer, this));
        }

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        private static int ProjectId
        {
            get
            {
                return HttpContext.Current.Request.QueryString.Get("pid", Globals.NEW_ID);
            }
        }
    }
}