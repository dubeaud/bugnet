namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_UserProjects")]
    public partial class UserProject
    {
        [Key]
        [Column(Order = 0)]
        public Guid UserId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectId { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserProjectId { get; set; }

        public DateTime DateCreated { get; set; }

        [StringLength(255)]
        public string SelectedIssueColumns { get; set; }

        public virtual Project Projects { get; set; }
    }
}
