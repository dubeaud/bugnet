
 -- 20120421_Performance_Enhancements.sql
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
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = @ProjectId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
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
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = @ProjectId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
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
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
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
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
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


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_IssueAttachment_ValidateDownload]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_IssueAttachment_ValidateDownload]
GO

CREATE PROCEDURE [BugNet_IssueAttachment_ValidateDownload]
	@IssueAttachmentId INT,
	@RequestingUserId UNIQUEIDENTIFIER = NULL
AS

SET NOCOUNT ON

DECLARE
	@HasPermission BIT,
	@HasProjectAccess BIT,
	@ProjectAdminId INT,
	@ProjectId INT,
	@IssueId INT,
	@IssueVisibility INT,
	@ProjectAdminString VARCHAR(25),
	@ProjectAccessType INT,
	@ReturnValue INT,
	@AnonymousAccess BIT

SET @ProjectAdminString = 'project administrators'

/* get the anon setting for the site */
SET @AnonymousAccess = 
(
	SELECT 
		CASE LOWER(SUBSTRING(SettingValue, 1, 1))
			WHEN '1' THEN 1
			WHEN 't' THEN 1
			ELSE 0
		END
	FROM BugNet_HostSettings
	WHERE LOWER(SettingName) = 'anonymousaccess'
)

/* if the requesting user is anon and anon access is disabled exit */
IF (@RequestingUserId IS NULL AND @AnonymousAccess = 0)
	RETURN -1;
	
SELECT 
	@ProjectId = i.ProjectId,
	@IssueId = i.IssueId,
	@IssueVisibility = i.IssueVisibility,
	@ProjectAccessType = p.ProjectAccessType
FROM BugNet_IssuesView i
INNER JOIN BugNet_IssueAttachments ia ON i.IssueId = ia.IssueId
INNER JOIN BugNet_Projects p ON i.ProjectId = p.ProjectId
WHERE ia.IssueAttachmentId = @IssueAttachmentId
AND (i.[Disabled] = 0 AND p.ProjectDisabled = 0)

/* if the issue or project is disabled then exit */
IF (@IssueId IS NULL OR @ProjectId IS NULL)
	RETURN -1;

/* does the requesting user have elevated permissions? */
SET @HasPermission = 
(
	SELECT COUNT(*)
	FROM BugNet_UserRoles ur
	INNER JOIN BugNet_Roles r ON ur.RoleId = r.RoleId
	WHERE r.ProjectId = @ProjectId
	AND (LOWER(r.RoleName) = @ProjectAdminString OR r.RoleId = 1)
	AND ur.UserId = @RequestingUserId
)

/* does the requesting user have access to the project? */
SET @HasProjectAccess =
(
	SELECT COUNT(*)
	FROM BugNet_UserProjects
	WHERE UserId = @RequestingUserId
	AND ProjectId = @ProjectId
)

/* if the project is private and the requesting user does not have project access exit or elevated permissions */
IF (@ProjectAccessType = 2 AND (@HasProjectAccess = 0 AND @HasPermission = 0))
	RETURN -1;

/* try and get the attachment id */
SELECT @ReturnValue = ia.IssueAttachmentId
FROM BugNet_IssuesView i
INNER JOIN BugNet_IssueAttachments ia ON i.IssueId = ia.IssueId
INNER JOIN BugNet_Projects p ON i.ProjectId = p.ProjectId
WHERE ia.IssueAttachmentId = @IssueAttachmentId
AND (
		(@IssueVisibility = 0 AND @AnonymousAccess = 1) OR -- issue is visible and anon access is on
		(
			(@IssueVisibility = 1) AND -- issue is private
			(
				(UPPER(i.IssueCreatorUserId) = UPPER(@RequestingUserId)) OR -- requesting user is issue creator
				(UPPER(i.IssueAssignedUserId) = UPPER(@RequestingUserId) AND @AnonymousAccess = 0) OR -- requesting user is assigned to issue and anon access is off 
				(@HasPermission = 1) -- requesting user has elevated permissions
			)
		)
	)
AND (i.[Disabled] = 0 AND p.ProjectDisabled = 0)

IF (@ReturnValue IS NULL)
	RETURN -1;
	
RETURN @ReturnValue;
GO

-- 20120505_Attachment_Validation.sql
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_IssueAttachment_ValidateDownload]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_IssueAttachment_ValidateDownload]
GO

