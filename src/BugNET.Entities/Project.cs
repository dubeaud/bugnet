using System;
using BugNET.Common;

namespace BugNET.Entities
{

    /// <summary>
    /// Summary description for Project.
    /// </summary>
    public class Project
    {
        private string _description;
        private string _name;
        private string _uploadPath;

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="managerDisplayName">Display name of the manager.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="disabled">if set to <c>true</c> [disabled].</param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
        /// <param name="attachmentStorageType">Type of the attachment storage.</param>
        /// <param name="svnRepositoryUrl">The SVN repository URL.</param>
        /// <param name="allowIssueVoting">if set to <c>true</c> [allow issue voting].</param>
        /// <param name="projectImage"></param>
        public Project(int projectId, string name, string code, string description, string managerUserName, string managerDisplayName,
            string creatorUserName, string creatorDisplayName, string uploadPath, Globals.ProjectAccessType accessType, bool disabled,
            bool allowAttachments, IssueAttachmentStorageTypes attachmentStorageType, string svnRepositoryUrl, bool allowIssueVoting,
            ProjectImage projectImage)
            : this(projectId, name, code, description, managerUserName, managerDisplayName, creatorUserName, creatorDisplayName, uploadPath,
            DateTime.Now, accessType, disabled, allowAttachments, Guid.Empty, attachmentStorageType, svnRepositoryUrl, allowIssueVoting, projectImage)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="managerDisplayName"></param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName"></param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="disabled"></param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
        /// <param name="attachmentStorageType"></param>
        /// <param name="svnRepositoryUrl"></param>
        /// <param name="allowIssueVoting"></param>
        public Project(int projectId, string name, string code, string description, string managerUserName, string managerDisplayName, string creatorUserName, string creatorDisplayName, string uploadPath, Globals.ProjectAccessType accessType, bool disabled, bool allowAttachments, IssueAttachmentStorageTypes attachmentStorageType, string svnRepositoryUrl, bool allowIssueVoting)
            : this(projectId, name, code, description, managerUserName, managerDisplayName, creatorUserName, creatorDisplayName, uploadPath, DateTime.Now, accessType, disabled, allowAttachments, Guid.Empty, attachmentStorageType, svnRepositoryUrl, allowIssueVoting, null)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="managerDisplayName"></param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName"></param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="dateCreated">The date created.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="disabled"></param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
        /// <param name="managerId"></param>
        /// <param name="attachmentStorageType"></param>
        /// <param name="svnRepositoryUrl"></param>
        /// <param name="allowIssueVoting"></param>
        /// <param name="projectImage"></param>
        public Project(int projectId, string name, string code, string description, string managerUserName, string managerDisplayName,
                string creatorUserName, string creatorDisplayName, string uploadPath, DateTime dateCreated, Globals.ProjectAccessType accessType,
                bool disabled, bool allowAttachments, Guid managerId, IssueAttachmentStorageTypes attachmentStorageType, string svnRepositoryUrl,
            bool allowIssueVoting, ProjectImage projectImage)
        {
            // Validate Mandatory Fields//
            if (string.IsNullOrEmpty(name))
                throw (new ArgumentOutOfRangeException("name"));

            Id = projectId;
            _description = description;
            _name = name;
            Code = code;
            ManagerUserName = managerUserName;
            ManagerDisplayName = managerDisplayName;
            ManagerId = managerId;
            CreatorUserName = creatorUserName;
            CreatorDisplayName = creatorDisplayName;
            DateCreated = dateCreated;
            _uploadPath = uploadPath;
            Disabled = disabled;
            AccessType = accessType;
            AllowAttachments = allowAttachments;
            AttachmentStorageType = attachmentStorageType;
            SvnRepositoryUrl = svnRepositoryUrl;
            AllowIssueVoting = allowIssueVoting;
            Image = projectImage;
        }
        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        public Project() { }
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
        public ProjectImage Image { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [allow issue voting].
        /// </summary>
        /// <value><c>true</c> if [allow issue voting]; otherwise, <c>false</c>.</value>
        public bool AllowIssueVoting { get; set; }


        /// <summary>
        /// Gets or sets the type of the attachment storage.
        /// </summary>
        /// <value>The type of the attachment storage.</value>
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
        public string Name
        {
            get
            {
                return string.IsNullOrEmpty(_name) ? string.Empty : _name;
            }
            set { _name = value; }
        }

        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description
        {
            get
            {
                return string.IsNullOrEmpty(_description) ? string.Empty : _description;
            }
            set
            { _description = value; }
        }

        /// <summary>
        /// Gets or sets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated { get; private set; }

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
        public string UploadPath
        {
            get
            {
                return string.IsNullOrEmpty(_uploadPath) ? string.Empty : _uploadPath;
            }
            set { _uploadPath = value; }
        }

        /// <summary>
        /// Gets or sets the type of the access.
        /// </summary>
        /// <value>The type of the access.</value>
        public Globals.ProjectAccessType AccessType { get; set; }

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
            return _name;
        }
    }
}
