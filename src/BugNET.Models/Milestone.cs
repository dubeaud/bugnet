namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectMilestones")]
    public partial class Milestone
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Milestone()
        {
            Issues = new HashSet<Issue>();
            Issues1 = new HashSet<Issue>();
        }

        [Key]
        public int MilestoneId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string MilestoneName { get; set; }

        [Required]
        [StringLength(50)]
        public string MilestoneImageUrl { get; set; }

        public int SortOrder { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime? MilestoneDueDate { get; set; }

        public DateTime? MilestoneReleaseDate { get; set; }

        public string MilestoneNotes { get; set; }

        public bool MilestoneCompleted { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Issue> Issues1 { get; set; }

        public virtual Project Projects { get; set; }
    }
}
