namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_IssueAttachments")]
    public partial class IssueAttachment
    {
        [Key]
        public int IssueAttachmentId { get; set; }

        public int IssueId { get; set; }

        [Required]
        [StringLength(250)]
        public string FileName { get; set; }

        [Required]
        [StringLength(80)]
        public string Description { get; set; }

        public int FileSize { get; set; }

        [Required]
        [StringLength(50)]
        public string ContentType { get; set; }

        public DateTime DateCreated { get; set; }

        public Guid UserId { get; set; }

        public byte[] Attachment { get; set; }

        public virtual Issue Issue { get; set; }
    }
}
