namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFields")]
    public partial class ProjectCustomField
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProjectCustomField()
        {
            ProjectCustomFieldSelections = new HashSet<ProjectCustomFieldSelection>();
            ProjectCustomFieldValues = new HashSet<ProjectCustomFieldValue>();
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

        public virtual ProjectCustomFieldType ProjectCustomFieldTypes { get; set; }

        public virtual Project Projects { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectCustomFieldSelection> ProjectCustomFieldSelections { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProjectCustomFieldValue> ProjectCustomFieldValues { get; set; }
    }
}
