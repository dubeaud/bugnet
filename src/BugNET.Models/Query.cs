namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_Queries")]
    public partial class Query
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Query()
        {
            QueryClauses = new HashSet<QueryClause>();
        }

        [Key]
        public int QueryId { get; set; }

        public Guid UserId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(255)]
        public string QueryName { get; set; }

        public bool IsPublic { get; set; }

        public virtual Project Projects { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<QueryClause> QueryClauses { get; set; }
    }
}
