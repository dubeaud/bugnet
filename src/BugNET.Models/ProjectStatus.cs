namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectStatus")]
    public partial class ProjectStatus
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProjectStatus()
        {
            Issues = new HashSet<Issue>();
        }

        [Key]
        public int StatusId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string StatusName { get; set; }

        [Required]
        [StringLength(50)]
        public string StatusImageUrl { get; set; }

        public int SortOrder { get; set; }

        public bool IsClosedState { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues { get; set; }

        public virtual Project Projects { get; set; }
    }
}
