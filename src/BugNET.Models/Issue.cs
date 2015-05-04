namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_Issues")]
    public partial class Issue
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Issue()
        {
            Attachments = new HashSet<IssueAttachment>();
            Comments = new HashSet<IssueComment>();
            History = new HashSet<IssueHistory>();
            Notifications = new HashSet<IssueNotification>();
            Revisions = new HashSet<IssueRevision>();
            Votes = new HashSet<IssueVote>();
            WorkReports = new HashSet<IssueWorkReport>();
            CustomFieldValues = new HashSet<CustomFieldValue>();
            RelatedIssues = new HashSet<RelatedIssue>();
            RelatedIssues1 = new HashSet<RelatedIssue>();
        }

        [Key]
        public int IssueId { get; set; }

        [Required]
        [StringLength(500)]
        public string IssueTitle { get; set; }

        [Required]
        [Column("IssueDescription")]
        public string Description { get; set; }

        [Column("IssueStatusId")]
        public int? StatusId { get; set; }

        [Column("IssuePriorityId")]
        public int? PriorityId { get; set; }

        [Column("IssueTypeId")]
        public int? TypeId { get; set; }

        [Column("IssueCategoryId")]
        public int? CategoryId { get; set; }

        public int ProjectId { get; set; }

        [Column("IssueAffectedMilestoneId")]
        public int? AffectedMilestoneId { get; set; }

        [Column("IssueResolutionId")]
        public int? ResolutionId { get; set; }

        [Column("IssueCreatorUserId")]
        public Guid CreatorUserId { get; set; }

        [Column("IssueAssignedUserId")]
        public Guid? AssignedUserId { get; set; }

        [Column("IssueOwnerUserId")]
        public Guid? OwnerUserId { get; set; }

        [Column("IssueDueDate")]
        public DateTime? DueDate { get; set; }

        [Column("IssueMilestoneId")]
        public int? ilestoneId { get; set; }

        [Column("IssueVisibility")]
        public int Visibility { get; set; }

        [Column("IssueEstimation")]
        public decimal Estimation { get; set; }

        [Column("IssueProgress")]
        public int Progress { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime LastUpdate { get; set; }

        public Guid LastUpdateUserId { get; set; }

        public bool Disabled { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueAttachment> Attachments { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueComment> Comments { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueHistory> History { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueNotification> Notifications { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueRevision> Revisions { get; set; }

        public virtual Category Category { get; set; }

        public virtual IssueType IssueType { get; set; }

        public virtual Milestone Milestone { get; set; }

        public virtual Milestone Milestone1 { get; set; }

        public virtual Priority Priority { get; set; }

        public virtual Resolution Resolution { get; set; }

        public virtual Project Project { get; set; }

        public virtual ProjectStatus Status { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueVote> Votes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IssueWorkReport> WorkReports { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CustomFieldValue> CustomFieldValues { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RelatedIssue> RelatedIssues { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RelatedIssue> RelatedIssues1 { get; set; }
    }
}
