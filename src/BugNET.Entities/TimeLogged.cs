// -----------------------------------------------------------------------
// <copyright file="TimeLogged.cs" company="">
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
    public class TimeLogged
    {
        public decimal TotalHours { get; set; }
        public string DisplayName
        {
            get;
            set;
        }
        public Guid UserId { get; set; }
        public DateTime WorkDate { get; set; }
        public int ProjectId { get; set; }
    }
}
