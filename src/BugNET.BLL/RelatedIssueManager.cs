using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class RelatedIssueManager
    {

        #region Static Methods

        /// <summary>
        /// Gets the child bugs.
        /// </summary>
        /// <param name="issueId">The bug id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetChildIssues(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetChildIssues(issueId);
        }

        /// <Summary>
        /// Gets the related bugs by bug id.
        /// </Summary>
        /// <param name="issueId">The bug id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetRelatedIssues(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetRelatedIssues(issueId);
        }

        /// <Summary>
        /// Gets the parent bugs.
        /// </Summary>
        /// <param name="issueId">The bug id.</param>
        /// <returns></returns>
        public static List<RelatedIssue> GetParentIssues(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetParentIssues(issueId);
        }

        /// <Summary>
        /// Deletes the related bug.
        /// </Summary>
        /// <param name="issueId">The bug id.</param>
        /// <param name="linkedIssueId">The linked bug id.</param>
        /// <returns></returns>
        public static bool DeleteRelatedIssue(int issueId, int linkedIssueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));
            if (linkedIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("linkedIssueId"));

            return DataProviderManager.Provider.DeleteRelatedIssue(issueId, linkedIssueId);
        }

        /// <Summary>
        /// Creates the new related bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static int CreateNewRelatedIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId)
                return 0;

            if (primaryIssueId <= 0)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= 0)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));


            return DataProviderManager.Provider.CreateNewRelatedIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Creates the new parent bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static int CreateNewParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId)
                return 0;

            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewParentIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Deletes the child bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static bool DeleteChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.DeleteChildIssue(primaryIssueId, secondaryIssueId);
        }


        /// <Summary>
        /// Creates the new child bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static int CreateNewChildIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId == secondaryIssueId)
                return 0;

            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));

            return DataProviderManager.Provider.CreateNewChildIssue(primaryIssueId, secondaryIssueId);
        }

        /// <Summary>
        /// Deletes the parent bug.
        /// </Summary>
        /// <param name="primaryIssueId">The primary bug id.</param>
        /// <param name="secondaryIssueId">The secondary bug id.</param>
        /// <returns></returns>
        public static bool DeleteParentIssue(int primaryIssueId, int secondaryIssueId)
        {
            if (primaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("primaryIssueId"));

            if (secondaryIssueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("secondaryIssueId"));
            return DataProviderManager.Provider.DeleteParentIssue(primaryIssueId, secondaryIssueId);
        }


        #endregion
    }
}
