

CREATE VIEW [dbo].[BugNet_IssuesView]
AS
SELECT        dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, 
                         dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, 
                         dbo.BugNet_Issues.IssueOwnerUserId, dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                         dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, dbo.BugNet_Projects.ProjectName, 
                         dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') 
                         AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, 
                         ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'Unassigned') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, 
                         ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, ISNULL(AssignedUsers.UserName, N'Unassigned') 
                         AS AssignedUserName, ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, 
                         N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 'Unassigned') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, 
                         ISNULL(LastUpdateUsersProfile.DisplayName, 'Unassigned') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                         ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                         ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, 
                         ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 0) AS StatusSortOrder, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 0) 
                         AS PrioritySortOrder, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 0) AS IssueTypeSortOrder, ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 0) AS MilestoneSortOrder, 
                         ISNULL(AffectedMilestone.SortOrder, 0) AS AffectedMilestoneSortOrder, ISNULL(dbo.BugNet_ProjectResolutions.SortOrder, 0) AS ResolutionSortOrder, ISNULL
                             ((SELECT        SUM(Duration) AS Expr1
                                 FROM            dbo.BugNet_IssueWorkReports AS WR
                                 WHERE        (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                             ((SELECT        COUNT(IssueId) AS Expr1
                                 FROM            dbo.BugNet_IssueVotes AS V
                                 WHERE        (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, dbo.BugNet_ProjectMilestones.MilestoneDueDate, 
                         dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) AS IsClosed, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.LastUpdate, 112) AS DATETIME) 
                         AS LastUpdateAsDate, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.DateCreated, 112) AS DATETIME) AS DateCreatedAsDate
FROM            dbo.BugNet_Issues LEFT OUTER JOIN
                         dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                         dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                         dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                         dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                         dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                         dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                         dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                         dbo.AspNetUsers AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.Id LEFT OUTER JOIN
                         dbo.AspNetUsers AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.Id LEFT OUTER JOIN
                         dbo.AspNetUsers AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.Id LEFT OUTER JOIN
                         dbo.AspNetUsers AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.Id LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId


