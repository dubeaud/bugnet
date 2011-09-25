using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class IssueWorkReportManager
    {
        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="issueWorkReportToSave">The issue work report to save.</param>
        /// <returns></returns>
        public static bool SaveIssueWorkReport(IssueWorkReport issueWorkReportToSave)
        {
            if (issueWorkReportToSave.Id <= Globals.NewId)
            {
                if (!String.IsNullOrEmpty(issueWorkReportToSave.CommentText))
                    issueWorkReportToSave.CommentId = DataProviderManager.Provider.CreateNewIssueComment(new IssueComment(issueWorkReportToSave.IssueId, issueWorkReportToSave.CommentText, issueWorkReportToSave.CreatorUserName));

                int TempId = DataProviderManager.Provider.CreateNewIssueWorkReport(issueWorkReportToSave);
                if (TempId > Globals.NewId)
                {
                    issueWorkReportToSave.Id = TempId;
                    return true;
                }
                else
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
        /// <param name="BugTimeEntryId">The time entry id.</param>
        /// <returns></returns>
        public static bool DeleteIssueWorkReport(int issueWorkReportId)
        {
            if (issueWorkReportId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueWorkReportId"));


            return (DataProviderManager.Provider.DeleteIssueWorkReport(issueWorkReportId));
        }
        #endregion
    }
}
