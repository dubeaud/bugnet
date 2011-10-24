using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Collections.Generic;
using System.Web.Security;
using BugNET.Common;
using BugNET.DAL;
using log4net;

namespace BugNET.BLL
{
    public static class UpgradeManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Executes the statements.
        /// </summary>
        /// <param name="statements">The statements.</param>
        public static void ExecuteStatements(List<string> statements)
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
        /// Migrates the users to the .NET 2.0 membership provider.
        /// </summary>   
        /// <returns>[true] if successful</returns>
        public static bool MigrateUsers()
        {
            try
            {
                using(var conn = new SqlConnection(WebConfigurationManager.ConnectionStrings[0].ConnectionString))
                {
                    using(var command = new SqlCommand("SELECT * FROM Users", conn))
                    {
                        conn.Open();

                        using(var dr = command.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                MembershipUser newUser;
                                //create new membership user 
                                if ((string)dr["UserName"] == "Admin")
                                {
                                    newUser = Membership.CreateUser((string)dr["UserName"], (string)dr["Password"], (string)dr["Email"]);
                                }
                                else
                                {
                                    var password = (string)dr["Password"];
                                    if (password.Length < 7)
                                    {
                                        password = Membership.GeneratePassword(7, 0);
                                    }
                                    newUser = Membership.CreateUser((string)dr["UserName"], password, (string)dr["Email"]);
                                }

                                if (dr["Active"].ToString() == "0")
                                {
                                    newUser.IsApproved = false;
                                }
                            }
                        }
                    }
                }

                return true;
            }
            catch (Exception ex)
            {

            }

            return false;
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
        /// Updates the machine key.
        /// </summary>
        /// <returns></returns>
        public static string UpdateMachineKey()
        {
            var context = HttpContext.Current;
            var backupFolder = Globals.CONFIG_FOLDER + "Backup_" + DateTime.Now.ToString("yyyymmddhhmm") + "\\";
            var strError = "";

            try
            {
                if (!(Directory.Exists(context.Server.MapPath("~") + backupFolder)))
                {
                    Directory.CreateDirectory(context.Server.MapPath("~") + backupFolder);
                }

                if (File.Exists(context.Server.MapPath("~") + "\\web.config"))
                {
                    File.Copy(context.Server.MapPath("~") + "\\web.config", context.Server.MapPath("~") + backupFolder + "web_old.config", true);
                }

                var config = WebConfigurationManager.OpenWebConfiguration("~");
                var webSection = (SystemWebSectionGroup)config.GetSectionGroup("system.web");

                if (webSection != null)
                {
                    webSection.MachineKey.ValidationKey = GenRandomValues(128);
                    webSection.MachineKey.DecryptionKey = GenRandomValues(64);
                }

                config.AppSettings.Settings.Add("InstallationDate", DateTime.Today.ToShortDateString());

                //save
                config.Save(ConfigurationSaveMode.Full);

            }
            catch (Exception ex)
            {
                strError += ex.Message;
            }
            return strError;
        }

        /// <summary>
        /// Gens the random values.
        /// </summary>
        /// <param name="len">The len.</param>
        /// <returns></returns>
        private static string GenRandomValues(int len)
        {
            var buff = new byte[len / 2];
            var rng = new RNGCryptoServiceProvider();
            rng.GetBytes(buff);
            var sb = new StringBuilder(len);
            foreach (var t in buff)
                sb.Append(string.Format("{0:X2}", t));

            return sb.ToString();
        }

        /// <summary>
        /// Gets the upgrade status.
        /// 
        /// The order of the various checks in this method is very important.
        /// </summary>
        /// <returns></returns>
        public static Globals.UpgradeStatus GetUpgradeStatus()
        {
            if (string.IsNullOrEmpty(DataProviderManager.Provider.GetDatabaseVersion()))
                return Globals.UpgradeStatus.Install;

            // Querying for AD and windows authentication must take precedence over            
            // upgrading.
            // We can query the database from now on, because BugNET is installed          
            //string adStatus = HostSetting.Get("UserAccountSource");
            //if (adStatus == "WindowsSAM")
            //    return Globals.UpgradeStatus.WindowsSAM;
            //if (adStatus == "ActiveDirectory")
            //    return Globals.UpgradeStatus.ActiveDirectory;

            // Now check if the user is authenticated.
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated && (HttpContext.Current.User.Identity.AuthenticationType != "NTLM" || HttpContext.Current.User.Identity.AuthenticationType != "Negotiate"))
                return Globals.UpgradeStatus.Authenticated;

            // Now test for upgrade.
            return DataProviderManager.Provider.GetDatabaseVersion() != GetCurrentVersion() ? Globals.UpgradeStatus.Upgrade : Globals.UpgradeStatus.None;
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
            return GetUpgradeStatus() != Globals.UpgradeStatus.Install;
        }
    }
}
