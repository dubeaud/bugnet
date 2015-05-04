namespace BugNET.DataAccess
{
    using BugNET.Models;
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class BugNETModels : DbContext
    {
        public BugNETModels()
            : base("name=BugNET")
        {
        }

        public virtual DbSet<ApplicationLog> ApplicationLog { get; set; }
        public virtual DbSet<DefaultValues> DefaultValues { get; set; }
        public virtual DbSet<DefaultValuesVisibility> DefaultValuesVisibility { get; set; }
        public virtual DbSet<HostSettings> HostSettings { get; set; }
        public virtual DbSet<IssueAttachment> IssueAttachments { get; set; }
        public virtual DbSet<IssueComment> IssueComments { get; set; }
        public virtual DbSet<IssueHistory> IssueHistory { get; set; }
        public virtual DbSet<IssueNotification> IssueNotifications { get; set; }
        public virtual DbSet<IssueRevision> IssueRevisions { get; set; }
        public virtual DbSet<Issue> Issues { get; set; }
        public virtual DbSet<IssueVote> IssueVotes { get; set; }
        public virtual DbSet<IssueWorkReport> IssueWorkReports { get; set; }
        public virtual DbSet<Language> Languages { get; set; }
        public virtual DbSet<Permissions> Permissions { get; set; }
        public virtual DbSet<ProjectCategory> ProjectCategories { get; set; }
        public virtual DbSet<ProjectCustomField> ProjectCustomFields { get; set; }
        public virtual DbSet<ProjectCustomFieldSelection> ProjectCustomFieldSelections { get; set; }
        public virtual DbSet<ProjectCustomFieldType> ProjectCustomFieldTypes { get; set; }
        public virtual DbSet<ProjectCustomFieldValue> ProjectCustomFieldValues { get; set; }
        public virtual DbSet<ProjectIssueType> ProjectIssueTypes { get; set; }
        public virtual DbSet<ProjectMailBox> ProjectMailBoxes { get; set; }
        public virtual DbSet<ProjectMilestone> ProjectMilestones { get; set; }
        public virtual DbSet<ProjectNotification> ProjectNotifications { get; set; }
        public virtual DbSet<ProjectPriority> ProjectPriorities { get; set; }
        public virtual DbSet<ProjectResolution> ProjectResolutions { get; set; }
        public virtual DbSet<Project> Projects { get; set; }
        public virtual DbSet<ProjectStatus> ProjectStatus { get; set; }
        public virtual DbSet<Query> Queries { get; set; }
        public virtual DbSet<QueryClause> QueryClauses { get; set; }
        public virtual DbSet<RelatedIssue> RelatedIssues { get; set; }
        public virtual DbSet<RequiredFieldList> RequiredFieldList { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<UserProfile> UserProfiles { get; set; }
        public virtual DbSet<UserProject> UserProjects { get; set; }
        public virtual DbSet<UserRole> UserRoles { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ApplicationLog>()
                .Property(e => e.Thread)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationLog>()
                .Property(e => e.Level)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationLog>()
                .Property(e => e.Logger)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationLog>()
                .Property(e => e.Message)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationLog>()
                .Property(e => e.Exception)
                .IsUnicode(false);

            modelBuilder.Entity<DefaultValues>()
                .Property(e => e.IssueEstimation)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Issue>()
                .Property(e => e.Estimation)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Issue>()
                .HasMany(e => e.Votes)
                .WithRequired(e => e.Issue)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Issue>()
                .HasMany(e => e.RelatedIssues)
                .WithRequired(e => e.PrimaryIssue)
                .HasForeignKey(e => e.PrimaryIssueId);

            modelBuilder.Entity<Issue>()
                .HasMany(e => e.RelatedIssues1)
                .WithRequired(e => e.SecondaryIssue)
                .HasForeignKey(e => e.SecondaryIssueId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<IssueWorkReport>()
                .Property(e => e.Duration)
                .HasPrecision(4, 2);

            modelBuilder.Entity<Permissions>()
                .HasMany(e => e.Roles)
                .WithMany(e => e.Permissions)
                .Map(m => m.ToTable("RolePermissions").MapLeftKey("PermissionId").MapRightKey("RoleId"));

            modelBuilder.Entity<ProjectCategory>()
                .HasMany(e => e.Issues)
                .WithOptional(e => e.Category)
                .HasForeignKey(e => e.CategoryId);

            modelBuilder.Entity<ProjectCustomField>()
                .HasMany(e => e.ProjectCustomFieldValues)
                .WithRequired(e => e.ProjectCustomFields)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProjectMilestone>()
                .HasMany(e => e.Issues)
                .WithOptional(e => e.Milestone)
                .HasForeignKey(e => e.ilestoneId);

            modelBuilder.Entity<ProjectMilestone>()
                .HasMany(e => e.Issues1)
                .WithOptional(e => e.Milestone1)
                .HasForeignKey(e => e.AffectedMilestoneId);

            modelBuilder.Entity<ProjectPriority>()
                .HasMany(e => e.Issues)
                .WithOptional(e => e.Priority)
                .HasForeignKey(e => e.PriorityId);

            modelBuilder.Entity<ProjectResolution>()
                .HasMany(e => e.Issues)
                .WithOptional(e => e.Resolution)
                .HasForeignKey(e => e.ResolutionId);

            modelBuilder.Entity<Project>()
                .HasOptional(e => e.DefaultValues)
                .WithRequired(e => e.Projects)
                .WillCascadeOnDelete();

            modelBuilder.Entity<Project>()
                .HasMany(e => e.Roles)
                .WithOptional(e => e.Project)
                .WillCascadeOnDelete();

            modelBuilder.Entity<ProjectStatus>()
                .HasMany(e => e.Issues)
                .WithOptional(e => e.Status)
                .HasForeignKey(e => e.StatusId);
        }
    }
}
