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
using System.Xml;
using System.Globalization;

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
        /// Backups the config.
        /// </summary>
        public static void BackupConfig()
        {
            var context = HttpContext.Current;
            var backupFolder = Globals.CONFIG_FOLDER + "Backup_" + DateTime.Now.ToString("yyyymmddhhmm") + "\\";

            if (!(Directory.Exists(context.Server.MapPath("~") + backupFolder)))
            {
                Directory.CreateDirectory(context.Server.MapPath("~") + backupFolder);
            }

            if (File.Exists(context.Server.MapPath("~") + "\\web.config"))
            {
                File.Copy(context.Server.MapPath("~") + "\\web.config", context.Server.MapPath("~") + backupFolder + "web_old.config", true);
            }
        }

        /// <summary>
        /// Updates the machine key.
        /// </summary>
        /// <returns></returns>
        public static string UpdateMachineKey()
        {
            XmlElement xmlElement;
            var config = new XmlDocument();
            var strError = "";

            try
            {
                BackupConfig();

                config = LoadConfig();

                XmlNode xmlMachineKey = config.SelectSingleNode("configuration/system.web/machineKey");
                if(xmlMachineKey != null)
                {
                
                    xmlMachineKey.Attributes["validationKey"].Value = GenRandomValues(128);
                    xmlMachineKey.Attributes["decryptionKey"].Value =  GenRandomValues(64);
                }
  
                XmlNode AppSettings = config.SelectSingleNode("//appSettings");
                if(AppSettings != null)
                {
                    //create a new element for installation date parameter
                    xmlElement = config.CreateElement("add");
                    xmlElement.SetAttribute("key", "InstallationDate");
                    xmlElement.SetAttribute("value", DateTime.Today.ToString("d", new CultureInfo("en-US")));
                    AppSettings.AppendChild(xmlElement);
                }
                
                SaveConfig(config);

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

        #region Load & Save Config
         /// <summary>
        /// Loads the config.
        /// </summary>
        /// <returns></returns>
        public static XmlDocument LoadConfig()
        {
            //open the config file
            var xmlDoc = new XmlDocument();
            xmlDoc.Load(ApplicationMapPath + "web.config");

            if (!String.IsNullOrEmpty(xmlDoc.DocumentElement.GetAttribute("xmlns")))
            {
                //remove namespace
                string strDoc = xmlDoc.InnerXml.Replace("xmlns=\"http://schemas.microsoft.com/.NetConfiguration/v2.0\"", "");
                xmlDoc.LoadXml(strDoc);
            }
            return xmlDoc;
        }

        /// <summary>
        /// Saves the config.
        /// </summary>
        /// <param name="xmlDoc">The XML doc.</param>
        /// <returns></returns>
        public static string SaveConfig(XmlDocument xmlDoc)
        {
            try
            {
                string strFilePath = ApplicationMapPath + "web.config";
                FileAttributes objFileAttributes = FileAttributes.Normal;
                if (File.Exists(strFilePath))
                {
					//save current file attributes
                    objFileAttributes = File.GetAttributes(strFilePath);
                    //change to normal ( in case it is flagged as read-only )
                    File.SetAttributes(strFilePath, FileAttributes.Normal);
                }
                //save the config file
                var writer = new XmlTextWriter(strFilePath, null) { Formatting = Formatting.Indented };
                xmlDoc.WriteTo(writer);
                writer.Flush();
                writer.Close();
                //reset file attributes
                File.SetAttributes(strFilePath, objFileAttributes);
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
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
                return context.Server.MapPath("~");
            }
        }
    #endregion

       

    }
}
