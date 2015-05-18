namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectResolutions")]
    public partial class Resolution
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Resolution()
        {
            Issues = new HashSet<Issue>();
        }

        [Key]
        public int ResolutionId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string ResolutionName { get; set; }

        [Required]
        [StringLength(50)]
        public string ResolutionImageUrl { get; set; }

        public int SortOrder { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues { get; set; }

        public virtual Project Projects { get; set; }
    }
}
