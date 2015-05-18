namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFields")]
    public partial class CustomField
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CustomField()
        {
            ProjectCustomFieldSelections = new HashSet<CustomFieldSelection>();
            ProjectCustomFieldValues = new HashSet<CustomFieldValue>();
        }

        [Key]
        public int CustomFieldId { get; set; }

        public int ProjectId { get; set; }

        [Required]
        [StringLength(50)]
        public string CustomFieldName { get; set; }

        public bool CustomFieldRequired { get; set; }

        public int CustomFieldDataType { get; set; }

        public int CustomFieldTypeId { get; set; }

        public virtual CustomFieldType ProjectCustomFieldTypes { get; set; }

        public virtual Project Projects { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CustomFieldSelection> ProjectCustomFieldSelections { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CustomFieldValue> ProjectCustomFieldValues { get; set; }
    }
}
