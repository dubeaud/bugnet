namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_DefaultValues")]
    public partial class DefaultValues
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectId { get; set; }

        public int? DefaultType { get; set; }

        public int? StatusId { get; set; }

        public Guid? IssueOwnerUserId { get; set; }

        public int? IssuePriorityId { get; set; }

        public int? IssueAffectedMilestoneId { get; set; }

        public Guid? IssueAssignedUserId { get; set; }

        public int? IssueVisibility { get; set; }

        public int? IssueCategoryId { get; set; }

        public int? IssueDueDate { get; set; }

        public int? IssueProgress { get; set; }

        public int? IssueMilestoneId { get; set; }

        public decimal? IssueEstimation { get; set; }

        public int? IssueResolutionId { get; set; }

        public bool? OwnedByNotify { get; set; }

        public bool? AssignedToNotify { get; set; }

        public virtual Project Projects { get; set; }
    }
}
