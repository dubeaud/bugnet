namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_Projects")]
    public partial class Project
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Project()
        {
            Issues = new HashSet<Issue>();
            ProjectCategories = new HashSet<Category>();
            ProjectCustomFields = new HashSet<CustomField>();
            ProjectIssueTypes = new HashSet<IssueType>();
            ProjectMailBoxes = new HashSet<ProjectMailbox>();
            ProjectMilestones = new HashSet<Milestone>();
            ProjectNotifications = new HashSet<ProjectNotification>();
            ProjectPriorities = new HashSet<Priority>();
            ProjectResolutions = new HashSet<Resolution>();
            ProjectStatus = new HashSet<ProjectStatus>();
            Queries = new HashSet<Query>();
            Roles = new HashSet<Role>();
            UserProjects = new HashSet<UserProject>();
        }

        [Key]
        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string ProjectName { get; set; }

        [Required]
        [StringLength(50)]
        public string ProjectCode { get; set; }

        [Required]
        public string ProjectDescription { get; set; }

        [Required]
        [StringLength(256)]
        public string AttachmentUploadPath { get; set; }

        public DateTime DateCreated { get; set; }

        public bool ProjectDisabled { get; set; }

        public int ProjectAccessType { get; set; }

        public Guid ProjectManagerUserId { get; set; }

        public Guid ProjectCreatorUserId { get; set; }

        public bool AllowAttachments { get; set; }

        [StringLength(255)]
        public string SvnRepositoryUrl { get; set; }

        public bool AllowIssueVoting { get; set; }

        public byte[] ProjectImageFileContent { get; set; }

        [StringLength(150)]
        public string ProjectImageFileName { get; set; }

        [StringLength(50)]
        public string ProjectImageContentType { get; set; }

        public long? ProjectImageFileSize { get; set; }

        public virtual DefaultValues DefaultValues { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Category> ProjectCategories { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CustomField> ProjectCustomFields { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueType> ProjectIssueTypes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectMailbox> ProjectMailBoxes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Milestone> ProjectMilestones { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectNotification> ProjectNotifications { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Priority> ProjectPriorities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Resolution> ProjectResolutions { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectStatus> ProjectStatus { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Query> Queries { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Role> Roles { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserProject> UserProjects { get; set; }
    }
}
