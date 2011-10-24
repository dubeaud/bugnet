using System;
using BugNET.Common;

namespace BugNET.Entities
{
    public class IssueVote
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="IssueVote"/> class.
        /// </summary>
        public IssueVote()
        {
            VoteUsername = string.Empty;
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets the notification username.
        /// </summary>
        /// <value>The notification username.</value>
        public string VoteUsername { get; set; }
    }
}