CREATE PROCEDURE [BugNet_IssueAttachment_ValidateDownload]
	@IssueAttachmentId INT,
	@RequestingUser VARCHAR(75) = NULL
AS

SET NOCOUNT ON

DECLARE
	@HasPermission BIT,
	@HasProjectAccess BIT,
	@ProjectAdminId INT,
	@ProjectId INT,
	@IssueId INT,
	@IssueVisibility INT,
	@ProjectAdminString VARCHAR(25),
	@ProjectAccessType INT,
	@ReturnValue INT,
	@AnonymousAccess BIT,
	@AttachmentExists BIT,
	@RequestingUserID UNIQUEIDENTIFIER
	
EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @RequestingUser, @UserId = @RequestingUserID OUTPUT

SET @ProjectAdminString = 'project administrators'

/* see if the attachment exists */
SET @AttachmentExists =
(
	SELECT COUNT(*) FROM BugNet_IssueAttachments WHERE IssueAttachmentId = @IssueAttachmentId
)

/* 
	if the attachment does not exist then exit
	return not found status
*/
IF (@AttachmentExists = 0)
BEGIN
	RAISERROR (N'BNCode:100 The requested attachment does not exist.', 17, 1);
	RETURN 0;
END
	
/* get the anon setting for the site */
SET @AnonymousAccess = 
(
	SELECT 
		CASE LOWER(SUBSTRING(SettingValue, 1, 1))
			WHEN '1' THEN 1
			WHEN 't' THEN 1
			ELSE 0
		END
	FROM BugNet_HostSettings
	WHERE LOWER(SettingName) = 'anonymousaccess'
)

/* 
	if the requesting user is anon and anon access is disabled exit
	and return login status
*/
IF (@RequestingUserId IS NULL AND @AnonymousAccess = 0)
BEGIN
	RAISERROR (N'BNCode:200 User is required to login before download.', 17, 1);
	RETURN 0;
END
	
SELECT 
	@ProjectId = i.ProjectId,
	@IssueId = i.IssueId,
	@IssueVisibility = i.IssueVisibility,
	@ProjectAccessType = p.ProjectAccessType
FROM BugNet_IssuesView i
INNER JOIN BugNet_IssueAttachments ia ON i.IssueId = ia.IssueId
INNER JOIN BugNet_Projects p ON i.ProjectId = p.ProjectId
WHERE ia.IssueAttachmentId = @IssueAttachmentId
AND (i.[Disabled] = 0 AND p.ProjectDisabled = 0)

/* 
	if the issue or project are disabled then exit
	return not found status
*/
IF (@IssueId IS NULL OR @ProjectId IS NULL)
BEGIN
	RAISERROR (N'BNCode:300 Either the Project or the Issue for this attachment are disabled.', 17, 1);
	RETURN 0;
END

/* does the requesting user have elevated permissions? */
SET @HasPermission = 
(
	SELECT COUNT(*)
	FROM BugNet_UserRoles ur
	INNER JOIN BugNet_Roles r ON ur.RoleId = r.RoleId
	WHERE (r.ProjectId = @ProjectId OR r.ProjectId IS NULL)
	AND (LOWER(r.RoleName) = @ProjectAdminString OR r.RoleId = 1)
	AND ur.UserId = @RequestingUserId
)

/* does the requesting user have access to the project? */
SET @HasProjectAccess =
(
	SELECT COUNT(*)
	FROM BugNet_UserProjects
	WHERE UserId = @RequestingUserId
	AND ProjectId = @ProjectId
)

/* if the project is private / requesting user does not have project access exit / elevated permissions */
/* user has no access */
IF (@ProjectAccessType = 2 AND (@HasProjectAccess = 0 AND @HasPermission = 0))
BEGIN
	RAISERROR (N'BNCode:400 Sorry you do not have access to this attachment.', 17, 1);
	RETURN 0;
END

/*
SELECT 
	@HasPermission AS '@HasPermission',
	@HasProjectAccess AS '@HasProjectAccess',
	@ProjectAdminId AS '@ProjectAdminId',
	@ProjectId AS '@ProjectId',
	@IssueId AS '@IssueId',
	@IssueVisibility AS '@IssueVisibility',
	@ProjectAdminString AS '@ProjectAdminString',
	@ProjectAccessType AS '@ProjectAccessType',
	@AnonymousAccess AS '@AnonymousAccess',
	@AttachmentExists AS '@AttachmentExists' ,
	@RequestingUserID AS '@RequestingUserID'
*/
	
