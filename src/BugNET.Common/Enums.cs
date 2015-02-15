using System.Xml.Serialization;

namespace BugNET.Common
{
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
    /// Status codes from the database when validating an attachment
    /// </summary>
    /// <remarks>When using a valid attachment id would be returned from the database so this enum would not mat properly</remarks>
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
        [XmlEnum(Name = "None")]
        None = 0,

        [XmlEnum(Name = "Public")]
        Public = 1,

        [XmlEnum(Name = "Private")]
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
        ChangeIssueStatus = 31,
        EditQuery = 32
    }
}
