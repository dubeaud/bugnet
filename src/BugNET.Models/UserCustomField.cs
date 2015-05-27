namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_UserCustomFields")]
    public partial class UserCustomField
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public UserCustomField()
        {
            UserCustomFieldSelections = new HashSet<UserCustomFieldSelection>();
            UserCustomFieldValues = new HashSet<UserCustomFieldValue>();
        }

        [Key]
        public int CustomFieldId { get; set; }


        [Required]
        [StringLength(50)]
        public string CustomFieldName { get; set; }

        public bool CustomFieldRequired { get; set; }

        public int CustomFieldDataType { get; set; }

        public int CustomFieldTypeId { get; set; }

        public virtual UserCustomFieldType UserCustomFieldTypes { get; set; }
        
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserCustomFieldSelection> UserCustomFieldSelections { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserCustomFieldValue> UserCustomFieldValues { get; set; }
    }
}
