namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_ProjectCustomFieldTypes")]
    public partial class CustomFieldType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CustomFieldType()
        {
            ProjectCustomFields = new HashSet<CustomField>();
        }

        [Key]
        public int CustomFieldTypeId { get; set; }

        [Required]
        [StringLength(50)]
        public string CustomFieldTypeName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CustomField> ProjectCustomFields { get; set; }
    }
}
