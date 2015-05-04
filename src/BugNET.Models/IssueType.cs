namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectIssueTypes")]
    public partial class IssueType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public IssueType()
        {
            Issues = new HashSet<Issue>();
            ProjectMailBoxes = new HashSet<ProjectMailbox>();
        }

        [Key]
        public int IssueTypeId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string IssueTypeName { get; set; }

        [Required]
        [StringLength(50)]
        public string IssueTypeImageUrl { get; set; }

        public int SortOrder { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues { get; set; }

        public virtual Project Projects { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectMailbox> ProjectMailBoxes { get; set; }
    }
}
