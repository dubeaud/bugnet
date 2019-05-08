// -----------------------------------------------------------------------
// <copyright file="IssueActivity.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.Entities
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class IssueTrend
    {
        public DateTime Date { get; set; }
        public int CumulativeOpen { get; set; }
        public int CumulativeClosed { get; set; }
        public int TotalActive { get; set; }
    }
}
