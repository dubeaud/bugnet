using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using BugNET.SubversionHooks.Properties;
using BugNET.SubversionHooks.WebServices;

namespace BugNET.SubversionHooks
{
    /// <summary>
    /// 
    /// </summary>
    public class IssueTrackerIntegration
    {
        log4net.ILog logger = log4net.LogManager.GetLogger("IssueTrackerIntegration");
        /// <summary>
        /// Updates the issue tracker from revision.
        /// </summary>
        /// <param name="repository">The repository.</param>
        /// <param name="revision">The revision.</param>
        public void UpdateIssueTrackerFromRevision(string repository, string revision)
        {
            string svnlook = String.IsNullOrEmpty(Settings.Default.SubversionBinDirectory) ? 
                "svnlook" : Path.Combine(Settings.Default.SubversionBinDirectory, "svnlook.exe");

            var issueIds = new List<int>();
            logger.Info("Running svnlook...");
            string infoOutput = CommandExecutor.RunCommand(svnlook, string.Format("info -r {0} \"{1}\"", revision, repository));
            
            logger.DebugFormat("svnlook output: {0}", infoOutput);        
            logger.DebugFormat("Looking for search pattern in revision:{0} and repository:{1}...", revision, repository);

            var lines = infoOutput.Split(new char[] { '\n' }, 5);
            string command = lines[0];
            string author = lines[1];
            string dateTime = lines[2];
            string logSize = lines[3];
            string logMessage = lines[4];

            // get all the matching issue id's
            Regex RegexObj = new Regex(Settings.Default.IssueIdRegEx.ToString());
            Match MatchResults = RegexObj.Match(logMessage);

            logger.InfoFormat("Found {0} matches...",MatchResults.Groups.Count);

            while (MatchResults.Success)
            {
                try
                {
                    issueIds.Add(int.Parse(MatchResults.Groups[1].Value.Substring(MatchResults.Groups[1].Value.IndexOf("-") + 1)));
                }
                catch (Exception ex)
                {
                    logger.ErrorFormat("An error occurred parsing the issue id: {0} \n\n {1}", ex.Message, ex.StackTrace);
                }
                finally
                {
                    MatchResults = MatchResults.NextMatch();
                }
            }

            if (issueIds.Count > 0)
            {             

                BugNetServices services = new BugNetServices();
                services.CookieContainer = new System.Net.CookieContainer();
                services.Url = Settings.Default.BugNetServicesUrl;
                if (Convert.ToBoolean(Settings.Default.BugNetWindowsAuthentication))
                    services.UseDefaultCredentials = true;

                try
                {
                    logger.Info("Logging in to BugNET webservices...");
                    if (Convert.ToBoolean(Settings.Default.BugNetWindowsAuthentication))
                    {
                        services.UseDefaultCredentials = true;
                    }
                    else
                    {
                        logger.Info("Logging in to BugNET webservices...");
                        bool result = services.LogIn(Settings.Default.BugNetUsername, Settings.Default.BugNetPassword);
                        if (result)
                        {
                            logger.Info("Login successful...");
                        }
                        else
                        {
                            throw new UnauthorizedAccessException("Unauthorized access exception, please check the user name and password settings.");
                        }
                    }

                    foreach (var id in issueIds)
                    {
                        try
                        {
                            logger.Info("Creating new issue revision...");
                            logger.DebugFormat("\n Revision:{0} Id:{1} Repository:{2} Author:{3} DateTime:{4} LogMessage:{5}", revision, id, GetRepositoryName(repository), author, dateTime, Regex.Replace(logMessage, Settings.Default.IssueIdRegEx.ToString(), "<a href=\"IssueDetail.aspx?id=$2#top\"><b>$1</b></a>"));

                            bool success = services.CreateNewIssueRevision(
                                int.Parse(revision), 
                                id, 
                                GetRepositoryName(repository), 
                                author, 
                                dateTime, 
                                Regex.Replace(logMessage, Settings.Default.IssueIdRegEx.ToString(), "<a href=\"IssueDetail.aspx?id=$2#top\"><b>$1</b></a>"),
                                revision,
                                "");

                            if (success)
                                logger.Info("Successfully added new issue revision...");
                            else
                                logger.Warn("Adding new issue revision failed!");
                        }
                        catch(Exception ex)
                        {
                            logger.ErrorFormat("An error occurred adding a new issue revision to BugNET: {0} \n\n {1}", ex.Message, ex.StackTrace);
                        }

                    }
                }
                catch(UnauthorizedAccessException ex)
                {
                    logger.ErrorFormat("{0} \n\n {1}", ex.Message, ex.StackTrace);
                }
                catch(Exception ex)
                {
                    logger.FatalFormat("An error occurred contacting the BugNET web services: {0} \n\n {1}", ex.Message, ex.StackTrace);
                    System.Environment.Exit(1);
                }              
                
                
            }//if

        }

        /// <summary>
        /// Gets the name of the repository from the directory name repository.
        /// </summary>
        /// <param name="repositoryPath">The repository path.</param>
        /// <returns></returns>
        public static string GetRepositoryName(string repositoryPath)
        {
            try
            {
                DirectoryInfo di = new DirectoryInfo(repositoryPath);
                return di.Name;
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}
