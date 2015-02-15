using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class RelatedIssueManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods

        /// <summary>
        /// Gets the child bugs.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetChildIssues(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetChildIssues(issueId);
        }

        /// <Summary>
        /// Gets the related bugs by issue id.
        /// </Summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetRelatedIssues(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetRelatedIssues(issueId);
        }

        /// <Summary>
        /// Gets the parent bugs.
        /// </Summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetParentIssues(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetParentIssues(issueId);
        }

        /// <Summary>
        /// Deletes the related issue.
        /// </Summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="linkedIssueId">The linked issue id.</param>
        /// <returns></returns>
        public static bool DeleteRelatedIssue(int issueId, int linkedIssueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));
            if (linkedIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("linkedIssueId"));

            return DataProviderManager.Provider.DeleteRelatedIssue(issueId, linkedIssueId);
        }

        /// <Summary>
        /// Creates the new related issue.
        /// </Summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public static int CreateNewRelatedIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId) return 0;
            if (primaryIssueId <= 0) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= 0) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewRelatedIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Creates the new parent issue.
        /// </Summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public static int CreateNewParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId) return 0;
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewParentIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Deletes the child issue.
        /// </Summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public static bool DeleteChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.DeleteChildIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Creates the new child issue.
        /// </Summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public static int CreateNewChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId) return 0;
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewChildIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Deletes the parent issue.
        /// </Summary>
        /// <param name="primaryIssueId">The primary issue id.</param>
        /// <param name="secondaryIssueId">The secondary issue id.</param>
        /// <returns></returns>
        public static bool DeleteParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("primaryIssueId"));
            if (secondaryIssueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.DeleteParentIssue(primaryIssueId, secondaryIssueId);
        }

        #endregion
    }
}
