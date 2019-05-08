// -----------------------------------------------------------------------
// <copyright file="ReportManager.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using BugNET.DAL;
    using BugNET.Entities;
    using BugNET.Common;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class ReportManager
    {
        /// <summary>
        /// Milestones the burnup.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<MilestoneBurnup> MilestoneBurnup(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetMilestoneBurnupReport(projectId);
        }

        /// <summary>
        /// Milestones the burndown.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public static List<MilestoneBurndown> MilestoneBurndown(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            return DataProviderManager.Provider.GetMilestoneBurndownReport(projectId, milestoneId, startDate, endDate);
        }

        /// <summary>
        /// Gets the open issue count by date.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static Dictionary<DateTime, int> GetOpenIssueCountByDate(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetOpenIssueCountByDate(projectId);
        }

        /// <summary>
        /// Gets the closed issue count by date.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static Dictionary<DateTime, int> GetClosedIssueCountByDate(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetClosedIssueCountByDate(projectId);
        }

        /// <summary>
        /// Issue trend report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public static List<IssueTrend> IssueTrend(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            return DataProviderManager.Provider.GetIssueTrendReport(projectId, milestoneId, startDate, endDate);
        }

        /// <summary>
        /// Times the logged.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public static List<TimeLogged> TimeLogged(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {

            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            return DataProviderManager.Provider.GetTimeLoggedReport(projectId, milestoneId, startDate, endDate);
        }

        /// <summary>
        /// Issues by priority report.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="startDate">The start date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns></returns>
        public static List<Issue> IssuesByPriority(int projectId, int milestoneId, DateTime startDate, DateTime endDate)
        {

            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (milestoneId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            return DataProviderManager.Provider.GetIssuesByPriorityReport(projectId, milestoneId, startDate, endDate);
        }
    }
}
