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
//using BugNET.DataAccessLayer;
using BugNET.Entities;

namespace BugNET.Install
{
    public partial class Install : System.Web.UI.Page
    {
        private DateTime StartTime;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get current Script time-out
            int scriptTimeOut = Server.ScriptTimeout;

            string mode = string.Empty;
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
                    // carlowahlstedt's patch
                    //if (HttpContext.Current.User.Identity.AuthenticationType == "NTLM" || HttpContext.Current.User.Identity.AuthenticationType == "Negotiate")
                    //{
                    //    WindowsAuthenticationWarning();
                    //    return;
                    //}

                    switch (UpgradeManager.GetUpgradeStatus())
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
        /// Warns the user that some kind of windows authentication is turned on.
        /// </summary>
        private void WindowsAuthenticationWarning()
        {
            string tmpuser = HttpContext.Current.User.Identity.Name;
            WriteHeader("authentication");
            WriteMessage(string.Format("<h3>You are logged in as user '{0}' using some kind of windows authentication.</h3>", tmpuser));
            WriteMessage("<h3>This installer does not support Windows or Active Directory Authentication</h3>");
            WriteMessage("<h3>You must disable these settings to continue.</h3>");            
            WriteFooter();
        }

        /// <summary>
        /// Logs the user out with a suitable error message.
        /// </summary>
        private void InstallerLogout()
        {
            string tmpuser = HttpContext.Current.User.Identity.Name;
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
            string installationDate = WebConfigurationManager.AppSettings["InstallationDate"];

            if (installationDate == null || installationDate == "")
            {

                //update machine key.
                string error = UpgradeManager.UpdateMachineKey();

                if (error == "")
                {
                    Response.Redirect(HttpContext.Current.Request.RawUrl, true);
                }
                else
                {
                    StreamReader oStreamReader = new StreamReader(HttpContext.Current.Server.MapPath("~/Install/403-3.htm"));
                    string strHTML = oStreamReader.ReadToEnd();
                    oStreamReader.Close();
                    strHTML = strHTML.Replace("[MESSAGE]", error);
                    HttpContext.Current.Response.Write(strHTML);
                    HttpContext.Current.Response.End();
                }
            }
            else 
            {              
                StartTime = DateTime.Now;
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
        /// Installs the bug NET.
        /// </summary>
        /// <returns></returns>
        private bool InstallBugNET()
        {
            try
            {
                string providerPath = UpgradeManager.GetProviderPath();           

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
                    MembershipCreateStatus status = MembershipCreateStatus.Success;
                    MembershipUser NewUser = Membership.CreateUser("Admin", "password", "admin@yourdomain.com", "no question", "no answer", true, out status);
                    if (NewUser != null)
                    {
                        //add the admin user to the Super Users role.
                        RoleManager.AddUser("Admin", 1);
                        //add user profile information
                        WebProfile Profile = new WebProfile().GetProfile("Admin");
                        Profile.FirstName = "Admin";
                        Profile.LastName = "Admin";
                        Profile.DisplayName = "Administrator";
                        Profile.Save();
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

            if (installationDate == null || installationDate == string.Empty)
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
                StartTime = DateTime.Now;
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
                  string providerPath = UpgradeManager.GetProviderPath();

                  if (!providerPath.StartsWith("ERROR"))
                  {
                      //get current App version
                      int AssemblyVersion = Convert.ToInt32(UpgradeManager.GetCurrentVersion().Replace(".", ""));
                      int DatabaseVersion = Convert.ToInt32(UpgradeManager.GetInstalledVersion().Replace(".", ""));
                      //get list of script files
                      string strScriptVersion;
                      ArrayList arrScriptFiles = new ArrayList();

                      //install the membership provider and migrate the users if the 
                      //installed version is less than 0.7
                      if (DatabaseVersion < 70)
                      {
                          WriteMessage("Installing Membership Provider:<br/>", 0, true);
                          ExecuteSqlInFile(string.Format("{0}InstallCommon.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallMembership.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallProfile.sql",providerPath));
                          ExecuteSqlInFile(string.Format("{0}InstallRoles.sql",providerPath));
                          WriteMessage("Migrating Users", 0, true);
                          UpgradeManager.MigrateUsers();
                      }

                      string[] arrFiles = Directory.GetFiles(providerPath, "*.sql");
                      foreach (string File in arrFiles)
                      {
                          //ignore default scripts
                          if (Path.GetFileNameWithoutExtension(File).StartsWith("Install") || Path.GetFileNameWithoutExtension(File).StartsWith("BugNet")
                              || Path.GetFileNameWithoutExtension(File).StartsWith("Latest"))
                          { }
                          else
                          {
                              strScriptVersion = Path.GetFileNameWithoutExtension(File).Substring(0, Path.GetFileNameWithoutExtension(File).LastIndexOf("."));
                              int ScriptVersion = Convert.ToInt32(strScriptVersion.Replace(".", ""));
                              //check if script file is relevant for upgrade
                              if (ScriptVersion > DatabaseVersion && ScriptVersion <= AssemblyVersion)
                              {
                                  arrScriptFiles.Add(File);
                              }
                          }
                      }
                      arrScriptFiles.Sort();

                      foreach (string strScriptFile in arrScriptFiles)
                      {
                          strScriptVersion = Path.GetFileNameWithoutExtension(strScriptFile);
                          //verify script has not already been run
                          if (DatabaseVersion != AssemblyVersion)
                          {
                              //execute script file (and version upgrades) for version
                              ExecuteSqlInFile(strScriptFile);
                          }
                      }

                      //check if the admin user is in the super users role.
                      bool found = false;
                      List<Role> roles = RoleManager.GetForUser("Admin");
                      if (roles.Count > 0)
                      {
                          Role role = roles.SingleOrDefault(r => r.Name == Globals.SUPER_USER_ROLE);
                          if (role != null)
                              found = true;
                      }
                      if (!found)
                          RoleManager.AddUser("Admin", 1);

                      UpgradeManager.UpdateDatabaseVersion(UpgradeManager.GetCurrentVersion());
                      return true;
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
        }
        #endregion

        #region Script Functions
        /// <summary>
        /// Executes the SQL in file.
        /// </summary>
        /// <param name="pathToScriptFile">The path to script file.</param>
        /// <returns></returns>
        private bool ExecuteSqlInFile(string pathToScriptFile)
        {
            WriteMessage(string.Format("Executing Script: {0}", pathToScriptFile.Substring(pathToScriptFile.LastIndexOf("\\") + 1)), 2, true);
         
            try
            {
                StreamReader _reader = null;
                string sql = string.Empty;
                List<string> statements = new List<string>();

                if (false == System.IO.File.Exists(pathToScriptFile))
                {
                    throw new Exception(string.Format("File {0} does not exist!", pathToScriptFile));
                }
                using (Stream stream = System.IO.File.OpenRead(pathToScriptFile))
                {
                    _reader = new StreamReader(stream);
                    string statement = string.Empty;
                    while ((statement = ReadNextStatementFromStream(_reader)) != null)
                    {
                        statements.Add(statement);
                    }
                    _reader.Close();
                }

                UpgradeManager.ExecuteStatements(statements);

                WriteScriptSuccessError(true);
                return true;
            }
            catch (Exception ex)
            {
                WriteScriptSuccessError(false);
                WriteScriptErrorMessage(pathToScriptFile.Substring(pathToScriptFile.LastIndexOf("\\") + 1), ex.Message);
                return false;
            }
                
        }

        /// <summary>
        /// Reads the next statement from stream.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns></returns>
        private static string ReadNextStatementFromStream(StreamReader reader)
        {         
            StringBuilder sb = new StringBuilder();
            string lineOfText;

            while (true)
            {
                lineOfText = reader.ReadLine();
                if (lineOfText == null)
                {
                    if (sb.Length > 0)
                        return sb.ToString();
                    else
                        return null;
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
            if (File.Exists(System.Web.HttpContext.Current.Server.MapPath("~/Install/Install.htm")))
            {
                StreamReader oStreamReader;
                oStreamReader = File.OpenText(System.Web.HttpContext.Current.Server.MapPath("~/Install/Install.htm"));
                string sHtml = oStreamReader.ReadToEnd();
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
        private void WriteMessage(string message)
        {
            WriteMessage(message, 0, false);
        }

        /// <summary>
        /// Writes the message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="showTime">if set to <c>true</c> [show time].</param>
        private void WriteMessage(string message, int indent, bool showTime)
        {
            string spacer = string.Empty;
            for (int i = 0; i < indent; i++)
                spacer += "&nbsp;";

            if (showTime)
                message = string.Format("{1} - {2} {0} ", message, DateTime.Now.Subtract(StartTime), spacer);

            HttpContext.Current.Response.Write(message);
            HttpContext.Current.Response.Flush();
        }

        /// <summary>
        /// Writes the success error message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="success">if set to <c>true</c> [success].</param>
        private void WriteScriptSuccessError(bool success)
        {
            if (success)
            {
                WriteMessage("<font color='green'>Success</font><br/>");
            }
            else
            {
                WriteMessage("<font color='red'>Error!</font><br/>");
            }
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
            HttpContext.Current.Response.Write("<tr><td>Error&nbsp;&nbsp;</td><td>" + message + "</td></tr>");
            HttpContext.Current.Response.Write("</table>");
            HttpContext.Current.Response.Write("<br><br>");
            HttpContext.Current.Response.Flush();

        }
        #endregion 
    }
}