using System;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueVoteManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The issue vote to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueVote entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.IssueId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save issue vote, the issue id is invalid"));
            if (string.IsNullOrEmpty(entity.VoteUsername)) throw (new ArgumentException("Cannot save issue vote, the voters user name is null or empty"));

            var tempId = DataProviderManager.Provider.CreateNewIssueVote(entity);

            if (tempId <= 0) return false;

            entity.Id = tempId;
            return true;
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
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));
            if (string.IsNullOrEmpty(username)) throw new ArgumentNullException("username");

            return DataProviderManager.Provider.HasUserVoted(issueId, username);
        }
    }
}
