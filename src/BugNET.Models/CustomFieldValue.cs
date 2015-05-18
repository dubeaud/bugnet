namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFieldValues")]
    public partial class CustomFieldValue
    {
        [Key]
        public int CustomFieldValueId { get; set; }

        public int IssueId { get; set; }

        public int CustomFieldId { get; set; }

        [Required]
        [Column("CustomFieldValue")] 
        public string Value { get; set; }

        public virtual Issue Issue { get; set; }

        public virtual CustomField ProjectCustomFields { get; set; }
    }
}
