CREATE VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
AS
SELECT     
	dbo.BugNet_Issues.IssueId, 
	dbo.BugNet_Issues.Disabled, 
	dbo.BugNet_Issues.IssueTitle, 
	dbo.BugNet_Issues.IssueDescription, 
	dbo.BugNet_Issues.IssueStatusId,
	dbo.BugNet_Issues.IssuePriorityId, 
	dbo.BugNet_Issues.IssueTypeId, 
	dbo.BugNet_Issues.IssueCategoryId, 
	dbo.BugNet_Issues.ProjectId, 
	dbo.BugNet_Issues.IssueResolutionId, 
	dbo.BugNet_Issues.IssueCreatorUserId, 
	dbo.BugNet_Issues.IssueAssignedUserId, 
	dbo.BugNet_Issues.IssueAffectedMilestoneId, 
	dbo.BugNet_Issues.IssueOwnerUserId, 
	dbo.BugNet_Issues.IssueDueDate, 
	dbo.BugNet_Issues.IssueMilestoneId, 
	dbo.BugNet_Issues.IssueVisibility, 
	dbo.BugNet_Issues.IssueEstimation, 
	dbo.BugNet_Issues.DateCreated, 
	dbo.BugNet_Issues.LastUpdate, 
	dbo.BugNet_Issues.LastUpdateUserId, 
	dbo.BugNet_Projects.ProjectName, 
	dbo.BugNet_Projects.ProjectCode, 
	ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'none') AS PriorityName, 
	ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName,N'none') AS IssueTypeName, 
	ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'none') AS CategoryName, 
	ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'none') AS StatusName ,
	ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'none') AS MilestoneName, 
	ISNULL(AffectedMilestone.MilestoneName, N'none') AS AffectedMilestoneName, 
	ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'none') AS ResolutionName, 
	LastUpdateUsers.UserName AS LastUpdateUserName, 
	ISNULL(AssignedUsers.UserName, N'none') AS AssignedUserName, 
	ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
	CreatorUsers.UserName AS CreatorUserName, 
	ISNULL(CreatorUsersProfile.DisplayName, N'none') AS CreatorDisplayName, 
	ISNULL(OwnerUsers.UserName, 'none') AS OwnerUserName, 
	ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
	ISNULL(LastUpdateUsersProfile.DisplayName, 'none') AS LastUpdateDisplayName, 
	ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
	ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, 
	ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
	ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, 
	ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, 
	ISNULL(AffectedMilestone.MilestoneImageUrl, '') 
	AS AffectedMilestoneImageUrl, ISNULL
		((SELECT     SUM(Duration) AS Expr1
			FROM         dbo.BugNet_IssueWorkReports AS WR
			WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
		((SELECT     COUNT(IssueId) AS Expr1
			FROM         dbo.BugNet_IssueVotes AS V
			WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes,
	dbo.BugNet_ProjectCustomFields.CustomFieldName, 
	dbo.BugNet_ProjectCustomFieldValues.CustomFieldValue, 
	dbo.BugNet_Issues.IssueProgress, 
	dbo.BugNet_ProjectMilestones.MilestoneDueDate, 
	dbo.BugNet_Projects.ProjectDisabled, 
	CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) AS IsClosed
FROM         
	dbo.BugNet_ProjectCustomFields 
INNER JOIN
	dbo.BugNet_ProjectCustomFieldValues ON dbo.BugNet_ProjectCustomFields.CustomFieldId = dbo.BugNet_ProjectCustomFieldValues.CustomFieldId 
RIGHT OUTER JOIN
	dbo.BugNet_Issues ON dbo.BugNet_ProjectCustomFieldValues.IssueId = dbo.BugNet_Issues.IssueId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId 
LEFT OUTER JOIN
    dbo.Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
