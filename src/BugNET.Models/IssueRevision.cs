namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_IssueRevisions")]
    public partial class IssueRevision
    {
        [Key]
        public int IssueRevisionId { get; set; }

        public int Revision { get; set; }

        public int IssueId { get; set; }

        [Required]
        [StringLength(400)]
        public string Repository { get; set; }

        [Required]
        [StringLength(100)]
        public string RevisionAuthor { get; set; }

        [Required]
        [StringLength(100)]
        public string RevisionDate { get; set; }

        [Required]
        public string RevisionMessage { get; set; }

        public DateTime DateCreated { get; set; }

        [StringLength(255)]
        public string Branch { get; set; }

        [StringLength(100)]
        public string Changeset { get; set; }

        public virtual Issue Issue { get; set; }
    }
}
