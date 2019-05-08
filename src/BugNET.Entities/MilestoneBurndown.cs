// -----------------------------------------------------------------------
// <copyright file="MilestoneBurndown.cs" company="">
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
    /// Entity for the milestone burndown report
    /// </summary>
    public class MilestoneBurndown
    {
        public DateTime Date { get; set; }
        public double Remaining { get; set; }
        public double Ideal { get; set; }
    }
}
