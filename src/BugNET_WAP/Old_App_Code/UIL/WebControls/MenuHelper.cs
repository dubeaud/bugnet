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
            //SuckerMenuItem oItemFoo = new SuckerMenuItem("#", "Foo functions &#8595;", this);
            SuckerMenuItem oItemHome = new SuckerMenuItem("~/Default.aspx", Resources.SharedResources.Home, this);
            Items.Add(oItemHome);
            SuckerMenuItem oItemSearch = new SuckerMenuItem("~/Issues/IssueSearch.aspx", Resources.SharedResources.Search, this);
            Items.Add(oItemSearch);

            if (ProjectId > 0)
            {
                SuckerMenuItem oItemProject = new SuckerMenuItem(string.Format("~/Projects/ProjectSummary.aspx?pid={0}", ProjectId), Resources.SharedResources.Project + " »", this);
                Items.Insert(1,oItemProject);
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/Roadmap.aspx?pid={0}", ProjectId),Resources.SharedResources.Roadmap,this));
                oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ChangeLog.aspx?pid={0}", ProjectId), Resources.SharedResources.ChangeLog, this));
                SuckerMenuItem oItemIssues = new SuckerMenuItem(string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId), Resources.SharedResources.Issues, this);
                Items.Add(oItemIssues);
                SuckerMenuItem oItemQueries = new SuckerMenuItem(string.Format("~/Queries/QueryList.aspx?pid={0}", ProjectId), Resources.SharedResources.Queries, this);
                Items.Add(oItemQueries);

                if (!string.IsNullOrEmpty(ProjectManager.GetProjectById(ProjectId).SvnRepositoryUrl))
                { 
                    SuckerMenuItem oItemRepository = new SuckerMenuItem(string.Format("~/SvnBrowse/SubversionBrowser.aspx?pid={0}", ProjectId),Resources.SharedResources.Repository,this);
                    Items.Add(oItemRepository);
                }

                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //check add issue permission
                    if (UserManager.HasPermission(ProjectId, Globals.Permission.ADD_ISSUE.ToString()))
                        Items.Add(new SuckerMenuItem(string.Format("~/Issues/IssueDetail.aspx?pid={0}", ProjectId),Resources.SharedResources.NewIssue,this));
                    if (UserManager.HasPermission(ProjectId, Globals.Permission.VIEW_PROJECT_CALENDAR.ToString()))
                        oItemProject.Items.Add(new SuckerMenuItem(string.Format("~/Projects/ProjectCalendar.aspx?pid={0}", ProjectId),Resources.SharedResources.Calendar, this));
                }
            }


            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                SuckerMenuItem oItemMyIssues = new SuckerMenuItem("~/Issues/MyIssues.aspx", Resources.SharedResources.MyIssues, this);
                Items.Add(oItemMyIssues);

                if (ProjectId != -1 && UserManager.IsInRole(Globals.ProjectAdminRole))
                    Items.Add(new SuckerMenuItem(string.Format("~/Administration/Projects/EditProject.aspx?id={0}", ProjectId), Resources.SharedResources.EditProject, this,"admin"));

                if (UserManager.IsInRole(Globals.SuperUserRole))
                {
                    SuckerMenuItem oItemAdmin = new SuckerMenuItem("~/Administration/Admin.aspx", Resources.SharedResources.Admin + " »", this, "admin");
                    Items.Add(oItemAdmin);
                    oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Projects/ProjectList.aspx", Resources.SharedResources.Projects,this));
                    oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Users/UserList.aspx", Resources.SharedResources.UserAccounts, this));
                    oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/Settings.aspx", Resources.SharedResources.ApplicationConfiguration, this));
                    oItemAdmin.Items.Add(new SuckerMenuItem("~/Administration/Host/LogViewer.aspx", Resources.SharedResources.LogViewer, this));
                }

            }       
        }

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get
            {
                if (HttpContext.Current.Request.QueryString["pid"] != null)
                {
                    return Int32.Parse(HttpContext.Current.Request.QueryString["pid"]);
                }
                else
                    return -1;
            }
        }

    }
}