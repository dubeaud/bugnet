using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using BugNET.Common;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class SourceIntegrationManager
    {
        private static readonly Dictionary<int, string> Errors = new Dictionary<int, string>();
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Creates the repository.
        /// </summary>
        /// <param name="repositoryName">Name of the repository.</param>
        /// <returns></returns>
        public static string CreateRepository(string repositoryName)
        {
            var sb = new StringBuilder();

            var repoPath = HostSettingManager.Get(HostSettingNames.RepositoryRootPath) + repositoryName;

            var repoCheckoutPath = Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData) +
                Path.DirectorySeparatorChar + Guid.NewGuid().ToString();


            var repoUrl = new Uri(repoPath).AbsoluteUri;

            if (!repoUrl.EndsWith("/"))
                repoUrl += "/";

            try
            {

                Directory.CreateDirectory(repoPath);
                Directory.CreateDirectory(repoCheckoutPath);

                
                sb.AppendLine(RunCommand("svnadmin", "create \"" + repoPath + "\""));

                sb.AppendLine(RunCommand("svn", "mkdir \"" + repoUrl + "trunk\" \"" +
                    repoUrl + "branches\" \"" + repoUrl + "tags\" \"" + repoUrl + "trunk/doc\" \"" + 
                    repoUrl + "trunk/src\" -m \"Creating initial directories\""));
                sb.AppendLine();


                sb.AppendLine(RunCommand("svn", "checkout \"" + repoUrl + "\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                // Add Issue tracker properties
                var url = HostSettingManager.Get(HostSettingNames.DefaultUrl).Trim();
                if (!url.EndsWith("/"))
                    url += "/";

                //\[?([A-Za-z]{3}-\d+)[\]:]{0,2}(\s((resolved)[,\s]+(fixed|invalid)?)|\s+(open|in progress)?)?
                //this regex locks up TortoiseSVN

                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:logregex \"\\[?([A-Za-z]{3}-\\d+)\\]?.+\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();


                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:label \"Issue Tracker Id:\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:url \"" + url + "Issues/IssueDetail.aspx?id=%BUGID%\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                //sb.AppendLine(RunCommand("svn", "propset -R bugtraq:message \"Issue Tracker Id: %BUGID%\" \"" + repoCheckoutPath + "\""));
                //sb.AppendLine();

                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:number \"false\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:warnifnoissue \"false\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                sb.AppendLine(RunCommand("svn", "propset -R bugtraq:append \"false\" \"" + repoCheckoutPath + "\""));
                sb.AppendLine();

                sb.AppendLine(RunCommand("svn", "commit -m \"Added Issue Tracker properties to the repository\" \"" + repoCheckoutPath + "\""));

                // Add post-commit for the integration.

                if (!repoPath.EndsWith(Path.DirectorySeparatorChar.ToString()))
                    repoPath += Path.DirectorySeparatorChar;

                if (!String.IsNullOrEmpty(HostSettingManager.Get(HostSettingNames.SvnHookPath)))
                {
                    using (var sw = File.CreateText(repoPath + "hooks" + Path.DirectorySeparatorChar + "post-commit.bat"))
                        sw.WriteLine(HostSettingManager.Get(HostSettingNames.SvnHookPath) + @" post-commit %1 %2");
                }

                return sb.ToString();

            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                    Log.Error("Subversion Repository Creation Error", ex); //TOOD: Localize 

                throw;
            }
            finally
            {
                DeleteDirectory(repoCheckoutPath);
            }
        }

        /// <summary>
        /// Creates a tag of the trunk by the specified name. This method assumes both trunk and tags 
        /// directories exist in the repository.
        /// </summary>
        /// <param name="projectId"></param>
        /// <param name="tagName"></param>
        /// <param name="comment"></param>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public static string CreateTag(int projectId, string tagName, string comment, string userName, string password)
        {
            Project proj = ProjectManager.GetProjectById(projectId);

            string repoUrl = proj.SvnRepositoryUrl;

            if (!repoUrl.EndsWith("/"))
                repoUrl += "/";

            try
            {
                var arguments = !string.IsNullOrEmpty(userName) 
                    ? string.Format("--non-interactive copy \"{0}trunk\" \"{0}tags/{1}\" --username {2} --password {3} -m \"{4}\"", repoUrl, tagName, userName, password, comment) 
                    : string.Format("--non-interactive copy \"{0}trunk\" \"{0}tags/{1}\" -m \"{2}\"", repoUrl, tagName, comment);

                return RunCommand("svn", arguments);
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                    Log.Error("Subversion Repository Tag Error", ex); //TOOD: Localize
              
                throw;
            }
        }

        public static bool IsValidSubversionName(string name)
        {
            return Regex.IsMatch(name, "\\A[\\w-\\.]+\\z");
        }

        /// <summary>
        /// Recursively deletes a directory even if it has read-only files.
        /// </summary>
        /// <param name="path"></param>
        private static void DeleteDirectory(string path)
        {
            var di = new DirectoryInfo(path);
            foreach (var file in di.GetFiles())
            {
                if ((File.GetAttributes(file.FullName) & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                    File.SetAttributes(file.FullName, FileAttributes.Normal);

                File.Delete(file.FullName);
            }

            foreach (var folder in di.GetDirectories())
                DeleteDirectory(folder.FullName);

            Directory.Delete(path);
        }


        /// <summary>
        /// Runs a seperate process and returns the standard outout and error text. This is intended for command line apps only.
        /// </summary>
        /// <param name="command"></param>
        /// <param name="args"></param>
        /// <param name="killAfterSeconds"></param>
        /// <returns></returns>
        private static string RunCommand(string command, string args, int killAfterSeconds = 300)
        {
            Process proc = null;

            try
            {
                var startInfo = new ProcessStartInfo(command, args)
                    {
                        CreateNoWindow = true,
                        WindowStyle = ProcessWindowStyle.Hidden,
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        RedirectStandardError = true
                    };

                proc = new Process {StartInfo = startInfo};
                proc.ErrorDataReceived += CommandProcessErrorDataReceived;
                proc.Start();

                proc.BeginErrorReadLine();

                var retVal = proc.StandardOutput.ReadToEnd();

                if (!proc.WaitForExit(killAfterSeconds * 1000))
                    proc.Kill();

                if (Errors.ContainsKey(proc.Id))
                    retVal += Environment.NewLine + "Error: " + Environment.NewLine + Errors[proc.Id];

                // hide password from being displayed
                var regexObj = new Regex("--password\\s+\\S+\\s", RegexOptions.IgnoreCase);
                args = regexObj.Replace(args, "--password **** ");

                return command + " " + args + Environment.NewLine + retVal;
                
            }
            finally
            {
                if (proc != null)
                {
                    if (Errors.ContainsKey(proc.Id))
                        Errors.Remove(proc.Id);

                    proc.Dispose();
                }
            }

        }

        /// <summary>
        /// Event handler to capture error data. At least one of the output streams has to be read asyncronously
        /// to avoid a deadlock.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static void CommandProcessErrorDataReceived(object sender, DataReceivedEventArgs e)
        {
            // RC: Sometimes an error occurres in hear. I think the process is ending while we are getting the data, but Im not sure.
            // I'm stuffing it for now.
            try
            {
                if (sender != null)
                {
                    if (!string.IsNullOrEmpty(e.Data))
                    {
                        var id = ((Process)sender).Id;

                        if (Errors.ContainsKey(id))
                            Errors[id] += Environment.NewLine + e.Data;
                        else
                            Errors.Add(id, e.Data);
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex.Message, ex);
            }
        }
    }
}