/* try and get the attachment id */
SELECT @ReturnValue = ia.IssueAttachmentId
FROM BugNet_IssuesView i
INNER JOIN BugNet_IssueAttachments ia ON i.IssueId = ia.IssueId
INNER JOIN BugNet_Projects p ON i.ProjectId = p.ProjectId
WHERE ia.IssueAttachmentId = @IssueAttachmentId
AND (
		(@HasPermission = 1) OR -- requesting user has elevated permissions
		(@IssueVisibility = 0 AND @AnonymousAccess = 1) OR -- issue is visible and anon access is on
		(
			(@IssueVisibility = 1) AND -- issue is private
			(
				(UPPER(i.IssueCreatorUserId) = UPPER(@RequestingUserId)) OR -- requesting user is issue creator
				(UPPER(i.IssueAssignedUserId) = UPPER(@RequestingUserId) AND @AnonymousAccess = 0) -- requesting user is assigned to issue and anon access is off 
			) OR 
			(@IssueVisibility = 0) -- issue is visible show it
		)
	)
AND (i.[Disabled] = 0 AND p.ProjectDisabled = 0)

/* user still has no access */
IF (@ReturnValue IS NULL)
BEGIN
	RAISERROR (N'BNCode:400 Sorry you do not have access to this attachment.', 17, 1);
	RETURN 0;
END
	
RETURN @ReturnValue;
GO

-- 20120505_Missing_FKs.sql
/* PROJECT MAILBOXES */
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users] FOREIGN KEY([AssignToUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes] FOREIGN KEY([IssueTypeId])
REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]
GO

/* ISSUE VOTES */
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] DROP CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] DROP CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues]
GO

DELETE
FROM BugNet_IssueVotes
WHERE IssueId NOT IN (SELECT IssueId FROM BugNet_Issues)
GO

DELETE
FROM BugNet_IssueVotes
WHERE UserId NOT IN (SELECT UserId FROM aspnet_Users)
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues]
GO

-- 20120527-BugNet_Project_CloneProject.sql
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[BugNet_Project_CloneProject]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [BugNet_Project_CloneProject]
GO

CREATE PROCEDURE [BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256),
  @CloningUsername VARCHAR(75) = NULL
)
AS

DECLARE
	@CreatorUserId UNIQUEIDENTIFIER

SET NOCOUNT OFF

SET @CreatorUserId = (SELECT ProjectCreatorUserId FROM BugNet_Projects WHERE ProjectId = @ProjectId)

IF(@CloningUsername IS NOT NULL OR LTRIM(RTRIM(@CloningUsername)) != '')
	EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @CloningUsername, @UserId = @CreatorUserId OUTPUT

-- Copy Project
INSERT BugNet_Projects
(
  ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  DateCreated,
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl 
)
SELECT
  @ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  GetDate(),
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  @CreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl
FROM 
  BugNet_Projects
WHERE
  ProjectId = @ProjectId
  
DECLARE @NewProjectId INT
SET @NewProjectId = SCOPE_IDENTITY()

-- Copy Milestones
INSERT BugNet_ProjectMilestones
(
  ProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  DateCreated
)
SELECT
  @NewProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  GetDate()
FROM
  BugNet_ProjectMilestones
WHERE
  ProjectId = @ProjectId  

-- Copy Project Members
INSERT BugNet_UserProjects
(
  UserId,
  ProjectId,
  DateCreated
)
SELECT
  UserId,
  @NewProjectId,
  GetDate()
FROM
  BugNet_UserProjects
WHERE
  ProjectId = @ProjectId

-- Copy Project Roles
INSERT BugNet_Roles
( 
	ProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
)
SELECT 
	@NewProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId

CREATE TABLE #OldRoles
(
  OldRowNumber INT IDENTITY,
  OldRoleId INT,
)

