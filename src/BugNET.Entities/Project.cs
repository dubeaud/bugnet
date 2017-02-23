using System;
using System.Xml.Serialization;
using BugNET.Common;

namespace BugNET.Entities
{

    /// <summary>
    /// Summary description for Project.
    /// </summary>
    public class Project
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        public Project()
        {
            ManagerUserName = string.Empty;
            ManagerDisplayName = string.Empty;
            CreatorUserName = string.Empty;
            CreatorDisplayName = string.Empty;
            Description = string.Empty;
            Name = string.Empty;
            UploadPath = string.Empty;
            AccessType = ProjectAccessType.None;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the image.
        /// </summary>
        /// <value>The image.</value>
        [XmlIgnore]
        public ProjectImage Image { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [allow issue voting].
        /// </summary>
        /// <value><c>true</c> if [allow issue voting]; otherwise, <c>false</c>.</value>
        public bool AllowIssueVoting { get; set; }


        ///// <summary>
        ///// Gets or sets the type of the attachment storage.
        ///// </summary>
        ///// <value>The type of the attachment storage.</value>
        public IssueAttachmentStorageTypes AttachmentStorageType { get; set; }

        /// <summary>
        /// Gets or sets the code.
        /// </summary>
        /// <value>The code.</value>
        public string Code { get; set; }

        /// <summary>
        /// Gets or sets the manager id.
        /// </summary>
        /// <value>The manager id.</value>
        public Guid ManagerId { get; set; }

        /// <summary>
        /// Gets or sets the name of the creator user.
        /// </summary>
        /// <value>The name of the creator user.</value>
        public string CreatorUserName { get; set; }

        /// <summary>
        /// Gets or sets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="Project"/> is disabled.
        /// </summary>
        /// <value><c>true</c> if disabled; otherwise, <c>false</c>.</value>
        public bool Disabled { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description { get; set; }

        /// <summary>
        /// Gets or sets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// Gets or sets the name of the manager user.
        /// </summary>
        /// <value>The name of the manager user.</value>
        public string ManagerUserName { get; set; }

        /// <summary>
        /// Gets or sets the display name of the manager.
        /// </summary>
        /// <value>The display name of the manager.</value>
        public string ManagerDisplayName { get; set; }

        /// <summary>
        /// Gets or sets the upload path.
        /// </summary>
        /// <value>The upload path.</value>
        public string UploadPath { get; set; }

        /// <summary>
        /// Gets or sets the type of the access.
        /// </summary>
        /// <value>The type of the access.</value>
        public ProjectAccessType AccessType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [allow attachments].
        /// </summary>
        /// <value><c>true</c> if [allow attachments]; otherwise, <c>false</c>.</value>
        public bool AllowAttachments { get; set; }

        /// <summary>
        /// Gets or sets the SVN repository URL.
        /// </summary>
        /// <value>The SVN repository URL.</value>
        public string SvnRepositoryUrl { get; set; }

        #endregion


        /// <summary>
        /// Returns a <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        /// </returns>
        public override string ToString()
        {
            return Name;
        }
    }
}
