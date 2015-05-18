namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_IssueHistory")]
    public partial class IssueHistory
    {
        [Key]
        public int IssueHistoryId { get; set; }

        public int IssueId { get; set; }

        [Required]
        [StringLength(50)]
        public string FieldChanged { get; set; }

        [Required]
        [StringLength(50)]
        public string OldValue { get; set; }

        [Required]
        [StringLength(50)]
        public string NewValue { get; set; }

        public DateTime DateCreated { get; set; }

        public Guid UserId { get; set; }

        public virtual Issue Issue { get; set; }
    }
}
