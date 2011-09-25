using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// Summary description for BasePage.
    /// </summary>
    public class BasePage : System.Web.UI.Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="T:BasePage"/> class.
        /// </summary>
        public BasePage()
        { }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Load"></see> event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            Page.Title = string.Format("{0} - {1}", Page.Title, HostSettingManager.GetHostSetting("ApplicationTitle"));
        }

        /// <summary>
        /// Returns to previous page.
        /// </summary>
        public void ReturnToPreviousPage()
        {
            if (Session["ReferrerUrl"] != null)
                Response.Redirect((string)Session["ReferrerUrl"]);
            else
                Response.Redirect(string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId.ToString()));
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public virtual int ProjectId
        {
            get
            {
                if (ViewState["ProjectId"] == null)
                    return -1;
                else
                    return (int)ViewState["ProjectId"];
            }
            set { ViewState["ProjectId"] = value; }
        }

        /// <summary>
        /// Overrides the default OnInit to provide a security check for pages
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {

            base.OnInit(e);

            //Check for session timeouts
            if (Context.Session != null && User.Identity.IsAuthenticated)
            {
                //check whether a new session was generated
                //if (Session.IsNewSession)
                //{
                //    //check whether a cookies had already been associated with this request
                //    HttpCookie sessionCookie = Request.Cookies["ASP.NET_SessionId"];
                //    if (sessionCookie != null)
                //    {
                //        string sessionValue = sessionCookie.Value;
                //        if (!string.IsNullOrEmpty(sessionValue))
                //        {
                //            // we have session timeout condition!
                //            Response.Redirect("~/Errors/SessionExpired.aspx", true);
                //        }
                //    }
                //}

                //check whether a new session was generated
                if (Session.IsNewSession)
                {
                    //check whether a cookies had already been associated with this request
                    HttpCookie sessionCookie = Request.Cookies["ASP.NET_SessionId"];
                    if (sessionCookie != null)
                    {
                        string sessionValue = sessionCookie.Value;
                        if (!string.IsNullOrEmpty(sessionValue))
                        {
                            if (Session.SessionID != sessionValue)
                            {
                                // we have session timeout condition!
                                ErrorRedirector.TransferToSessionExpiredPage(Page);
                            }
                        }
                    }
                }
            }

            //Security check using the following rules:
            // Improvements for BGN-1379 More robust QueryStrings checking
            //
            //1. Application must allow anonymous identification (DisableAnonymousAccess HostSetting)
            //2. User must be athenticated if anonymous identification is false
            //3. Default page is not protected so the unauthenticated user may login
            if (!Boolean.Parse(HostSettingManager.GetHostSetting("AnonymousAccess")) && !User.Identity.IsAuthenticated && !Request.Url.LocalPath.EndsWith("Default.aspx"))
            {
                ErrorRedirector.TransferToLoginPage(Page);
            }
            else if (Request.QueryString["pid"] != null)
            {
                int ProjectId=-1;
                try
                {
                    ProjectId = Convert.ToInt32(Request.QueryString["pid"]);
                }
                catch
                {
                    ErrorRedirector.TransferToNotFoundPage(Page);
                }

                // Security check: Ensure the project exists (ie PID is valid project)
                Project myProj = ProjectManager.GetProjectById(ProjectId);

                if (myProj == null)
                {
                    // If myProj is a null it will cause an exception later on the page anyway, but I want to
                    // take extra measures here to prevent leaks of datatypes through exception messages.
                    // 
                    // This protects against the administrator turning on remote error messages and also 
                    // protects the business logic from injection attacks. 
                    //
                    // If this page is used consistently it will fool a hacker into thinking an actual 
                    // DB QUERY executed using the supplied attack. ;)

                    ErrorRedirector.TransferToNotFoundPage(Page);
                }

                //Security check using the following rules:
                //1. Anonymous user
                //2. The project type is private
                if (!User.Identity.IsAuthenticated && myProj.AccessType == Globals.ProjectAccessType.Private)
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }

                //Security check using the following rules:
                //1. Authenticated user
                //2. The project type is private 
                //3. The user is not a project member
                else if (User.Identity.IsAuthenticated && myProj.AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(User.Identity.Name, ProjectId))
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }
            }
        }

    }

}
