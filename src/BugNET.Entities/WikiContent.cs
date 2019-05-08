// -----------------------------------------------------------------------
// <copyright file="WikiContent.cs" company="">
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
    public class WikiContent
    {
        public int Id { get; set; }
        public WikiTitle Title { get; set; }
        public string Source { get; set; }
        public string RenderedSource { get; set; }
        public int Version { get; set; }
        public DateTime VersionDate { get; set; }

        public Guid CreatorUserId { get; set; }

        public string CreatorDisplayName { get; set; }
    }
}
