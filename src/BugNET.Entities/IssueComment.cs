using System;
using BugNET.Common;
 
namespace BugNET.Entities
{
    /// <summary>
    /// IssueComment Class
    /// </summary>
    public class IssueComment : IToXml 
    {
        #region Private Variables
        private int _Id;
        private int _IssueId;
        private string _CreatorUserName;
        private Guid _CreatorUserId;
        private string _CreatorEmail;
        private string _CreatorDisplayName;
        private string _Comment;
        private DateTime _DateCreated;

       

        #endregion

        #region Constructors

        public IssueComment() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueComment"/> class.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="comment">The comment.</param>
        /// <param name="creatorUsername">The creator username.</param>
        public IssueComment(int issueId, string comment, string creatorUsername)
            : this(Globals.NEW_ID, issueId, comment, creatorUsername, Guid.Empty, String.Empty, DateTime.MinValue)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueComment"/> class.
        /// </summary>
        /// <param name="commentId">The comment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="comment">The comment.</param>
        /// <param name="creatorUsername">The creator username.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        public IssueComment(int commentId, int issueId, string comment, string creatorUserName, Guid creatorUserId, string creatorDisplayName, DateTime created)
        {
            if (comment == null || comment.Length == 0)
                throw (new ArgumentOutOfRangeException("comment"));

            if (issueId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("IssueId"));

            _Id = commentId;
            _IssueId = issueId;
            _CreatorUserName = creatorUserName;
            _CreatorDisplayName = creatorDisplayName;
            _Comment = comment;
            _DateCreated = created;
            _CreatorUserId = creatorUserId;
        }
        #endregion

        #region Properties


        /// <summary>
        /// Gets the creator user id.
        /// </summary>
        /// <value>The creator user id.</value>
        public Guid CreatorUserId
        {
            get { return _CreatorUserId; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets or sets the comment.
        /// </summary>
        /// <value>The comment.</value>
        public string Comment
        {
            get { return (_Comment == null || _Comment.Length == 0) ? string.Empty : _Comment; }
            set { _Comment = value; }
        }

        public string CommentForXml
        {
            get { return string.Format("<![CDATA[{0}]]>", (_Comment == null || _Comment.Length == 0) ? string.Empty : _Comment); }
            set {  }
        }

        /// <summary>
        /// Gets the creator username.
        /// </summary>
        /// <value>The creator username.</value>
        public string CreatorUserName
        {
            get { return (_CreatorUserName == null || _CreatorUserName.Length == 0) ? string.Empty : _CreatorUserName; }
            set { } // needed for xml serialization
        }


        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName
        {
            get { return (_CreatorDisplayName == null || _CreatorDisplayName.Length == 0) ? string.Empty : _CreatorDisplayName; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
            set { } // needed for xml serialization
        }


        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set
            {
                if (value <= Globals.NEW_ID)
                    throw (new ArgumentOutOfRangeException("value"));
                _IssueId = value;
            }
        }
        #endregion

        #region IToXml Members

        /// <summary>
        /// Toes the XML.
        /// </summary>
        /// <returns></returns>
        public string ToXml()
        {
            XmlSerializeService<IssueComment> service = new XmlSerializeService<IssueComment>();
            return service.ToXml(this);
        }
        #endregion
     

    }
}
