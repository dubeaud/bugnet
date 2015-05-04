namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_Languages")]
    public partial class Language
    {
        [Key]
        public int LanguageId { get; set; }

        [Required]
        [StringLength(50)]
        public string CultureCode { get; set; }

        [Required]
        [StringLength(200)]
        public string CultureName { get; set; }

        [StringLength(50)]
        public string FallbackCulture { get; set; }
    }
}
