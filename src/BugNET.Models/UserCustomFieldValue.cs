namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_UserCustomFieldValues")]
    public partial class UserCustomFieldValue
    {
        [Key]
        public int CustomFieldValueId { get; set; }

        public Guid UserId { get; set; }

        public int CustomFieldId { get; set; }

        [Required]
        [Column("CustomFieldValue")] 
        public string Value { get; set; }

        public virtual CustomField ProjectCustomFields { get; set; }
    }
}
