using System;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;

namespace BugNET.HttpModules
{
    /// <summary>
    /// 
    /// </summary>
    public class LocalizationModule : IHttpModule
    {
        /// <summary>
        /// Gets the name of the module.
        /// </summary>
        /// <value>The name of the module.</value>
        public string ModuleName
        {
            get { return "LocalizationModule"; }
        }

        #region IHttpModule Members

        /// <summary>
        /// Disposes of the resources (other than memory) used by the module that implements <see cref="T:System.Web.IHttpModule"/>.
        /// </summary>
        public void Dispose()
        {
        }

        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpApplication"/> that provides access to the methods, properties, and events common to all application objects within an ASP.NET application</param>
        public void Init(HttpApplication context)
        {
            context.PreRequestHandlerExecute += context_PreRequestHandlerExecute;
        }

        #endregion

        /// <summary>
        /// Handles the PreRequestHandlerExecute event of the context control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void context_PreRequestHandlerExecute(object sender, EventArgs e)
        {        
            if (HttpContext.Current.Request.Url.LocalPath.ToLower().EndsWith("install.aspx"))
                return;

            string culture;

            if (HttpContext.Current.User == null || !HttpContext.Current.User.Identity.IsAuthenticated)
            {
                culture = HostSettingManager.Get(HostSettingNames.ApplicationDefaultLanguage);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            }
            else
            {
                var manager = HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();

                var user  = manager.FindByName(HttpContext.Current.User.Identity.Name);
                if (user != null)
                {
                    if(!string.IsNullOrWhiteSpace(user.PreferredLocale))
                    {
                        //retrieve culture
                        culture = user.PreferredLocale;

                        //set culture
                        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
                        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
                    }
                }
            }
        }
    }
}