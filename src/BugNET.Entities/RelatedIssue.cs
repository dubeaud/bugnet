using System;

namespace BugNET.Entities
{
    /// <Summary>
    /// Summary description for RelatedIssue.
    /// </Summary>
    public class RelatedIssue
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="RelatedIssue"/> class.
        /// </summary>
        public RelatedIssue()
        {
            Status = string.Empty;
            Resolution = string.Empty;
            Title = string.Empty;
            DateCreated = DateTime.Now;
        }
        #endregion

        /// <Summary>
        /// Gets the reported date.
        /// </Summary>
        /// <value>The reported date.</value>
        public DateTime DateCreated { get; set; }


        /// <Summary>
        /// Gets the issue id.
        /// </Summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets the status.
        /// </summary>
        /// <value>The status.</value>
        public string Status { get; set; }


        /// <summary>
        /// Gets the name of the status.
        /// </summary>
        /// <value>The name of the status.</value>
        public string StatusName { get; set; }

        /// <summary>
        /// Gets the status image URL.
        /// </summary>
        /// <value>The status image URL.</value>
        public string StatusImageUrl { get; set; }


        /// <summary>
        /// Gets the resolution.
        /// </summary>
        /// <value>The resolution.</value>
        public string Resolution { get; set; }

        /// <Summary>
        /// Gets or sets the Summary.
        /// </Summary>
        /// <value>The Summary.</value>
        public string Title { get; set; }
    }
}
