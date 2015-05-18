namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_QueryClauses")]
    public partial class QueryClause
    {
        [Key]
        public int QueryClauseId { get; set; }

        public int QueryId { get; set; }

        [Required]
        [StringLength(50)]
        public string BooleanOperator { get; set; }

        [Required]
        [StringLength(50)]
        public string FieldName { get; set; }

        [Required]
        [StringLength(50)]
        public string ComparisonOperator { get; set; }

        [Required]
        [StringLength(50)]
        public string FieldValue { get; set; }

        public int DataType { get; set; }

        public int? CustomFieldId { get; set; }

        public virtual Query Queries { get; set; }
    }
}
