using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for IssueAttachment.
    /// </summary>
    public class IssueAttachment
    {
        #region Private Variables
        private int _Id;
        private int _IssueId;
        private string _CreatorUserName;
        private string _CreatorDisplayName;
        private DateTime _DateCreated;
        private string _FileName;
        private string _ContentType;
        private string _Description;
        private int _Size;
        private Byte[] _Attachment;
        
        #endregion

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(string fileName, string contentType, byte[] attachment)
            : this(Globals.NewId, Globals.NewId, String.Empty, String.Empty, Globals.GetDateTimeMinValue(), fileName, contentType, attachment, 0, string.Empty)
        { }


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(int issueId, string creatorUserName, string fileName, string contentType, byte[] attachment, int size, string description)
            : this(Globals.NewId, issueId, creatorUserName, String.Empty, Globals.GetDateTimeMinValue(), fileName, contentType, attachment, size, description)
        { }


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        /// <param name="fileName">Name of the file.</param>
        public IssueAttachment(int attachmentId, int issueId, string creatorUserName, string creatorDisplayName, DateTime created, string fileName, int size, string description)
            : this(attachmentId, issueId, creatorUserName, creatorDisplayName, created, fileName, String.Empty, null, size, description)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(int attachmentId, int issueId, string creatorUserName, string creatorDisplayName, DateTime created, string fileName, string contentType, byte[] attachment, int size, string description)
        {
            _Id = attachmentId;
            _IssueId = issueId;
            _CreatorUserName = creatorUserName;
            _CreatorDisplayName = creatorDisplayName;
            _DateCreated = created;
            _FileName = fileName;
            _ContentType = contentType;
            _Attachment = attachment;
            _Size = size;
            _Description = description;
        }
        #endregion

        #region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
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
                if (value <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("value"));
                _IssueId = value;
            }
        }


        /// <summary>
        /// Gets the creator username.
        /// </summary>
        /// <value>The creator username.</value>
        public string CreatorUserName
        {
            get
            {
                if (_CreatorUserName == null || _CreatorUserName.Length == 0)
                    return string.Empty;
                else
                    return _CreatorUserName;
            }
        }


        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName
        {
            get
            {
                if (_CreatorDisplayName == null || _CreatorDisplayName.Length == 0)
                    return string.Empty;
                else
                    return _CreatorDisplayName;
            }
        }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
        }


        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <value>The name of the file.</value>
        public string FileName
        {
            get
            {
                if (_FileName == null || _FileName.Length == 0)
                    return string.Empty;
                else
                    return _FileName;
            }
            set { _FileName = value; }
        }



        /// <summary>
        /// Gets the type of the content.
        /// </summary>
        /// <value>The type of the content.</value>
        public string ContentType
        {
            get
            {
                if (_ContentType == null || _ContentType.Length == 0)
                    return string.Empty;
                else
                    return _ContentType;
            }

            set { _ContentType = value; }
        }


        /// <summary>
        /// Gets the attachment.
        /// </summary>
        /// <value>The attachment.</value>
        public Byte[] Attachment
        {
            get { return _Attachment; }
            set { _Attachment = value; }
        }


        ///<summary>
        /// Gets the size.
        /// </summary>
        /// <value>The size.</value>
        public int Size
        {
            get { return _Size; }
            set { _Size = value; }
        }
        /// <summary>
        /// Gets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }



        #endregion


    }
}
