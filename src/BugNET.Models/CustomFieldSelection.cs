namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFieldSelections")]
    public partial class CustomFieldSelection
    {
        [Key]
        public int CustomFieldSelectionId { get; set; }

        public int CustomFieldId { get; set; }

        [Required]
        [StringLength(255)]
        public string CustomFieldSelectionValue { get; set; }

        [Required]
        [StringLength(255)]
        public string CustomFieldSelectionName { get; set; }

        public int CustomFieldSelectionSortOrder { get; set; }

        public virtual CustomField ProjectCustomFields { get; set; }
    }
}
