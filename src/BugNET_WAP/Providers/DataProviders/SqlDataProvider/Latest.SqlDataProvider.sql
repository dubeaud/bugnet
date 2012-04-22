USE BugNET
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssueMilestoneCountView]'))
DROP VIEW [BugNet_IssueMilestoneCountView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_UserView]'))
DROP VIEW [BugNet_UserView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_Issue_IssueTypeCountView]'))
DROP VIEW [BugNet_Issue_IssueTypeCountView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssueStatusCountView]'))
DROP VIEW [BugNet_IssueStatusCountView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssuePriorityCountView]'))
DROP VIEW [BugNet_IssuePriorityCountView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssuesView]'))
DROP VIEW [BugNet_IssuesView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssueAssignedToCountView]'))
DROP VIEW [BugNet_IssueAssignedToCountView]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [BugNet_UserView]
AS
SELECT     dbo.aspnet_Users.UserId, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.aspnet_Users.LoweredUserName AS UserName, dbo.aspnet_Users.MobileAlias, dbo.aspnet_Membership.LoweredEmail AS Email, 
                      dbo.aspnet_Membership.IsApproved, dbo.aspnet_Membership.IsLockedOut, dbo.aspnet_Users.IsAnonymous, dbo.aspnet_Membership.MobilePIN, 
                      dbo.aspnet_Users.LastActivityDate, dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
FROM         dbo.aspnet_Users INNER JOIN
                      dbo.aspnet_Membership ON dbo.aspnet_Users.UserId = dbo.aspnet_Membership.UserId INNER JOIN
                      dbo.BugNet_UserProfiles ON dbo.aspnet_Users.UserName = dbo.BugNet_UserProfiles.UserName
GROUP BY dbo.aspnet_Users.UserId, dbo.aspnet_Users.LoweredUserName, dbo.aspnet_Users.MobileAlias, dbo.aspnet_Membership.LoweredEmail, 
                      dbo.aspnet_Membership.MobilePIN, dbo.aspnet_Membership.IsApproved, dbo.aspnet_Membership.IsLockedOut, dbo.aspnet_Users.IsAnonymous, 
                      dbo.aspnet_Users.LastActivityDate, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, dbo.BugNet_Issues.IssueOwnerUserId, 
                      dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                      dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, 
                      dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') 
                      AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'Unassigned') 
                      AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') 
                      AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, ISNULL(AssignedUsers.UserName, N'Unassigned') AS AssignedUsername, 
                      ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, CreatorUsers.UserName AS CreatorUserName, 
                      ISNULL(CreatorUsersProfile.DisplayName, N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 'Unassigned') AS OwnerUserName, 
                      ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, 'Unassigned') AS LastUpdateDisplayName, 
                      ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, 
                      ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '') 
                      AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate, dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) 
                      AS IsClosed
FROM         dbo.BugNet_Issues LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId




GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [BugNet_IssueMilestoneCountView]
AS
SELECT     dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueMilestoneId, 0) AS MilestoneId, dbo.BugNet_IssuesView.MilestoneName, 
                      dbo.BugNet_IssuesView.MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 99999) AS SortOrder, 
                      COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_IssuesView.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId
WHERE     (dbo.BugNet_IssuesView.Disabled = 0) AND (dbo.BugNet_IssuesView.IsClosed = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueMilestoneId, 0), ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 99999), 
                      dbo.BugNet_IssuesView.MilestoneName, dbo.BugNet_IssuesView.MilestoneImageUrl

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BugNet_Issue_IssueTypeCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueTypeId, 0) AS IssueTypeId, dbo.BugNet_IssuesView.IssueTypeName, 
                      dbo.BugNet_IssuesView.IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_IssuesView.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId
WHERE     (dbo.BugNet_IssuesView.IsClosed = 0) AND (dbo.BugNet_IssuesView.Disabled = 0)
GROUP BY dbo.BugNet_IssuesView.IssueTypeName, dbo.BugNet_IssuesView.IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 99), 
                      dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueTypeId, 0)
ORDER BY dbo.BugNet_IssuesView.ProjectId


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [BugNet_IssueStatusCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueStatusId, 0) AS StatusId, dbo.BugNet_IssuesView.StatusName, 
                      dbo.BugNet_IssuesView.StatusImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_IssuesView.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId
GROUP BY dbo.BugNet_IssuesView.StatusName, dbo.BugNet_IssuesView.StatusImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 99), dbo.BugNet_IssuesView.ProjectId, 
                      dbo.BugNet_IssuesView.Disabled, ISNULL(dbo.BugNet_IssuesView.IssueStatusId, 0)
