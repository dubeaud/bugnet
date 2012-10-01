using System;
using System.Linq;
using Mercurial;
using log4net;

namespace BugNET.MercurialChangeGroupHook
{
    class Program
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Executed by the external hook
        /// </summary>
        /// <param name="args">command line args (none)</param>
        static void Main(string[] args)
        {
            // get a reference to the hook calling the program
            var hook = new Mercurial.Hooks.MercurialChangeGroupHook();

            // configure the logger
            ConfigureLogger();

            Log.InfoFormat("MercurialChangeGroupHook: Triggered for repository [{0}]", hook.Repository);

            // get the current identity who committed the change group
            var windowsIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();

            if (windowsIdentity != null)
            {
                // log info to aide in debugging
                var user = windowsIdentity.Name;
                Log.InfoFormat("MercurialChangeGroupHook: Current user [{0}]", user);
            }

            try
            {
                // get all the change sets for the revision from the log
                var changesets =
                    hook.Repository.Log(new LogCommand()
                        .WithRevision(RevSpec.From(hook.FirstRevision)))
                        .ToArray();

                Log.InfoFormat("MercurialChangeGroupHook: Found [{0}] change sets", changesets.Length);

                // wire up the bugnet service 
                var services = new WebServices.BugNetServices
                {
                    CookieContainer = new System.Net.CookieContainer(),
                    Url = AppSettings.BugNetServicesUrl
                };

                if (Convert.ToBoolean(AppSettings.BugNetWindowsAuthentication))
                {
                    services.UseDefaultCredentials = true;
                }
                else
                {
                    Log.Info("MercurialChangeGroupHook: Logging in to BugNET Web Services");

                    var result = services.LogIn(AppSettings.BugNetUsername, AppSettings.BugNetPassword);
                    if (result)
                    {
                        Log.Info("MercurialChangeGroupHook: Login successful");
                    }
                    else
                    {
                        Log.Error("MercurialChangeGroupHook: Unauthorized access, please check the user name and password settings");
                        Environment.Exit(1);
                    }
                }

                // get the repository from the hook
                var repositoryName = IssueTrackerIntegration.GetRepositoryName(hook.Repository.ToString());

                // loop the change sets from the log
                foreach (var changeset in changesets)
                {
                    Log.InfoFormat("MercurialChangeGroupHook: Processing change set [{0}]", changeset.Hash);
                    IssueTrackerIntegration.UpdateBugNetForChangeset(repositoryName, changeset, services);
                }

                Log.Info("MercurialChangeGroupHook: Processing complete");
            }
            catch (Exception ex)
            {
                Log.FatalFormat("MercurialChangeGroupHook: An error occurred while processing: {0} \n\n {1}", ex.Message, ex.StackTrace);
                Environment.Exit(1);
            } 
        }

        static void ConfigureLogger()
        {
            if (ConfigureAdoNetAppender()) return;

            log4net.Config.XmlConfigurator.Configure();
        }

        /// <summary>
        /// Configures the ADO net appender if exists
        /// </summary>
        private static bool ConfigureAdoNetAppender()
        {
            // Get the Hierarchy object that organizes the loggers
            var hier = LogManager.GetRepository() as log4net.Repository.Hierarchy.Hierarchy;

            if (hier == null) return false;

            //get ADONetAppender
            var adoAppender = hier.Root.GetAppender("AdoNetAppender") as log4net.Appender.AdoNetAppender;

            if (adoAppender == null) return false;

            adoAppender.ActivateOptions(); //refresh settings of appender
            return true;
        }
    }
}
