using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueWorkReportManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The issue work report to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueWorkReport entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.IssueId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save issue work report, the issue id is invalid"));

            if (!string.IsNullOrEmpty(entity.CommentText))
                entity.CommentId = DataProviderManager.Provider.CreateNewIssueComment(
                    new IssueComment
                    {
                        IssueId = entity.IssueId,
                        Comment = entity.CommentText,
                        CreatorUserName = entity.CreatorUserName,
                        DateCreated = DateTime.Now
                    });

            var tempId = DataProviderManager.Provider.CreateNewIssueWorkReport(entity);

            if (tempId > Globals.NEW_ID)
            {
                entity.Id = tempId;
                return true;
            }

            return false;
        }

        /// <summary>
        /// Gets all WorkReports for an issue
        /// </summary>
        /// <param name="issueId"></param>
        /// <returns>List of WorkReport Objects</returns>
        public static List<IssueWorkReport> GetByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueWorkReportsByIssueId(issueId);
        }

        /// <summary>
        /// Deletes the time entry.
        /// </summary>
        /// <param name="issueWorkReportId">The time entry id.</param>
        /// <returns></returns>
        public static bool Delete(int issueWorkReportId)
        {
            if (issueWorkReportId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueWorkReportId"));

            return (DataProviderManager.Provider.DeleteIssueWorkReport(issueWorkReportId));
        }
        #endregion
    }
}
