namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFieldValues")]
    public partial class ProjectCustomFieldValue
    {
        [Key]
        public int CustomFieldValueId { get; set; }

        public int IssueId { get; set; }

        public int CustomFieldId { get; set; }

        [Required]
        public string CustomFieldValue { get; set; }

        public virtual Issue Issue { get; set; }

        public virtual ProjectCustomField ProjectCustomFields { get; set; }
    }
}
