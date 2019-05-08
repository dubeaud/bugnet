// -----------------------------------------------------------------------
// <copyright file="DataProviderPro.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.DAL
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using BugNET.Entities;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public abstract partial class DataProvider
    {
        //Wiki
        public abstract WikiContent GetWikiContent(int projectId, string slug, string title);
        public abstract WikiContent GetWikiContent(int id);
        public abstract WikiContent GetWikiContentByVersion(int id, int version);
        public abstract List<WikiContent> GetWikiContentHistory(int titleId);
        public abstract int SaveWikiContent(int projectId, int id, string slug, string title, string source, string createdByUserName);
        public abstract void DeleteWikiContent(int id);

        //Reports 
        public abstract List<MilestoneBurnup> GetMilestoneBurnupReport(int projectId);
        public abstract List<MilestoneBurndown> GetMilestoneBurndownReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate);
        public abstract List<IssueTrend> GetIssueTrendReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate);
        public abstract List<TimeLogged> GetTimeLoggedReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate);
        public abstract Dictionary<DateTime, int> GetClosedIssueCountByDate(int projectId);
        public abstract Dictionary<DateTime, int> GetOpenIssueCountByDate(int projectId);
        public abstract List<Issue> GetIssuesByPriorityReport(int projectId, int milestoneId, DateTime startDate, DateTime endDate);

        public abstract string GetProductName();
    }
}