HAVING      (dbo.BugNet_IssuesView.Disabled = 0)
ORDER BY dbo.BugNet_IssuesView.ProjectId



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BugNet_IssuePriorityCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssuePriorityId, '0') AS PriorityId, dbo.BugNet_IssuesView.PriorityName, 
                      dbo.BugNet_IssuesView.PriorityImageUrl, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_IssuesView.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId
WHERE     (dbo.BugNet_IssuesView.Disabled = 0) AND (dbo.BugNet_IssuesView.IsClosed = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssuePriorityId, '0'), dbo.BugNet_IssuesView.PriorityName, 
                      dbo.BugNet_IssuesView.PriorityImageUrl, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 99)
ORDER BY dbo.BugNet_IssuesView.ProjectId


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [BugNet_IssueAssignedToCountView]
AS
SELECT     dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueAssignedUserId, '00000000-0000-0000-0000-000000000000') AS AssignedUserId, 
                      dbo.BugNet_IssuesView.AssignedDisplayName AS AssignedName, '' AS AssignedImageUrl, CASE WHEN dbo.BugNet_IssuesView.IssueAssignedUserId IS NULL 
                      THEN 999 ELSE 0 END AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_UserView ON dbo.BugNet_IssuesView.IssueAssignedUserId = dbo.BugNet_UserView.UserId
WHERE     (dbo.BugNet_IssuesView.IsClosed = 0) AND (dbo.BugNet_IssuesView.Disabled = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, dbo.BugNet_IssuesView.AssignedDisplayName, CASE WHEN dbo.BugNet_IssuesView.IssueAssignedUserId IS NULL 
                      THEN 999 ELSE 0 END, ISNULL(dbo.BugNet_IssuesView.IssueAssignedUserId, '00000000-0000-0000-0000-000000000000')

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssueMilestoneCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssueMilestoneCountByProject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssueTypeCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssueTypeCountByProject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssuePriorityCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssuePriorityCountByProject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssueStatusCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssueStatusCountByProject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCategories_GetRootCategoriesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCategories_GetRootCategoriesByProjectId]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCategories_GetCategoriesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCategories_GetCategoriesByProjectId]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssueCategoryCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssueCategoryCountByProject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCategories_GetCategoryById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCategories_GetCategoryById]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_User_GetUserIdByUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_User_GetUserIdByUserName]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetIssueUserCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetIssueUserCountByProject]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_Issue_GetIssueUserCountByProject]
 @ProjectId int
AS

SELECT 
	AssignedName,
	Number,	
	AssignedUserId,
	AssignedImageUrl
FROM BugNet_IssueAssignedToCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder, AssignedName

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS

SELECT 
	MilestoneName,
	Number,	
	MilestoneId,
	MilestoneImageUrl
FROM BugNet_IssueMilestoneCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS

SELECT 
	IssueTypeName,
	Number,	
	IssueTypeId,
	IssueTypeImageUrl
FROM BugNet_Issue_IssueTypeCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_Issue_GetIssuePriorityCountByProject]
	@ProjectId int
AS

SELECT 
	PriorityName,
	Number,	
	PriorityId,
	PriorityImageUrl
FROM BugNet_IssuePriorityCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
SELECT 
	StatusName,
	Number,	
	StatusId,
	StatusImageUrl
FROM BugNet_IssueStatusCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_ProjectCategories_GetRootCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = 96 AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE ProjectId = @ProjectId 
AND c.ParentCategoryId = 0 
AND [Disabled] = 0
ORDER BY CategoryName




GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_ProjectCategories_GetCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = 96 AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE ProjectId = @ProjectId 
AND [Disabled] = 0
ORDER BY CategoryName




GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = 96 AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE c.ParentCategoryId = @CategoryId 
AND [Disabled] = 0
ORDER BY CategoryName





GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [BugNet_Issue_GetIssueCategoryCountByProject]
	@ProjectId int,
	@CategoryId int = NULL
AS

SELECT 
	COUNT(IssueId)
FROM
	BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND 
		(
			(@CategoryId IS NULL AND IssueCategoryId IS NULL) OR 
			(IssueCategoryId = @CategoryId)
		) 
	AND [Disabled] = 0
	AND IsClosed = 0



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_ProjectCategories_GetCategoryById]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = 96 AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE CategoryId = @CategoryId






GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_User_GetUserIdByUserName]
	@UserName NVARCHAR(75),
	@UserId UNIQUEIDENTIFIER OUTPUT
AS

SET NOCOUNT ON

SELECT @UserId = UserId
FROM aspnet_Users
WHERE LoweredUserName = LOWER(@UserName)

GO


