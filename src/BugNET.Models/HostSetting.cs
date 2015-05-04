namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_HostSettings")]
    public partial class HostSetting
    {
        [Key]
        [StringLength(50)]
        public string SettingName { get; set; }

        public string SettingValue { get; set; }
    }
}
