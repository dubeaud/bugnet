using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using Microsoft.AspNet.FriendlyUrls;
using System.Collections.Generic;

namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// Summary description for BasePage.
    /// </summary>
    public class BasePage : System.Web.UI.Page
    {
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Load"></see> event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Page.Title = string.Format("{0} - {1}", Page.Title, HostSettingManager.Get(HostSettingNames.ApplicationTitle));
        }

        /// <summary>
        /// Returns to previous page.
        /// </summary>
        public void ReturnToPreviousPage()
        {
            if (Session["ReferrerUrl"] != null)
                Response.Redirect((string)Session["ReferrerUrl"]);
            else
                Response.Redirect(string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId));
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public virtual int ProjectId
        {
            get { return ViewState.Get("ProjectId", Globals.NEW_ID); }
            set { ViewState.Set("ProjectId", value); }
        }

        /// <summary>
        /// Overrides the default OnInit to provide a security check for pages
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {

            base.OnInit(e);

            // Check for session timeouts
            if (Context.Session != null && User.Identity.IsAuthenticated)
            {
                // check whether a new session was generated
                if (Session.IsNewSession)
                {
                    // check whether a cookies had already been associated with this request
                    var sessionCookie = Request.Cookies["ASP.NET_SessionId"];
                    if (sessionCookie != null)
                    {
                        var sessionValue = sessionCookie.Value;
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

            // Security check using the following rules:
            // 1. Application must allow anonymous identification (DisableAnonymousAccess HostSetting)
            // 2. User must be authenticated if anonymous identification is false
            // 3. Default page is not protected so the unauthenticated user may login
            if (!HostSettingManager.Get(HostSettingNames.AnonymousAccess, false) && 
                !User.Identity.IsAuthenticated && 
                !Request.Url.LocalPath.EndsWith("Default.aspx"))
            {
                ErrorRedirector.TransferToLoginPage(Page);
            }

            int projectId = 0;
            try
            {
                IList<string> segments = Request.GetFriendlyUrlSegments();
                projectId = Int32.Parse(segments[0]);
            }
            catch
            {
                projectId = Request.QueryString.Get("pid", Globals.NEW_ID);
            }

            if (projectId <= Globals.NEW_ID) return;

            // Security check: Ensure the project exists (ie PID is valid project)
            var myProj = ProjectManager.GetById(projectId);

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
                return;
            }

            // set the project id if we have one
            ProjectId = projectId;

            // Security check using the following rules:
            // 1. Anonymous user
            // 2. The project type is private
            if (!User.Identity.IsAuthenticated &&
                myProj.AccessType == ProjectAccessType.Private)
            {
                ErrorRedirector.TransferToLoginPage(Page);
                return;
            }

            // Security check using the following rules:
            // 1. Not Super user
            // 2. Authenticated user
            // 3. The project type is private 
            // 4. The user is not a project member
            if (User.Identity.IsAuthenticated && !UserManager.IsSuperUser() &&
                myProj.AccessType == ProjectAccessType.Private &&
                !ProjectManager.IsUserProjectMember(User.Identity.Name, projectId))
            {
                ErrorRedirector.TransferToLoginPage(Page);
            }
        }
    }
}