INSERT #OldRoles
(
  OldRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId
ORDER BY 
	RoleId

CREATE TABLE #NewRoles
(
  NewRowNumber INT IDENTITY,
  NewRoleId INT,
)

INSERT #NewRoles
(
  NewRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @NewProjectId
ORDER BY 
	RoleId

INSERT BugNet_UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId = NewRoleId
FROM 
	#OldRoles 
INNER JOIN #NewRoles ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_UserRoles UR ON UR.RoleId = OldRoleId

-- Copy Role Permissions
INSERT BugNet_RolePermissions
(
   PermissionId,
   RoleId
)
SELECT Perm.PermissionId, NewRoles.RoleId
FROM BugNet_RolePermissions Perm
INNER JOIN BugNet_Roles OldRoles ON Perm.RoleId = OldRoles.RoleID
INNER JOIN BugNet_Roles NewRoles ON NewRoles.RoleName = OldRoles.RoleName
WHERE OldRoles.ProjectId = @ProjectId 
	  and NewRoles.ProjectId = @NewProjectId


-- Copy Custom Fields
INSERT BugNet_ProjectCustomFields
(
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
)
SELECT
  @NewProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
  
-- Copy Custom Field Selections
CREATE TABLE #OldCustomFields
(
  OldRowNumber INT IDENTITY,
  OldCustomFieldId INT,
)
INSERT #OldCustomFields
(
  OldCustomFieldId
)
SELECT
	CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
ORDER BY CustomFieldId

CREATE TABLE #NewCustomFields
(
  NewRowNumber INT IDENTITY,
  NewCustomFieldId INT,
)

INSERT #NewCustomFields
(
  NewCustomFieldId
)
SELECT
  CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @NewProjectId
ORDER BY CustomFieldId

INSERT BugNet_ProjectCustomFieldSelections
(
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
)
SELECT 
	CustomFieldId = NewCustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
FROM 
	#OldCustomFields 
INNER JOIN #NewCustomFields ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_ProjectCustomFieldSelections CFS ON CFS.CustomFieldId = OldCustomFieldId

-- Copy Project Mailboxes
INSERT BugNet_ProjectMailBoxes
(
  MailBox,
  ProjectId,
  AssignToUserId,
  IssueTypeId
)
SELECT
  Mailbox,
  @NewProjectId,
  AssignToUserId,
  IssueTypeId
FROM
  BugNet_ProjectMailBoxes
WHERE
  ProjectId = @ProjectId

-- Copy Categories
INSERT BugNet_ProjectCategories
(
  ProjectId,
  CategoryName,
  ParentCategoryId
)
SELECT
  @NewProjectId,
  CategoryName,
  ParentCategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId  


CREATE TABLE #OldCategories
(
  OldRowNumber INT IDENTITY,
  OldCategoryId INT,
)

INSERT #OldCategories
(
  OldCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId
ORDER BY CategoryId

CREATE TABLE #NewCategories
(
  NewRowNumber INT IDENTITY,
  NewCategoryId INT,
)

INSERT #NewCategories
(
  NewCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @NewProjectId
ORDER BY CategoryId

UPDATE BugNet_ProjectCategories SET
  ParentCategoryId = NewCategoryId
FROM
  #OldCategories INNER JOIN #NewCategories ON OldRowNumber = NewRowNumber
WHERE
  ProjectId = @NewProjectId
  And ParentCategoryID = OldCategoryId 

-- Copy Status's
INSERT BugNet_ProjectStatus
(
  ProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
)
SELECT
  @NewProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
FROM
  BugNet_ProjectStatus
WHERE
  ProjectId = @ProjectId 
 
-- Copy Priorities
INSERT BugNet_ProjectPriorities
(
  ProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
FROM
  BugNet_ProjectPriorities
WHERE
  ProjectId = @ProjectId 

-- Copy Resolutions
INSERT BugNet_ProjectResolutions
(
  ProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
FROM
  BugNet_ProjectResolutions
WHERE
  ProjectId = @ProjectId
 
-- Copy Issue Types
INSERT BugNet_ProjectIssueTypes
(
  ProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
FROM
  BugNet_ProjectIssueTypes
WHERE
  ProjectId = @ProjectId

-- Copy Project Notifications
INSERT BugNet_ProjectNotifications
(
  ProjectId,
  UserId
)
SELECT
  @NewProjectId,
  UserId
FROM
  BugNet_ProjectNotifications
WHERE
  ProjectId = @ProjectId

RETURN @NewProjectId 

GO

-- 20120609-CustomField-sproc-tweeks.sql
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomField_DeleteCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomField_DeleteCustomField]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
	@CustomFieldSelectionId INT,
	@CustomFieldId INT,
	@CustomFieldSelectionName NVARCHAR(50),
	@CustomFieldSelectionValue NVARCHAR(50),
	@CustomFieldSelectionSortOrder INT
AS

SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE 
	@OldSortOrder INT,
	@OldCustomFieldSelectionId INT,
	@OldSelectionValue NVARCHAR(50)

SELECT TOP 1 
	@OldSortOrder = CustomFieldSelectionSortOrder,
	@OldSelectionValue = CustomFieldSelectionValue
FROM BugNet_ProjectCustomFieldSelections 
WHERE CustomFieldSelectionId = @CustomFieldSelectionId

SET @OldCustomFieldSelectionId = (SELECT TOP 1 CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId)

UPDATE 
	BugNet_ProjectCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_ProjectCustomFieldSelections 
SET CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId

/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
IF (@OldSelectionValue != @CustomFieldSelectionValue)
BEGIN
	UPDATE BugNet_ProjectCustomFieldValues
	SET CustomFieldValue = @CustomFieldSelectionValue
	WHERE CustomFieldId = @CustomFieldId
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
	@CustomFieldSelectionIdToDelete INT
AS

SET XACT_ABORT ON

DECLARE
	@CustomFieldId INT

SET @CustomFieldId = (SELECT TOP 1 CustomFieldId 
						FROM BugNet_ProjectCustomFieldSelections 
						WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete)

BEGIN TRAN
	UPDATE BugNet_ProjectCustomFieldValues
	SET CustomFieldValue = NULL
	WHERE CustomFieldId = @CustomFieldId
							
	DELETE 
	FROM BugNet_ProjectCustomFieldSelections 
	WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete
COMMIT TRAN
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN
	DELETE 
	FROM BugNet_ProjectCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
GO

-- 20120610-IssueLastUpdated-sproc.sql
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_UpdateLastUpdated]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_UpdateLastUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_Issue_UpdateLastUpdated]
  @IssueId Int,
  @LastUpdateUserName NVARCHAR(255)
AS

SET NOCOUNT ON

DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
COMMIT TRAN
GO

-- 20120616-wrhighfield-updated.sql
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetMonitoredIssuesByUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetMonitoredIssuesByUserName]
GO

CREATE PROCEDURE [BugNet_Issue_GetMonitoredIssuesByUserName]
  @UserName NVARCHAR(255),
  @ExcludeClosedStatus BIT
AS

SET NOCOUNT ON

DECLARE @NotificationUserId  UNIQUEIDENTIFIER

EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @UserName, @UserId = @NotificationUserId OUTPUT

SELECT
	iv.*,
	bin.UserId AS NotificationUserId, 
	uv.UserName AS NotificationUserName, 
	uv.DisplayName AS NotificationDisplayName
FROM BugNet_IssuesView iv 
INNER JOIN BugNet_IssueNotifications bin ON iv.IssueId = bin.IssueId 
INNER JOIN BugNet_UserView uv ON bin.UserId = uv.UserId
WHERE bin.UserId = @NotificationUserId
AND iv.[Disabled] = 0
AND iv.ProjectDisabled = 0
AND ((@ExcludeClosedStatus = 0) OR (iv.IsClosed = 0))
GO

-- 20120621-wrhighfield-custom_field_selection_length.sql
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId INT,
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionName NVARCHAR(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM BugNet_ProjectCustomFieldSelections

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT BugNet_ProjectCustomFieldSelections
	(
		CustomFieldId,
		CustomFieldSelectionValue,
		CustomFieldSelectionName,
		CustomFieldSelectionSortOrder
	)
	VALUES
	(
		@CustomFieldId,
		@CustomFieldSelectionValue,
		@CustomFieldSelectionName,
		@CustomFieldSelectionSortOrder
		
	)

	RETURN scope_identity()
END
RETURN 0


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
	@CustomFieldSelectionId INT,
	@CustomFieldId INT,
	@CustomFieldSelectionName NVARCHAR(255),
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionSortOrder INT
AS

SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE 
	@OldSortOrder INT,
	@OldCustomFieldSelectionId INT,
	@OldSelectionValue NVARCHAR(255)

SELECT TOP 1 
	@OldSortOrder = CustomFieldSelectionSortOrder,
	@OldSelectionValue = CustomFieldSelectionValue
FROM BugNet_ProjectCustomFieldSelections 
WHERE CustomFieldSelectionId = @CustomFieldSelectionId

SET @OldCustomFieldSelectionId = (SELECT TOP 1 CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId)

UPDATE 
	BugNet_ProjectCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_ProjectCustomFieldSelections 
SET CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId

/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
IF (@OldSelectionValue != @CustomFieldSelectionValue)
BEGIN
	UPDATE BugNet_ProjectCustomFieldValues
	SET CustomFieldValue = @CustomFieldSelectionValue
	WHERE CustomFieldId = @CustomFieldId
END

GO

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections
	DROP CONSTRAINT FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections
	DROP CONSTRAINT DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder
GO
CREATE TABLE dbo.Tmp_BugNet_ProjectCustomFieldSelections
	(
	CustomFieldSelectionId int NOT NULL IDENTITY (1, 1),
	CustomFieldId int NOT NULL,
	CustomFieldSelectionValue nvarchar(255) NOT NULL,
	CustomFieldSelectionName nvarchar(255) NOT NULL,
	CustomFieldSelectionSortOrder int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder DEFAULT ((0)) FOR CustomFieldSelectionSortOrder
GO
SET IDENTITY_INSERT dbo.Tmp_BugNet_ProjectCustomFieldSelections ON
GO
IF EXISTS(SELECT * FROM dbo.BugNet_ProjectCustomFieldSelections)
	 EXEC('INSERT INTO dbo.Tmp_BugNet_ProjectCustomFieldSelections (CustomFieldSelectionId, CustomFieldId, CustomFieldSelectionValue, CustomFieldSelectionName, CustomFieldSelectionSortOrder)
		SELECT CustomFieldSelectionId, CustomFieldId, CONVERT(nvarchar(255), CustomFieldSelectionValue), CONVERT(nvarchar(255), CustomFieldSelectionName), CustomFieldSelectionSortOrder FROM dbo.BugNet_ProjectCustomFieldSelections WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_BugNet_ProjectCustomFieldSelections OFF
GO
DROP TABLE dbo.BugNet_ProjectCustomFieldSelections
GO
EXECUTE sp_rename N'dbo.Tmp_BugNet_ProjectCustomFieldSelections', N'BugNet_ProjectCustomFieldSelections', 'OBJECT' 
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	PK_BugNet_ProjectCustomFieldSelections PRIMARY KEY CLUSTERED 
	(
	CustomFieldSelectionId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields FOREIGN KEY
	(
	CustomFieldId
	) REFERENCES dbo.BugNet_ProjectCustomFields
	(
	CustomFieldId
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
COMMIT
GO

UPDATE BugNet_ProjectCustomFieldSelections
SET CustomFieldSelectionValue = RTRIM(LTRIM(CustomFieldSelectionValue)),
	CustomFieldSelectionName = RTRIM(LTRIM(CustomFieldSelectionName))

-- 20120623-wrhighfield-IssueCommentsView.sql
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssueCommentsView]'))
DROP VIEW [BugNet_IssueCommentsView]
GO

CREATE VIEW [BugNet_IssueCommentsView]
AS
SELECT     dbo.BugNet_IssueComments.IssueCommentId, dbo.BugNet_IssueComments.IssueId, dbo.BugNet_IssuesView.ProjectId, dbo.BugNet_IssueComments.Comment, 
					  dbo.BugNet_IssueComments.DateCreated, dbo.BugNet_UserView.UserId AS CreatorUserId, dbo.BugNet_UserView.DisplayName AS CreatorDisplayName, 
					  dbo.BugNet_UserView.UserName AS CreatorUserName, dbo.BugNet_IssuesView.Disabled AS IssueDisabled, dbo.BugNet_IssuesView.IsClosed AS IssueIsClosed, 
					  dbo.BugNet_IssuesView.IssueVisibility, dbo.BugNet_IssuesView.ProjectCode, dbo.BugNet_IssuesView.ProjectName, dbo.BugNet_IssuesView.ProjectDisabled
FROM         dbo.BugNet_IssuesView INNER JOIN
					  dbo.BugNet_IssueComments ON dbo.BugNet_IssuesView.IssueId = dbo.BugNet_IssueComments.IssueId INNER JOIN
					  dbo.BugNet_UserView ON dbo.BugNet_IssueComments.UserId = dbo.BugNet_UserView.UserId

GO
