using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using BugNET.BusinessLogicLayer;

namespace BugNET.Install
{
    /// <summary>
    /// Upgrade helper class
    /// </summary>
    public static class Upgrade
    {
        /// <summary>
        /// Migrates the users to the .NET 2.0 membership provider.
        /// </summary>   
        /// <returns>[true] if successful</returns>
        public static bool MigrateUsers()
        {
            SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings[0].ConnectionString);
            try
            {
                SqlCommand command = new SqlCommand("SELECT * FROM Users", conn);
                conn.Open();
                SqlDataReader dr = command.ExecuteReader();
              
                while (dr.Read())
                {
                    MembershipUser NewUser;
                    //create new membership user 
                    if ((string)dr["UserName"] == "Admin")
                    {
                        NewUser = Membership.CreateUser((string)dr["UserName"], (string)dr["Password"], (string)dr["Email"]);
                    }
                    else
                    {
                        string password = (string)dr["Password"];
                        if (password.Length < 7)
                        {
                            password = Membership.GeneratePassword(7, 0);
                        }
                        NewUser = Membership.CreateUser((string)dr["UserName"], password, (string)dr["Email"]);
                    }
                 
                    if (NewUser != null)
                    {
                        if (dr["Active"].ToString() == "0")
                        {
                            NewUser.IsApproved = false;
                        }
                    }
                }
                return true;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// Upgrades the database version.
        /// </summary>
        /// <param name="version">The version.</param>
        /// <returns></returns>
        public static bool UpdateDatabaseVersion(string version)
        {
            return HostSetting.UpdateHostSetting("Version", version);
        }   

        /// <summary>
        /// Updates the machine key.
        /// </summary>
        /// <returns></returns>
        public static string UpdateMachineKey()
        {
            HttpContext context = HttpContext.Current;
            string backupFolder = Globals.ConfigFolder + "Backup_" + DateTime.Now.ToString("yyyymmddhhmm") + "\\";
            string strError = "";
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
           

                Configuration config = WebConfigurationManager.OpenWebConfiguration("~");
                SystemWebSectionGroup WebSection = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
                WebSection.MachineKey.ValidationKey = GenRandomValues(128);
                WebSection.MachineKey.DecryptionKey = GenRandomValues(64);

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
            byte[] buff = new byte[len / 2];
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetBytes(buff);
            StringBuilder sb = new StringBuilder(len);
            for (int i = 0; i < buff.Length; i++)
                sb.Append(string.Format("{0:X2}", buff[i]));

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
            if (DataProviderManager.Provider.GetDatabaseVersion() == string.Empty)
                return Globals.UpgradeStatus.Install;

            // Querying for AD and windows authentication must take precedence over            
            // upgrading.
            // We can query the database from now on, because BugNET is installed          
            //string adStatus = HostSetting.GetHostSetting("UserAccountSource");
            //if (adStatus == "WindowsSAM")
            //    return Globals.UpgradeStatus.WindowsSAM;
            //if (adStatus == "ActiveDirectory")
            //    return Globals.UpgradeStatus.ActiveDirectory;

            // Now check if the user is authenticated.
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated && (HttpContext.Current.User.Identity.AuthenticationType != "NTLM" || HttpContext.Current.User.Identity.AuthenticationType != "Negotiate"))
                return Globals.UpgradeStatus.Authenticated;

            // Now test for upgrade.
            if (DataProviderManager.Provider.GetDatabaseVersion() != Upgrade.GetCurrentVersion())
                return Globals.UpgradeStatus.Upgrade;

            return Globals.UpgradeStatus.None;
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
        /// Gets the bug net version from the currently running assembly.
        /// </summary>
        /// <returns></returns>
        public static string GetCurrentVersion()
        {
            return String.Format("{0}", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString());

        }

        /// <summary>
        /// Detect if BugNET has been installed        
        /// </summary>
        /// <returns>True is BugNET is installed</returns>
        public static bool IsInstalled()
        {
            if (Upgrade.GetUpgradeStatus() == Globals.UpgradeStatus.Install)
                return false;
   
            return true; 

        }
  
    }
}
