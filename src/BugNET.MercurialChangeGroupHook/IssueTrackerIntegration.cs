using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Mercurial;
using log4net;

namespace BugNET.MercurialChangeGroupHook
{
    /// <summary>
    /// 
    /// </summary>
    public static class IssueTrackerIntegration
    {

        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Gets the name of the repository from the directory name repository.
        /// </summary>
        /// <param name="repositoryPath">The repository path.</param>
        /// <returns></returns>
        public static string GetRepositoryName(string repositoryPath)
        {
            // repository path will be the full file path to the repository
            // we need to get the last folder name out of the string (will be enclosed in brackets)
            try
            {
                repositoryPath = repositoryPath.Trim();
                var name = string.Empty;

                var pos = repositoryPath.LastIndexOf(@"\");
                if (pos > -1 && repositoryPath.Length > 1)
                {
                    name = repositoryPath.Substring(repositoryPath.LastIndexOf(@"\") + 1).Replace(")", "").Trim();
                }

                return name;
            }
            catch
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// Updates the issue tracker from the change set.
        /// </summary>
        /// <param name="repository"> </param>
        /// <param name="changeset"> </param>
        /// <param name="service"> </param>
        public static void UpdateBugNetForChangeset(string repository, Changeset changeset, WebServices.BugNetServices service)
        {
            var issuesAffectedList = new List<int>();
            var regEx = new Regex(AppSettings.IssueIdRegEx, RegexOptions.IgnoreCase);

            var commitMessage = changeset.CommitMessage.Trim();
            var matchResults = regEx.Match(commitMessage);

            if (!matchResults.Success) // none in the commit message
            {
                Log.Info("MercurialChangeGroupHook: Found no Issue Ids in change set");
                return;
            }

            // capture the issues ids in the commit message
            // validate if the issue id is 
            // change the commit message for each issue id (may be more to the commit)
            while (matchResults.Success)
            {
                var value = matchResults.Groups[1].Value.Trim();
                var issueIdParts = value.Split(new[] { '-' });

                if (issueIdParts.Length.Equals(2))
                {
                    var idString = issueIdParts[1];

                    int issueId;
                    if (int.TryParse(idString, out issueId))
                    {
                        if(service.ValidIssue(issueId)) // check the issue to make sure it exists
                        {
                            commitMessage = Regex.Replace(commitMessage, AppSettings.IssueIdRegEx, "<a href=\"IssueDetail.aspx?id=$2#top\"><b>$1</b></a>");
                            issuesAffectedList.Add(issueId);   
                        }
                    }
                }

                matchResults = matchResults.NextMatch();
            }

            if (issuesAffectedList.Count <= 0) return;

            var revisionNumber = changeset.RevisionNumber;
            var revision = changeset.Hash.Trim();
            var author = changeset.AuthorName.Trim();
            var dateTime = changeset.Timestamp.ToString();
            var branch = changeset.Branch.Trim();

            foreach (var id in issuesAffectedList)
            {
                try
                {
                    Log.Info("MercurialChangeGroupHook: Creating new issue revision");

                    var success = service.CreateNewIssueRevision(
                        revisionNumber,
                        id,
                        repository,
                        author,
                        dateTime,
                        commitMessage,
                        revision,
                        branch);

                    if (success)
                        Log.Info("MercurialChangeGroupHook: Successfully added new issue revision");
                    else
                        Log.Warn("MercurialChangeGroupHook: Adding new issue revision failed");
                }
                catch (Exception ex)
                {
                    Log.ErrorFormat("MercurialChangeGroupHook: An error occurred adding a new issue revision to BugNET: {0} \n\n {1}", ex.Message, ex.StackTrace);
                }
            }
        }
    }
}
