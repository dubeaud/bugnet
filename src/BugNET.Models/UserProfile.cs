namespace BugNET.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BugNet_")]
    public partial class UserProfile
    {
        [Key]
        [StringLength(50)]
        public string UserName { get; set; }

        [StringLength(100)]
        public string FirstName { get; set; }

        [StringLength(100)]
        public string LastName { get; set; }

        [StringLength(100)]
        public string DisplayName { get; set; }

        public int? IssuesPageSize { get; set; }

        [StringLength(50)]
        public string PreferredLocale { get; set; }

        public DateTime LastUpdate { get; set; }

        [StringLength(50)]
        public string SelectedIssueColumns { get; set; }

        public bool ReceiveEmailNotifications { get; set; }

        [StringLength(128)]
        public string PasswordVerificationToken { get; set; }

        public DateTime? PasswordVerificationTokenExpirationDate { get; set; }
    }
}
