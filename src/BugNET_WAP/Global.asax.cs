using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using log4net;

namespace BugNET
{
    /// <summary>
    /// Global Application Class
    /// </summary>
    public class Global : HttpApplication
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Handles the Start event of the Application control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Application_Start(object sender, EventArgs e)
        {
            LoggingManager.ConfigureLogging();

            Log.Info("Application Start");
        }

        /// <summary>
        /// Handles the End event of the Application control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Application_End(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Handles the Error event of the Application control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Application_Error(Object sender, EventArgs e)
        {
            //set user to log4net context, so we can use %X{user} in the appenders
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", HttpContext.Current.User.Identity.Name);

            Log.Error("Application Error", Server.GetLastError());
        }

        /// <summary>
        /// Handles the End event of the Session control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Session_End(Object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Handles the BeginRequest event of the Application control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            var app = (HttpApplication)sender;
            var context = app.Context;

            // Attempt to perform first request initialization
            Initialization.Init(context);

            if (Request.Url.AbsoluteUri.ToLower().Contains("bugdetail.aspx"))
            {
                Response.Redirect(string.Format("~/Issues/IssueDetail.aspx{0}", Request.Url.Query));
            }
        }
  
    }

    /// <summary>
    /// Initialization class for IIS7 integrated mode
    /// </summary>
    static class Initialization
    {
        private static bool _sInitializedAlready = false;
        private static readonly Object Locker = new Object();

        /// <summary>
        /// Initializes only on the first request
        /// </summary>
        /// <param name="context">The context.</param>
        public static void Init(HttpContext context)
        {
            if (_sInitializedAlready)
            {
                return;
            }

            lock (Locker)
            {
                if (_sInitializedAlready)
                {
                    return;
                }

                //First check if we are upgrading/installing
                if (HttpContext.Current.Request.Url.LocalPath.ToLower().EndsWith("install.aspx"))
                    return;

                try
                {
                    switch (UpgradeManager.GetUpgradeStatus())
                    {
                        case UpgradeStatus.Install:
                        case UpgradeStatus.Upgrade:
                            HttpContext.Current.Response.Redirect("~/Install/Install.aspx", false);
                            break;
                    }
                }
                catch
                {
                  // could be just an error connecting to the database.
                }

                //load the host settings into the application cache
                HostSettingManager.GetHostSettings();

                // Perform first-request initialization here ...
                _sInitializedAlready = true;

            }
        }
    }
}
