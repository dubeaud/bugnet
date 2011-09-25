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
        /// <param name="issueWorkReportToSave">The issue work report to save.</param>
        /// <returns></returns>
        public static bool SaveIssueWorkReport(IssueWorkReport issueWorkReportToSave)
        {
            if (issueWorkReportToSave.Id <= Globals.NEW_ID)
            {
                if (!String.IsNullOrEmpty(issueWorkReportToSave.CommentText))
                    issueWorkReportToSave.CommentId = DataProviderManager.Provider.CreateNewIssueComment(new IssueComment(issueWorkReportToSave.IssueId, issueWorkReportToSave.CommentText, issueWorkReportToSave.CreatorUserName));

                var tempId = DataProviderManager.Provider.CreateNewIssueWorkReport(issueWorkReportToSave);
                if (tempId > Globals.NEW_ID)
                {
                    issueWorkReportToSave.Id = tempId;
                    return true;
                }

                return false;
            }

            return false;
        }

        /// <summary>
        /// Gets all WorkReports for an issue
        /// </summary>
        /// <param name="bugId"></param>
        /// <returns>List of WorkReport Objects</returns>
        public static List<IssueWorkReport> GetWorkReportsByIssueId(int bugId)
        {
            return DataProviderManager.Provider.GetIssueWorkReportsByIssueId(bugId);
        }

        /// <summary>
        /// Deletes the time entry.
        /// </summary>
        /// <param name="issueWorkReportId">The time entry id.</param>
        /// <returns></returns>
        public static bool DeleteIssueWorkReport(int issueWorkReportId)
        {
            if (issueWorkReportId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("issueWorkReportId"));

            return (DataProviderManager.Provider.DeleteIssueWorkReport(issueWorkReportId));
        }
        #endregion
    }
}
