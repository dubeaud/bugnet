using System;

namespace BugNET.Common
{
    public delegate void ActionEventHandler(object sender, ActionEventArgs args);

    /// <summary>
    /// Global constants, enumerations and properties
    /// </summary>
    public static class Globals
    {

        #region Public Constants

        //Cookie Constants
        public const string USER_COOKIE = "BugNETUser";
        public const string ISSUE_COLUMNS = "issuecolumns";

        public const string CONFIG_FOLDER = "\\Config\\";
        public const string UPLOAD_FOLDER = "\\Uploads\\";
        public const string UPLOAD_TOKEN = "UploadToken";
        public const int UPLOAD_FOLDER_LIMIT = 64;

        public const string SKIP_PROJECT_INTRO = "skipprojectintro";
        public const string UNASSIGNED_DISPLAY_TEXT = "none";

        public const int NEW_ID = 0;
        public const string EMPTY_GUID = "00000000-0000-0000-0000-000000000000";

        public const string SUPER_USER_ROLE = "Super Users";

        public static readonly string[] DefaultRoles = { "Project Administrators", "Read Only", "Reporter", "Developer", "Quality Assurance" };
        public static readonly string ProjectAdminRole = DefaultRoles[0];

        /// <summary>
        /// The default length of short comments (if not specified).
        /// </summary>
        public const int DEFAULTSHORT_COMMENT_LENGTH = 100;

        /// <summary>
        /// Upgrade Status Enumeration
        /// </summary>
        public enum UpgradeStatus
        {
            Upgrade = 0,
            Install = 1,
            None = 2,
            Authenticated = 3
        }

        /// <summary>
        /// Default read only role permissions
        /// </summary>
        public static readonly int[] ReadOnlyPermissions = { 
                (int)Permission.SubscribeIssue,
                (int)Permission.ViewProjectCalendar
            };

        /// <summary>
        /// Default reporter role permissions
        /// </summary>
        public static readonly int[] ReporterPermissions = { 
                (int)Permission.AddIssue, 
                (int)Permission.AddComment, 
                (int)Permission.OwnerEditComment, 
                (int)Permission.SubscribeIssue, 
                (int)Permission.AddAttachment, 
                (int)Permission.AddRelated,
                (int)Permission.AddParentIssue,
                (int)Permission.AddSubIssue,
                (int)Permission.ViewProjectCalendar
            };

        /// <summary>
        /// Default developer role permissions
        /// </summary>
        public static readonly int[] DeveloperPermissions = { 
                (int)Permission.AddIssue, 
                (int)Permission.AddComment,
                (int)Permission.AddAttachment,
                (int)Permission.AddRelated,
                (int)Permission.AddTimeEntry,
                (int)Permission.AddParentIssue,
                (int)Permission.AddSubIssue,
                (int)Permission.AddQuery,
                (int)Permission.OwnerEditComment, 
                (int)Permission.SubscribeIssue,
                (int)Permission.EditIssue,
                (int)Permission.AssignIssue,
                (int)Permission.ChangeIssueStatus,
                (int)Permission.ViewProjectCalendar
            };

        /// <summary>
        /// Default QA role permissions
        /// </summary>
        public static readonly int[] QualityAssurancePermissions = { 
                (int)Permission.AddIssue, 
                (int)Permission.AddComment,
                (int)Permission.AddAttachment,
                (int)Permission.AddRelated,
                (int)Permission.AddTimeEntry,
                (int)Permission.AddParentIssue,
                (int)Permission.AddSubIssue,
                (int)Permission.AddQuery,
                (int)Permission.OwnerEditComment, 
                (int)Permission.SubscribeIssue,
                (int)Permission.EditIssue,
                (int)Permission.EditIssueTitle,
                (int)Permission.AssignIssue,
                (int)Permission.CloseIssue,
                (int)Permission.DeleteIssue,
                (int)Permission.ChangeIssueStatus,
                (int)Permission.ViewProjectCalendar
            };

        /// <summary>
        /// Default project administrator role permissions
        /// </summary>
        public static readonly int[] AdministratorPermissions = { 
                (int)Permission.AddIssue, 
                (int)Permission.AddComment,
                (int)Permission.AddAttachment,
                (int)Permission.AddRelated,
                (int)Permission.AddTimeEntry,
                (int)Permission.AddParentIssue,
                (int)Permission.AddSubIssue,
                (int)Permission.AddQuery,
                (int)Permission.OwnerEditComment, 
                (int)Permission.SubscribeIssue,
                (int)Permission.EditIssue,
                (int)Permission.EditComment,
                (int)Permission.EditIssueDescription,
                (int)Permission.EditIssueTitle,
                (int)Permission.DeleteQuery,
                (int)Permission.DeleteAttachment,
                (int)Permission.DeleteComment,
                (int)Permission.DeleteIssue,
                (int)Permission.DeleteRelated,
                (int)Permission.DeleteTimeEntry,
                (int)Permission.DeleteQuery,
                (int)Permission.DeleteSubIssue,
                (int)Permission.DeleteParentIssue,
                (int)Permission.AssignIssue,
                (int)Permission.CloseIssue,
                (int)Permission.AdminEditProject,
                (int)Permission.ChangeIssueStatus,
                (int)Permission.ViewProjectCalendar
            };

        #endregion

        #region Public Enumerations

        /// <summary>
        /// Status codes from the database when validating an attachment
        /// </summary>
        /// <remarks>When using a valid attacment id would be returned from the database so this emun would not mat properly</remarks>
        public enum DownloadAttachmentStatusCodes
        {
            InvalidAttachmentId = 100,
            AuthenticationRequired = 200,
            ProjectOrIssueDisabled = 300,
            NoAccess = 400
        }

        public enum ActionTriggers
        {
            None = 0,
            Save = 1,
            Delete = 2,
            Close = 3,
            Cancel = 4
        }

        public enum UserRegistration
        {
            None = 0,
            Public = 1,
            Verified = 2
        }

        public enum ProjectAccessType
        {
            None = 0,
            Public = 1,
            Private = 2
        }

        public enum IssueVisibility
        {
            Public = 0,
            Private = 1
        }

        /// <summary>
        /// Permissions Enumeration
        /// </summary>
        public enum Permission
        {
            None = 0,
            CloseIssue = 1,
            AddIssue = 2,
            AssignIssue = 3,
            EditIssue = 4,
            SubscribeIssue = 5,
            DeleteIssue = 6,
            AddComment = 7,
            EditComment = 8,
            DeleteComment = 9,
            AddAttachment = 10,
            DeleteAttachment = 11,
            AddRelated = 12,
            DeleteRelated = 13,
            ReopenIssue = 14,
            OwnerEditComment = 15,
            EditIssueDescription = 16,
            EditIssueTitle = 17,
            AdminEditProject = 18,
            AddTimeEntry = 19,
            DeleteTimeEntry = 20,
            AdminCreateProject = 21,
            AddQuery = 22,
            DeleteQuery = 23,
            AdminCloneProject = 24,
            AddSubIssue = 25,
            DeleteSubIssue = 26,
            AddParentIssue = 27,
            DeleteParentIssue = 28,
            AdminDeleteProject = 29,
            ViewProjectCalendar = 30,
            ChangeIssueStatus = 31,
            EditQuery = 32
        }

        #endregion
    }
}
