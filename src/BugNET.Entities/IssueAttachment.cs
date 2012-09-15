using System;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for IssueAttachment.
    /// </summary>
    public class IssueAttachment
    {

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        public IssueAttachment()
        {
            CreatorUserName = string.Empty;
            CreatorDisplayName = string.Empty;
            FileName = string.Empty;
            ContentType = string.Empty;
            DateCreated = DateTime.Now;
            Description = string.Empty;
        }

        #endregion

        #region Properties

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
        /// Gets the name of the file.
        /// </summary>
        /// <value>The name of the file.</value>
        public string FileName { get; set; }


        /// <summary>
        /// Gets the type of the content.
        /// </summary>
        /// <value>The type of the content.</value>
        public string ContentType { get; set; }


        /// <summary>
        /// Gets the attachment.
        /// </summary>
        /// <value>The attachment.</value>
        public byte[] Attachment { get; set; }


        ///<summary>
        /// Gets the size.
        /// </summary>
        /// <value>The size.</value>
        public int Size { get; set; }

        /// <summary>
        /// Gets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description { get; set; }

        /// <summary>
        /// Gets or sets the path where to save the attachment to (for overriding the default path)
        /// </summary>
        public string ProjectFolderPath { get; set; }

        #endregion
    }
}
