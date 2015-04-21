using System;
using BugNET.Common;
 
namespace BugNET.Entities
{
    /// <summary>
    /// IssueComment Class
    /// </summary>
    public class IssueComment 
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueComment"/> class.
        /// </summary>
        public IssueComment()
        {
            CreatorUser = new ITUser(new Guid(), string.Empty, string.Empty);
            CreatorUserName = string.Empty;
            Comment = string.Empty;
            CreatorDisplayName = string.Empty;
            DateCreated = DateTime.Now;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueComment"/> class.
        /// </summary>
        /// <param name="commentId">The comment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="comment">The comment.</param>
        /// <param name="creatorUserName">The creator username.</param>
        /// <param name="creatorUserId"></param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        [Obsolete]
        public IssueComment(int commentId, int issueId, string comment, string creatorUserName, Guid creatorUserId, string creatorDisplayName, DateTime created) :this()
        {

        }
        #endregion

        #region Properties

        /// <summary>
        /// Gets the creator user id.
        /// </summary>
        /// <value>The creator user id.</value>
        public Guid CreatorUserId { get; set; }

        /// <summary>
        /// Gets or sets the comment.
        /// </summary>
        /// <value>The comment.</value>
        public string Comment { get; set; }

        public string CommentForXml
        {
            get { return string.Format("<![CDATA[{0}]]>", string.IsNullOrEmpty(Comment) ? string.Empty : Comment); }
            set { }
        }

        /// <summary>
        /// Gets the creator username.
        /// </summary>
        /// <value>The creator username.</value>
        public string CreatorUserName { get; set; }


        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName { get; set; }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated { get; set; }


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
        /// Gets or sets the creator user.
        /// </summary>
        /// <value>The creator user</value>
        public ITUser CreatorUser { get; set; }

        #endregion
    }
}
