using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using log4net;
using System.Xml;
using System.Globalization;

namespace BugNET.BLL
{
    public static class UpgradeManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Creates the custom field views for issue
        /// </summary>
        /// <returns></returns>
        public static bool CreateCustomFieldViews()
        {
            try
            {
                var projects = DataProviderManager.Provider.GetAllProjects();

                foreach (var project in projects)
                {
                    CustomFieldManager.UpdateCustomFieldView(project.Id);
                }

                return true;
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return false;
        }

        /// <summary>
        /// Executes the statements.
        /// </summary>
        /// <param name="statements">The statements.</param>
        public static void ExecuteStatements(IEnumerable<string> statements)
        {
            DataProviderManager.Provider.ExecuteScript(statements);

        }

        /// <summary>
        /// Gets the provider path.
        /// </summary>
        /// <returns></returns>
        public static string GetProviderPath()
        {
            return DataProviderManager.Provider.GetProviderPath();
        }

        /// <summary>
        /// Upgrades the database version.
        /// </summary>
        /// <param name="version">The version.</param>
        /// <returns></returns>
        public static bool UpdateDatabaseVersion(string version)
        {
            return HostSettingManager.UpdateHostSetting(HostSettingNames.Version, version);
        }

        /// <summary>
        /// Gets the upgrade status.
        /// 
        /// The order of the various checks in this method is very important.
        /// </summary>
        /// <returns></returns>
        public static UpgradeStatus GetUpgradeStatus()
        {
            string version = DataProviderManager.Provider.GetDatabaseVersion();

            if (string.IsNullOrEmpty(version))
                return UpgradeStatus.Install;
            else if (version.StartsWith("ERROR"))
                return UpgradeStatus.None;

            // Now check if the user is authenticated.
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated && (HttpContext.Current.User.Identity.AuthenticationType != "NTLM" || HttpContext.Current.User.Identity.AuthenticationType != "Negotiate"))
                return UpgradeStatus.Authenticated;

            // Now test for upgrade.
            return DataProviderManager.Provider.GetDatabaseVersion() != GetCurrentVersion() ? UpgradeStatus.Upgrade : UpgradeStatus.None;
        }

        /// <summary>
        /// Gets the installed version.
        /// </summary>
        /// <returns></returns>
        public static string GetInstalledVersion()
        {
            return DataProviderManager.Provider.GetDatabaseVersion();
        }

        /// <summary>
        /// Gets the BugNET version from the currently running assembly.
        /// </summary>
        /// <returns></returns>
        public static string GetCurrentVersion()
        {
            return String.Format("{0}", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version);

        }

        /// <summary>
        /// Detect if BugNET has been installed        
        /// </summary>
        /// <returns>True is BugNET is installed</returns>
        public static bool IsInstalled()
        {
            return GetUpgradeStatus() != UpgradeStatus.Install;
        }

        /// <summary>
        /// Gets the application map path.
        /// </summary>
        /// <value>The application map path.</value>
        public static string ApplicationMapPath
        {
            get
            {
                var context = HttpContext.Current;
                return context.Server.MapPath("~").EndsWith("\\") ? context.Server.MapPath("~") : context.Server.MapPath("~") + "\\";
            }
        }
    }
}
