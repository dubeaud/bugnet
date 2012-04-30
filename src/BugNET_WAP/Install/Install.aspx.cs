using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Common;
using log4net;

namespace BugNET.Install
{
    public partial class Install : System.Web.UI.Page
    {
        private DateTime _startTime;

        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get current Script time-out
            var scriptTimeOut = Server.ScriptTimeout;

            var mode = string.Empty;

            if (Request.QueryString["mode"] != null)
            {
                mode = Request.QueryString["mode"].ToLower();
            }

            //Disable Client side caching
            Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);

            //Check mode is not Nothing
            if (mode == "none")
            {
                NoUpgrade();
            }
            else
            {
                //Set Script timeout to MAX value
                Server.ScriptTimeout = int.MaxValue;
                try
                {
                    var status = UpgradeManager.GetUpgradeStatus();

                    switch (status)
                    {
                        case Globals.UpgradeStatus.Install:
                            InstallApplication();
                            break;
                        case Globals.UpgradeStatus.Upgrade:
                            UpgradeApplication();
                            break;
                        case Globals.UpgradeStatus.None:
                            NoUpgrade();
                            break;
                        case Globals.UpgradeStatus.Authenticated:
                            InstallerLogout();
                            break;
                        default:
                            Log.Info(string.Format("The current status [{0}] was not handled during the install process.", status));
                            break;
                    }
                }
                finally
                {
                    //restore Script timeout
                    Server.ScriptTimeout = scriptTimeOut;
                }
            }
        }

        /// <summary>
        /// Logs the user out with a suitable error message.
        /// </summary>
        private void InstallerLogout()
        {
            var tmpuser = HttpContext.Current.User.Identity.Name;

            // Sign out before writing the headers!
            FormsAuthentication.SignOut();

            WriteHeader("logout");            
            WriteMessage(string.Format("<h3>You were logged in as user '{0}'</h3>", tmpuser));
            WriteMessage("<h3>You have been logged out of the system automatically.</h3>");
            WriteMessage("<br/><h2><a href='../Install/Install.aspx'>Click Here to retry the installation.</a></h2>");
            WriteFooter();
        }


        /// <summary>
        /// Displayed information if no upgrade is necessary
        /// </summary>
        private void NoUpgrade()
        {
            WriteHeader("none");
            WriteMessage(string.Format("<h2>Current Database Version: {0}</h2>", UpgradeManager.GetInstalledVersion()));
            WriteMessage(string.Format("<h2>Current Assembly Version: {0}</h2>", UpgradeManager.GetCurrentVersion()));
            WriteMessage("<h2>No Upgrade needed.</h2>");
            WriteMessage("<br/><br/><h2><a href='../Default.aspx'>Click Here To Access Your BugNET Installation</a></h2>");
            WriteFooter();
        }

        #region Install
        
        /// <summary>
        /// Installs the application.
        /// </summary>
        /// <returns></returns>
        private void InstallApplication()
        {
            var installationDate = WebConfigurationManager.AppSettings["InstallationDate"];

            if (string.IsNullOrEmpty(installationDate))
            {

                //update machine key.
                var error = UpgradeManager.UpdateMachineKey();

                if (error == "")
                {
                    Response.Redirect(HttpContext.Current.Request.RawUrl, true);
                }
                else
                {
                    var oStreamReader = new StreamReader(HttpContext.Current.Server.MapPath("~/Install/403-3.htm"));
                    var strHtml = oStreamReader.ReadToEnd();
                    oStreamReader.Close();
                    strHtml = strHtml.Replace("[MESSAGE]", error);
                    HttpContext.Current.Response.Write(strHtml);
                    HttpContext.Current.Response.End();
                }
            }
            else 
            {              
                _startTime = DateTime.Now;
                WriteHeader("install");
              

                WriteMessage(string.Format("<h2>Version: {0}</h2>", UpgradeManager.GetCurrentVersion()));
                WriteMessage(string.Empty);
                WriteMessage("<h2>Installation Status Report</h2>");
                if (!InstallBugNET())
                {
                    WriteMessage("<h2>Installation Failed!</h2>");
                }
                else
                {
                    WriteMessage("<h2>Installation Complete</h2>");
                    WriteMessage("<br/><br/><h2><a href='../Default.aspx'>Click Here To Access Your BugNET Installation</a></h2><br/><br/>");
                }
               
                Response.Flush();
               
            }
            WriteFooter();

        }

        /// <summary>
        /// Installs the BugNET.
        /// </summary>
        /// <returns></returns>
        private bool InstallBugNET()
        {
            try
            {
                var providerPath = UpgradeManager.GetProviderPath();           

                if (!providerPath.StartsWith("ERROR"))
                {
                    WriteMessage(string.Format("Installing Version: {0}<br/>", UpgradeManager.GetCurrentVersion()), 0, true);
                    WriteMessage("Installing Membership Provider:<br/>", 0, true);
                    ExecuteSqlInFile(string.Format("{0}InstallCommon.sql",providerPath));
                    ExecuteSqlInFile(string.Format("{0}InstallMembership.sql",providerPath));
                    ExecuteSqlInFile(string.Format("{0}InstallProfile.sql",providerPath));
                    ExecuteSqlInFile(string.Format("{0}InstallRoles.sql",providerPath));
                    WriteMessage("Installing BugNET Database:<br/>", 0, true);
                    ExecuteSqlInFile(string.Format("{0}BugNET.Schema.SqlDataProvider.sql",providerPath));
                    WriteMessage("Installing BugNET Default Data:<br/>", 0, true);
                    ExecuteSqlInFile(string.Format("{0}BugNET.Data.SqlDataProvider.sql",providerPath));
                    WriteMessage("Creating Administrator Account", 0, true);
                    //create admin user
                    MembershipCreateStatus status;
                    var newUser = Membership.CreateUser("Admin", "password", "admin@yourdomain.com", "no question", "no answer", true, out status);
                    if (newUser != null)
                    {
                        //add the admin user to the Super Users role.
                        RoleManager.AddUser("Admin", 1);
                        //add user profile information
                        var profile = new WebProfile().GetProfile("Admin");
                        profile.FirstName = "Admin";
                        profile.LastName = "Admin";
                        profile.DisplayName = "Administrator";
                        profile.Save();
                    }
                    WriteScriptSuccessError(true);
                    UpgradeManager.UpdateDatabaseVersion(UpgradeManager.GetCurrentVersion());
                }
                else
                {
                    //upgrade error
                    Response.Write("<h2>Upgrade Error: " + providerPath + "</h2>");
                    return false;
                }
            }
            catch (Exception e)
            {
                WriteErrorMessage(e.Message);
                return false;
            }
            return true;
        }
        #endregion

        #region Upgrade

        /// <summary>
        /// Upgrades the application.
        /// </summary>
        private void UpgradeApplication()
        {
            string installationDate = WebConfigurationManager.AppSettings["InstallationDate"];

            if (string.IsNullOrEmpty(installationDate))
            {
                WriteMessage("<h2>Performing security updates...</h2>");
                try
                {
                    UpgradeManager.UpdateMachineKey();
                    Response.Redirect(HttpContext.Current.Request.RawUrl, true);
                }
                catch (Exception ex)
                {
                    WriteErrorMessage(string.Format("Failed Upgrading MachineKey: {0}", ex.Message));
                }
            }
            else
            {
                _startTime = DateTime.Now;
                WriteHeader("upgrade");
                WriteMessage("<h2>Upgrade Status Report</h2>");
                WriteMessage(string.Format("<h2>Current Assembly Version: {0}</h2>", UpgradeManager.GetCurrentVersion()));
                WriteMessage(string.Format("<h2>Current Database Version: {0}</h2>", UpgradeManager.GetInstalledVersion()));
                WriteMessage(string.Format("Upgrading To Version: {0}<br/>", UpgradeManager.GetCurrentVersion()), 0, true);
                if (UpgradeBugNET())
                {
                    WriteMessage("<h2>Upgrade Complete</h2>");
                    WriteMessage("<br><br><h2><a href='../Default.aspx'>Click Here To Access Your BugNET Installation</a></h2><br><br>");
                }
                else
                {
                    WriteMessage("<h2>Upgrade Failed!</h2>");
                }
                
                WriteFooter();
            }
        }

        /// <summary>
        /// Upgrades the application.
        /// </summary>
        private bool UpgradeBugNET()
        {
            try
            {
                  var providerPath = UpgradeManager.GetProviderPath();

                  if (!providerPath.StartsWith("ERROR"))
                  {
                      //get current App version
                      var assemblyVersion = Convert.ToInt32(UpgradeManager.GetCurrentVersion().Replace(".", ""));
                      var databaseVersion = Convert.ToInt32(UpgradeManager.GetInstalledVersion().Replace(".", ""));

                      //get list of script files
                      var arrScriptFiles = new ArrayList();

                      //install the membership provider and migrate the users if the 
                      //installed version is less than 0.7
                      if (databaseVersion < 70)
                      {
                          WriteMessage("Installing Membership Provider:<br/>", 0, true);
                          ExecuteSqlInFile(string.Format("{0}InstallCommon.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallMembership.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallProfile.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallRoles.sql",providerPath));
                          WriteMessage("Migrating Users", 0, true);
                          UpgradeManager.MigrateUsers();
                      }

                      var arrFiles = Directory.GetFiles(providerPath, "*.sql");

                      foreach (var file in arrFiles)
                      {
                          var fileName = Path.GetFileNameWithoutExtension(file);

                          if (string.IsNullOrEmpty(fileName)) continue;

                          fileName = fileName.ToLower().Trim();
                          if (fileName.Length.Equals(0)) continue;
                          if (fileName.StartsWith("install")) continue;
                          if (fileName.StartsWith("bugnet")) continue;
                          if (fileName.StartsWith("latest")) continue;

                          var strScriptVersion = fileName.Substring(0, fileName.LastIndexOf("."));
                          var scriptVersion = Convert.ToInt32(strScriptVersion.Replace(".", ""));

                          //check if script file is relevant for upgrade
                          if (scriptVersion > databaseVersion && scriptVersion <= assemblyVersion)
                          {
                              arrScriptFiles.Add(file);
                          }
                      }

                      arrScriptFiles.Sort();

                      foreach (var scriptFile in arrScriptFiles.Cast<string>().Where(strScriptFile => databaseVersion != assemblyVersion))
                      {
                          //execute script file (and version upgrades) for version
                          ExecuteSqlInFile(scriptFile);
                      }

                      //check if the admin user is in the super users role.
                      var found = false;
                      var roles = RoleManager.GetForUser("Admin");
                      if (roles.Count > 0)
                      {
                          var role = roles.SingleOrDefault(r => r.Name == Globals.SUPER_USER_ROLE);
                          if (role != null) found = true;
                      }
                      if (!found)
                          RoleManager.AddUser("Admin", 1);

                      UpgradeManager.UpdateDatabaseVersion(UpgradeManager.GetCurrentVersion());
                      return true;
                  }

                //upgrade error
                Response.Write("<h2>Upgrade Error: " + providerPath + "</h2>");
                return false;
            }
            catch (Exception e)
            {
                WriteErrorMessage(e.Message);
                return false;
            }
        }
        #endregion

        #region Script Functions

        /// <summary>
        /// Executes the SQL in file.
        /// </summary>
        /// <param name="pathToScriptFile">The path to script file.</param>
        /// <returns></returns>
        private void ExecuteSqlInFile(string pathToScriptFile)
        {
            WriteMessage(string.Format("Executing Script: {0}", pathToScriptFile.Substring(pathToScriptFile.LastIndexOf("\\") + 1)), 2, true);
         
            try
            {
                var statements = new List<string>();

                if (false == File.Exists(pathToScriptFile))
                {
                    throw new Exception(string.Format("File {0} does not exist!", pathToScriptFile));
                }

                using (Stream stream = File.OpenRead(pathToScriptFile))
                {
                    using(var reader = new StreamReader(stream))
                    {
                        string statement;
                        while ((statement = ReadNextStatementFromStream(reader)) != null)
                        {
                            statements.Add(statement);
                        }                        
                    }
                }

                UpgradeManager.ExecuteStatements(statements);

                WriteScriptSuccessError(true);
            }
            catch (Exception ex)
            {
                WriteScriptSuccessError(false);
                WriteScriptErrorMessage(pathToScriptFile.Substring(pathToScriptFile.LastIndexOf("\\") + 1), ex.Message);
            }  
        }

        /// <summary>
        /// Reads the next statement from stream.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns></returns>
        private static string ReadNextStatementFromStream(StreamReader reader)
        {         
            var sb = new StringBuilder();

            while (true)
            {
                var lineOfText = reader.ReadLine();
                if (lineOfText == null)
                {
                    return sb.Length > 0 ? sb.ToString() : null;
                }
                if (lineOfText.TrimEnd().ToUpper() == "GO")
                    break;

                sb.Append(lineOfText + Environment.NewLine);
            }
            return sb.ToString();           
        }
        #endregion

        #region Html Utility Functions

        /// <summary>
        /// Writes the footer.
        /// </summary>
        private void WriteFooter()
        {
            Response.Write("</body>");
            Response.Write("</html>");
            Response.Flush();
        }

        /// <summary>
        /// Writes the html header.
        /// </summary>
        /// <param name="mode">The mode.</param>
        private void WriteHeader(string mode)
        {
            //read install page and insert into response stream
            if (File.Exists(HttpContext.Current.Server.MapPath("~/Install/Install.htm")))
            {
                var oStreamReader = File.OpenText(HttpContext.Current.Server.MapPath("~/Install/Install.htm"));
                var sHtml = oStreamReader.ReadToEnd();
                oStreamReader.Close();
                Response.Write(sHtml);
            }
            switch (mode)
            {
                case "install":
                    Response.Write("<h1>Installing BugNET</h1>");
                    break;
                case "upgrade":
                    Response.Write("<h1>Upgrading BugNET</h1>");
                    break;
                case "none":
                    Response.Write("<h1>Nothing To Install At This Time</h1>");
                    break;
                case "logout":
                    Response.Write("<h1>Logged out</h1>");
                    break;
                case "authentication":
                    Response.Write("<h1>Windows Authentication Detected</h1>");
                    break;
            }
            Response.Flush();
        }

        /// <summary>
        /// Writes the error message.
        /// </summary>
        /// <param name="message">The message.</param>
        private void WriteErrorMessage(string message)
        {
            HttpContext.Current.Response.Write(string.Format("<br/><br/><font color='red'>Error: {0}</font>", message));
            HttpContext.Current.Response.Flush();
        }

        /// <summary>
        /// Writes the message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="indent">How many spaces to indent the text by</param>
        /// <param name="showTime">if set to <c>true</c> [show time].</param>
        private void WriteMessage(string message, int indent = 0, bool showTime = false)
        {
            var spacer = string.Empty;
            for (var i = 0; i < indent; i++)
                spacer += "&nbsp;";

            if (showTime)
                message = string.Format("{1} - {2} {0} ", message, DateTime.Now.Subtract(_startTime), spacer);

            HttpContext.Current.Response.Write(message);
            HttpContext.Current.Response.Flush();
        }

        /// <summary>
        /// Writes the success error message.
        /// </summary>
        /// <param name="success">if set to <c>true</c> [success].</param>
        private void WriteScriptSuccessError(bool success)
        {
            WriteMessage(success ? "<font color='green'>Success</font><br/>" : "<font color='red'>Error!</font><br/>");
        }


        /// <summary>
        /// Writes the error message.
        /// </summary>
        /// <param name="file">The file.</param>
        /// <param name="message">The message.</param>
        private void WriteScriptErrorMessage(string file, string message)
        {
            HttpContext.Current.Response.Write("<h2>Error Details</h2>");
            HttpContext.Current.Response.Write("<table style='color:red;font-size:11px' cellspacing='0' cellpadding='0' border='0'>");
            HttpContext.Current.Response.Write("<tr><td>File</td><td>" + file + "</td></tr>");
            HttpContext.Current.Response.Write(string.Format("<tr><td>Error&nbsp;&nbsp;</td><td>{0}</td></tr>", message));
            HttpContext.Current.Response.Write("</table>");
            HttpContext.Current.Response.Write("<br><br>");
            HttpContext.Current.Response.Flush();

        }
        #endregion 
    }
}