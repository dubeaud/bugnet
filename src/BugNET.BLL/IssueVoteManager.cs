using System;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class IssueVoteManager
    {
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="issueVoteToSave">The issue vote to save.</param>
        /// <returns></returns>
        public static bool SaveIssueVote(IssueVote issueVoteToSave)
        {
            int TempId = DataProviderManager.Provider.CreateNewIssueVote(issueVoteToSave);
            if (TempId > 0)
            {
                issueVoteToSave.Id = TempId;
                return true;
            }
            else
                return false;
        }


        /// <summary>
        /// Determines whether [has user voted] [the specified issue id].
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="username">The username.</param>
        /// <returns>
        /// 	<c>true</c> if [has user voted] [the specified issue id]; otherwise, <c>false</c>.
        /// </returns>
        public static bool HasUserVoted(int issueId, string username)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException("username");

            return DataProviderManager.Provider.HasUserVoted(issueId, username);
        }
    }
}
