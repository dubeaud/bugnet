using System;
using System.Collections.Generic;
using System.Configuration.Provider;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.DAL
{
    /// <summary>
    /// Data Provider Abstract Class
    /// </summary>
    public abstract partial class DataProvider : ProviderBase
    {
        /*** Abstract Properties ***/
        public abstract bool SupportsProjectCloning { get; }

        //*** ABSTRACT METHODS ***/
        public abstract DataAccessException ProcessException(Exception ex);

        // Installation Helper Methods
        public abstract string GetProviderPath();
        public abstract string GetDatabaseVersion();
        public abstract void ExecuteScript(List<string> sql);

        // Category
        public abstract int CreateNewCategory(Category newCategory);
        public abstract bool DeleteCategory(int categoryId);
        public abstract bool UpdateCategory(Category categoryToUpdate);
        public abstract List<Category> GetCategoriesByProjectId(int projectId);
        public abstract List<Category> GetRootCategoriesByProjectId(int projectId);
        public abstract List<Category> GetChildCategoriesByCategoryId(int categoryId);
        public abstract Category GetCategoryById(int categoryId);

        // Issue
        public abstract bool DeleteIssue(int issueId);
        public abstract List<Issue> GetIssuesByProjectId(int projectId);
        public abstract Issue GetIssueById(int issueId);
        public abstract bool UpdateIssue(Issue issueToUpdate);
        public abstract int CreateNewIssue(Issue issueToCreate);
        public abstract List<Issue> GetIssuesByRelevancy(int projectId, string username);
        public abstract List<Issue> GetIssuesByAssignedUserName(int projectId, string assignedUserName);
        public abstract List<Issue> GetIssuesByCreatorUserName(int projectId, string creatorUserName);
        public abstract List<Issue> GetIssuesByOwnerUserName(int projectId, string creatorUserName);
        public abstract List<Issue> GetOpenIssues(int projectId);
        public abstract List<Issue> GetMonitoredIssuesByUserName(string userName, bool excludeClosedStatus);
        
        public abstract List<IssueCount> GetIssueStatusCountByProject(int projectId);
        public abstract List<IssueCount> GetIssueMilestoneCountByProject(int projectId);
        public abstract List<IssueCount> GetIssueUserCountByProject(int projectId);
        public abstract List<IssueCount> GetIssueTypeCountByProject(int projectId);
        public abstract List<IssueCount> GetIssuePriorityCountByProject(int projectId);
        public abstract int GetIssueUnassignedCountByProject(int projectId);
        public abstract int GetIssueCountByProjectAndCategory(int projectId, int categoryId);
        public abstract int GetIssueUnscheduledMilestoneCountByProject(int projectId);
        public abstract string GetSelectedIssueColumnsByUserName(string userName, int projectId);
        public abstract void SetSelectedIssueColumnsByUserName(string userName, int projectId, string columns);


        // Related Issues
        public abstract List<RelatedIssue> GetChildIssues(int issueId);
        public abstract List<RelatedIssue> GetParentIssues(int issueId);
        public abstract List<RelatedIssue> GetRelatedIssues(int issueId);
        public abstract int CreateNewChildIssue(int primaryIssueId, int secondaryIssueId);
        public abstract bool DeleteChildIssue(int primaryIssueId, int secondaryIssueId);
        public abstract int CreateNewParentIssue(int primaryIssueId, int secondaryIssueId);
        public abstract bool DeleteParentIssue(int primaryIssueId, int secondaryIssueId);
        public abstract int CreateNewRelatedIssue(int primaryIssueId, int secondaryIssueId);
        public abstract bool DeleteRelatedIssue(int primaryIssueId, int secondaryIssueId);

        // Queries
        public abstract List<Query> GetQueriesByUserName(string username, int projectId);
        public abstract bool SaveQuery(string username, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses);
        public abstract bool UpdateQuery(int queryId, string username, int projectId, string queryName, bool isPublic, List<QueryClause> queryClauses);
        public abstract bool DeleteQuery(int queryId);
        public abstract List<RequiredField> GetRequiredFieldsForIssues();
        public abstract void PerformGenericQuery<T>(ref List<T> list, List<QueryClause> queryClauses, string sql, string orderBy);
        public abstract List<Issue> PerformQuery(int projectId, List<QueryClause> queryClauses);
        public abstract List<Issue> PerformSavedQuery(int projectId, int queryId);
        public abstract List<QueryClause> GetQueryClausesByQueryId(int queryId);
        public abstract Query GetQueryById(int queryId);

        // IssueComments
        public abstract int CreateNewIssueComment(IssueComment newComment);
        public abstract List<IssueComment> GetIssueCommentsByIssueId(int issueId);
        public abstract bool DeleteIssueCommentById(int commentId);
        public abstract bool UpdateIssueComment(IssueComment issueCommentToUpdate);
        public abstract IssueComment GetIssueCommentById(int issueCommentId);

        // IssueAttachments
        public abstract int CreateNewIssueAttachment(IssueAttachment newAttachment);
        public abstract List<IssueAttachment> GetIssueAttachmentsByIssueId(int issueId);
        public abstract IssueAttachment GetIssueAttachmentById(int attachmentId);
        public abstract bool DeleteIssueAttachment(int attachmentId);
        public abstract IssueAttachment GetAttachmentForDownload(int attachmentId, string requestingUser = "");

        // IssueHistory
        public abstract List<IssueHistory> GetIssueHistoryByIssueId(int issueId);
        public abstract int CreateNewIssueHistory(IssueHistory newHistory);

        // IssueNotifications
        public abstract int CreateNewIssueNotification(IssueNotification newNotification);
        public abstract List<IssueNotification> GetIssueNotificationsByIssueId(int issueId);
        public abstract bool DeleteIssueNotification(int issueId, string username);

        //IssueRevisions
        public abstract int CreateNewIssueRevision(IssueRevision newIssueRevision);
        public abstract List<IssueRevision> GetIssueRevisionsByIssueId(int issueId);
        public abstract bool DeleteIssueRevision(int issueRevisionId);

        //IssueVote
        public abstract int CreateNewIssueVote(IssueVote newIssueVote);
        public abstract bool HasUserVoted(int issueId, string username);

        // Project
        public abstract int CreateNewProject(Project newProject);
        public abstract bool DeleteProject(int projectId);
        public abstract List<Project> GetAllProjects();
        public abstract Project GetProjectById(int projectId);
        public abstract List<Project> GetProjectsByMemberUserName(string username);
        public abstract List<Project> GetProjectsByMemberUserName(string userName, bool activeOnly);
        public abstract bool UpdateProject(Project projectToUpdate);
        public abstract bool AddUserToProject(string userName, int projectId);
        public abstract bool RemoveUserFromProject(string userName, int projectId);
        public abstract int CloneProject(int projectId, string projectName);
        public abstract Project GetProjectByCode(string projectCode);
        public abstract List<Project> GetPublicProjects();
        public abstract bool IsUserProjectMember(string userName, int projectId);
        public abstract List<RoadMapIssue> GetProjectRoadmap(int projectId);
        public abstract int[] GetProjectRoadmapProgress(int projectId, int milestoneId);
        public abstract List<Issue> GetProjectChangeLog(int projectId);
        public abstract List<MemberRoles> GetProjectMembersRoles(int projectId);
        public abstract ProjectImage GetProjectImageById(int projectId);
        public abstract bool DeleteProjectImage(int projectId);

        // Milestone
        public abstract int CreateNewMilestone(Milestone newMileStone);
        public abstract bool DeleteMilestone(int milestoneId);
        public abstract List<Milestone> GetMilestonesByProjectId(int projectId, bool notCompleted);
        public abstract List<Milestone> GetMilestonesByProjectId(int projectId);
        public abstract Milestone GetMilestoneById(int milestoneId);
        public abstract bool UpdateMilestone(Milestone milestoneToUpdate);
        public abstract bool CanDeleteMilestone(int milestoneId);

        // Project Mailbox
        public abstract ProjectMailbox GetProjectByMailbox(string mailbox);
        public abstract ProjectMailbox GetProjectMailboxByMailboxId(int projectMailboxId);
        public abstract List<ProjectMailbox> GetMailboxsByProjectId(int projectId);
        public abstract int CreateProjectMailbox(ProjectMailbox mailboxToUpdate);
        public abstract bool DeleteProjectMailbox(int mailboxId);
        public abstract bool UpdateProjectMailbox(ProjectMailbox mailboxToUpdate);

        // Status
        public abstract int CreateNewStatus(Status newStatus);
        public abstract bool UpdateStatus(Status statusToUpdate);
        public abstract bool DeleteStatus(int statusId);
        public abstract List<Status> GetStatusByProjectId(int projectId);
        public abstract Status GetStatusById(int statusId);
        public abstract bool CanDeleteStatus(int statusId);

        // Priority
        public abstract int CreateNewPriority(Priority newPriority);
        public abstract bool DeletePriority(int priorityId);
        public abstract List<Priority> GetPrioritiesByProjectId(int projectId);
        public abstract Priority GetPriorityById(int priorityId);
        public abstract bool UpdatePriority(Priority priorityToUpdate);
        public abstract bool CanDeletePriority(int priorityId);

        // Issue Type
        public abstract IssueType GetIssueTypeById(int issueTypeId);
        public abstract int CreateNewIssueType(IssueType issueTypeToCreate);
        public abstract bool DeleteIssueType(int issueTypeId);
        public abstract bool UpdateIssueType(IssueType issueTypeToUpdate);
        public abstract List<IssueType> GetIssueTypesByProjectId(int projectId);
        public abstract bool CanDeleteIssueType(int issueTypeId);

        // Resolution
        public abstract int CreateNewResolution(Resolution resolutionToCreate);
        public abstract bool DeleteResolution(int resolutionId);
        public abstract bool UpdateResolution(Resolution resolutionToUpdate);
        public abstract Resolution GetResolutionById(int resolutionId);
        public abstract List<Resolution> GetResolutionsByProjectId(int projectId);
        public abstract bool CanDeleteResolution(int ResolutionId);

        //Project Notifications
        public abstract int CreateNewProjectNotification(ProjectNotification newProjectNotification);
        public abstract List<ProjectNotification> GetProjectNotificationsByProjectId(int projectId);
        public abstract bool DeleteProjectNotification(int projectId, string username);
        public abstract List<ProjectNotification> GetProjectNotificationsByUsername(string username);

        //Users
        public abstract List<ITUser> GetUsersByProjectId(int projectId);

        // Role
        public abstract List<Role> GetAllRoles();
        public abstract bool UpdateRole(Role roleToUpdate);
        public abstract int CreateNewRole(Role newRole);
        public abstract bool RoleExists(string roleName, int projectId);
        public abstract List<Role> GetRolesByUserName(string userName, int projectId);
        public abstract bool RemoveUserFromRole(string userName, int roleId);
        public abstract bool AddUserToRole(string userName, int roleId);
        public abstract bool DeleteRole(int roleId);
        public abstract Role GetRoleById(int roleId);
        public abstract List<Role> GetRolesByUserName(string userName);
        public abstract List<Role> GetRolesByProject(int projectId);

        // Role Permissions
        public abstract List<Permission> GetAllPermissions();
        public abstract List<RolePermission> GetRolePermissions();
        public abstract List<Permission> GetPermissionsByRoleId(int roleId);
        public abstract bool DeletePermission(int roleId, int permissionId);
        public abstract bool AddPermission(int roleId, int permissionId);

        // Custom Fields
        public abstract List<CustomField> GetCustomFieldsByProjectId(int projectId);
        public abstract CustomField GetCustomFieldById(int customFieldId);
        public abstract List<CustomField> GetCustomFieldsByIssueId(int issueId);
        public abstract int CreateNewCustomField(CustomField newCustomField);
        public abstract bool UpdateCustomField(CustomField customFieldToUpdate);
        public abstract bool DeleteCustomField(int customFieldId);
        public abstract bool SaveCustomFieldValues(int issueId, List<CustomField> fields);

        // Custom Field Selections
        public abstract int CreateNewCustomFieldSelection(CustomFieldSelection newCustomFieldSelection);
        public abstract bool DeleteCustomFieldSelection(int customFieldSelectionId);
        public abstract List<CustomFieldSelection> GetCustomFieldSelectionsByCustomFieldId(int customFieldId);
        public abstract CustomFieldSelection GetCustomFieldSelectionById(int customFieldSelectionId);
        public abstract bool UpdateCustomFieldSelection(CustomFieldSelection customFieldSelectionToUpdate);

        // Host Settings
        public abstract List<HostSetting> GetHostSettings();
        public abstract bool UpdateHostSetting(string settingName, string settingValue);

        // Issue Work Reports
        public abstract int CreateNewIssueWorkReport(IssueWorkReport workReportToCreate);
        public abstract List<IssueWorkReport> GetIssueWorkReportsByIssueId(int issueId);
        public abstract bool DeleteIssueWorkReport(int issueWorkReportId);
        public abstract List<IssueWorkReport> GetIssueWorkReportsByProjectId(int projectId);
        public abstract List<IssueWorkReport> GetIssueWorkReportsByUserName(int projectId, string reporterUserName);

        // Application Log
        public abstract List<ApplicationLog> GetApplicationLog(string filterType);
        public abstract void ClearApplicationLog();

        //String Resources
        public abstract List<string> GetInstalledLanguageResources();
    }
}
