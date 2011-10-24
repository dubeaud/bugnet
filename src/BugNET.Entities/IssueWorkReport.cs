using System;

namespace BugNET.Entities
{
    /// <summary>
    /// WorkReport Class
    /// </summary>
    public class IssueWorkReport
    {

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueWorkReport"/> class.
        /// </summary>
        public IssueWorkReport()
        {
            CommentText = string.Empty;
            CreatorUserName = string.Empty;
            WorkDate = DateTime.Now;
            CreatorDisplayName = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets the duration.
        /// </summary>
        /// <value>The duration.</value>
        public decimal Duration { get; set; }

        /// <summary>
        /// Gets the comment text.
        /// </summary>
        /// <value>The comment text.</value>
        public string CommentText { get; set; }

        /// <summary>
        /// Gets the comment id.
        /// </summary>
        /// <value>The comment id.</value>
        public int CommentId { get; set; }

        /// <summary>
        /// Gets the report date.
        /// </summary>
        /// <value>The report date.</value>
        public DateTime WorkDate { get; set; }

        /// <summary>
        /// Gets the name of the creator user.
        /// </summary>
        /// <value>The name of the creator user.</value>
        public string CreatorUserName { get; set; }

        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName { get; set; }

        /// <summary>
        /// Gets the creator id.
        /// </summary>
        /// <value>The creator id.</value>
        public Guid CreatorUserId { get; set; }

        #endregion
    }
}
