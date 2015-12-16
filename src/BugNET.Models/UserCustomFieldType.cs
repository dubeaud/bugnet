namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_UserCustomFieldTypes")]
    public partial class UserCustomFieldType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public UserCustomFieldType()
        {
            UserCustomFields = new HashSet<UserCustomField>();
        }

        [Key]
        public int CustomFieldTypeId { get; set; }

        [Required]
        [StringLength(50)]
        public string CustomFieldTypeName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserCustomField> UserCustomFields { get; set; }
    }
}
