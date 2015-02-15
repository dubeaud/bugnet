using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Entity object for issue revision
    /// </summary>
    public class IssueRevision
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueRevision"/> class.
        /// </summary>
        public IssueRevision()
        {
            Author = string.Empty;
            Message = string.Empty;
            Repository = string.Empty;
            DateCreated = DateTime.Now;
            RevisionDate = string.Empty;
            Changeset = string.Empty;
            Branch = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId { get; set; }

        /// <summary>
        /// Gets or sets the revision.
        /// </summary>
        /// <value>The revision.</value>
        public int Revision { get; set; }

        /// <summary>
        /// Gets or sets the author.
        /// </summary>
        /// <value>The author.</value>
        public string Author { get; set; }

        /// <summary>
        /// Gets or sets the message.
        /// </summary>
        /// <value>The message.</value>
        public string Message { get; set; }

        /// <summary>
        /// Gets or sets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the repository.
        /// </summary>
        /// <value>The repository.</value>
        public string Repository { get; set; }

        /// <summary>
        /// Gets or sets the revision date.
        /// </summary>
        /// <value>The revision date.</value>
        public string RevisionDate { get; set; }

        /// <summary>
        /// Gets or sets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// Gets or sets the branch.
        /// </summary>
        /// <value>The branch.</value>
        public string Branch { get; set; }

        /// <summary>
        /// Gets or sets the changeset.
        /// </summary>
        /// <value>The changeset.</value>
        public string Changeset { get; set; }

        #endregion


    }
}
