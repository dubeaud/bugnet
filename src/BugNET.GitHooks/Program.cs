using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugNET.GitHooks
{
    class Program
    {
        /// <summary>
        /// Mains the specified args.
        /// </summary>
        /// <param name="args">The args.</param>
        static void Main(string[] args)
        {

            log4net.Config.XmlConfigurator.Configure();
            log4net.ILog logger = log4net.LogManager.GetLogger("Main");

            //Console.WriteLine(IssueTrackerIntegration.GetRepositoryName(@"F:\SVN\Repositories\MyRepo"));
            //Console.ReadLine();

            try
            {
                if (string.Compare("post-commit", args[0], true) == 0)
                {
                    logger.Info("Starting post-commit...");

                    string repository = args[1];
                    string revision = args[2];

                    logger.InfoFormat("Executing IssueTrackerIntegration.UpdateIssueTrackerFromRevision(\"{0}\", \"{1}\")", repository, revision);
                    IssueTrackerIntegration integration = new IssueTrackerIntegration();
                    integration.UpdateIssueTrackerFromRevision(repository, revision);
                    logger.Info("Finished IssueTrackerIntegration.UpdateIssueTrackerFromRevision\n");
                }
            }
            catch (Exception ex)
            {
                logger.ErrorFormat("An error occurred: {0} \n\n {1}", ex.Message, ex.StackTrace);
            }
        }
    }
}
