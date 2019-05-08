// -----------------------------------------------------------------------
// <copyright file="MilestoneBurnup.cs" company="">
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
    /// Entity  for the milestone burnup report
    /// </summary>
    public class MilestoneBurnup
    {
        public decimal TotalHours { get; set;}
        public decimal TotalCompleted { get; set; }
        public string MilestoneName { get; set; }
    }
}
