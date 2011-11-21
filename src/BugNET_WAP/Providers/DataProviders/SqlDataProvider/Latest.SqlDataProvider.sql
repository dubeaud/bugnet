/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO
/* Create new category disabled column */
ALTER TABLE [dbo].[BugNet_ProjectCategories] ADD [Disabled] [bit] DEFAULT 0 NOT NULL
GO

ALTER TABLE [dbo].[BugNet_Issues] ALTER COLUMN [IssueStatusId] [int] NULL
GO

ALTER TABLE [dbo].[BugNet_Issues] ALTER COLUMN [IssuePriorityId] [int] NULL
GO

ALTER TABLE [dbo].[BugNet_Issues] ALTER COLUMN [IssueTypeId] [int] NULL
GO


/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_DeleteCategory]    Script Date: 02/16/2011 13:01:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId Int 
AS
UPDATE BugNet_ProjectCategories SET
	[Disabled] = 1
WHERE
	CategoryId = @CategoryId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]    Script Date: 02/16/2011 13:01:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount,
	Disabled
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId AND [Disabled] = 0
ORDER BY CategoryName


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]    Script Date: 02/16/2011 13:02:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
c.ParentCategoryId = @CategoryId AND [Disabled] = 0
ORDER BY CategoryName


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]    Script Date: 02/16/2011 13:03:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId AND c.ParentCategoryId = 0 AND [Disabled] = 0
ORDER BY CategoryName

GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]    Script Date: 02/16/2011 12:44:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]
	@MailBox nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeID int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM aspnet_users WHERE Username = @AssignToUserName
	
INSERT BugNet_ProjectMailBoxes 
(
	MailBox,
	ProjectId,
	AssignToUserId,
	IssueTypeID
)
VALUES
(
	@MailBox,
	@ProjectId,
	@AssignToUserId,
	@IssueTypeId
)
RETURN scope_identity()
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]    Script Date: 02/16/2011 12:44:55 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]
	@ProjectMailboxId int
AS
DELETE  
	BugNet_ProjectMailBoxes 
WHERE
	ProjectMailboxId = @ProjectMailboxId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]    Script Date: 02/16/2011 12:45:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId int
AS

SELECT BugNet_ProjectMailboxes.*,
	u.Username AssignToUserName,
	p.DisplayName AssignToDisplayName,
	BugNet_ProjectIssueTypes.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes ON BugNet_ProjectIssueTypes.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]    Script Date: 02/16/2011 12:45:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
    (
    @mailbox nvarchar(256)
    )
    
AS
    SET NOCOUNT ON
    
SELECT     BugNet_ProjectMailBoxes.MailBox, BugNet_ProjectMailBoxes.ProjectMailboxId, BugNet_ProjectMailBoxes.ProjectId,
                      BugNet_ProjectMailBoxes.IssueTypeId, Users.UserName AS AssignToName, BugNet_ProjectMailBoxes.AssignToUserId,
                      BugNet_ProjectIssueTypes.IssueTypeName
FROM         BugNet_Projects INNER JOIN
                      BugNet_ProjectMailBoxes ON BugNet_ProjectMailBoxes.ProjectId = BugNet_Projects.ProjectId INNER JOIN
                      aspnet_Users AS Users ON BugNet_ProjectMailBoxes.AssignToUserId = Users.UserId INNER JOIN
                      BugNet_ProjectIssueTypes ON BugNet_Projects.ProjectId = BugNet_ProjectIssueTypes.ProjectId AND
                      BugNet_ProjectMailBoxes.IssueTypeId = BugNet_ProjectIssueTypes.IssueTypeId
WHERE     (BugNet_ProjectMailBoxes.MailBox = @mailbox)


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]    Script Date: 02/16/2011 12:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]
	@ProjectMailboxId int,
	@MailBoxEmailAddress nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeId int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM aspnet_users WHERE Username = @AssignToUserName

UPDATE BugNet_ProjectMailBoxes SET
	MailBox = @MailBoxEmailAddress,
	ProjectId = @ProjectId,
	AssignToUserId = @AssignToUserId,
	IssueTypeId = @IssueTypeId
WHERE ProjectMailboxId = @ProjectMailboxId
GO

UPDATE BugNet_HostSettings SET SettingName = 'UserRegistration' WHERE SettingName = 'DisableUserRegistration'
UPDATE BugNet_HostSettings SET SettingValue = '0' WHERE SettingName ='UserRegistration'
UPDATE BugNet_HostSettings SET SettingName = 'AnonymousAccess' WHERE SettingName = 'DisableAnonymousAccess'
UPDATE BugNet_HostSettings SET SettingValue = 'False' WHERE SettingName ='AnonymousAccess'
GO

DROP TABLE [dbo].[BugNet_StringResources]
GO

CREATE TABLE [dbo].[BugNet_Languages] (
		[LanguageId]          int NOT NULL IDENTITY(1, 1),
		[CultureCode]         nvarchar(50) NOT NULL,
		[CultureName]         nvarchar(200) NOT NULL,
		[FallbackCulture]     nvarchar(50) NULL
)
GO

ALTER TABLE [dbo].[BugNet_Languages]
	ADD
	CONSTRAINT [PK_BugNet_Languages]
	PRIMARY KEY
	([LanguageId])
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_BugNet_Languages ON [dbo].[BugNet_Languages] ( CultureCode )
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Languages_GetInstalledLanguages]    Script Date: 04/15/2011 12:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Languages_GetInstalledLanguages]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT cultureCode FROM BugNet_Languages
END
GO

DROP PROCEDURE [dbo].[BugNet_StringResources_GetInstalledLanguageResources]
GO

INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('ApplicationDefaultLanguage','en-US')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('Pop3ProcessAttachments','False')
INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('en-US', 'English (United States)', 'en')

PRINT N'Updating Permission keys'
UPDATE BugNet_Permissions SET PermissionKey = 'CloseIssue' WHERE PermissionId = 1
UPDATE BugNet_Permissions SET PermissionKey = 'AddIssue' WHERE PermissionId = 2
UPDATE BugNet_Permissions SET PermissionKey = 'AssignIssue' WHERE PermissionId = 3
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssue' WHERE PermissionId = 4
UPDATE BugNet_Permissions SET PermissionKey = 'SubscribeIssue' WHERE PermissionId = 5
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteIssue' WHERE PermissionId = 6
UPDATE BugNet_Permissions SET PermissionKey = 'AddComment' WHERE PermissionId = 7
UPDATE BugNet_Permissions SET PermissionKey = 'EditComment' WHERE PermissionId = 8
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteComment' WHERE PermissionId = 9
UPDATE BugNet_Permissions SET PermissionKey = 'AddAttachment' WHERE PermissionId = 10
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteAttachment' WHERE PermissionId = 11
UPDATE BugNet_Permissions SET PermissionKey = 'AddRelated' WHERE PermissionId = 12
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteRelated' WHERE PermissionId = 13
UPDATE BugNet_Permissions SET PermissionKey = 'ReopenIssue' WHERE PermissionId = 14
UPDATE BugNet_Permissions SET PermissionKey = 'OwnerEditComment' WHERE PermissionId = 15
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssueDescription' WHERE PermissionId = 16
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssueTitle' WHERE PermissionId = 17
UPDATE BugNet_Permissions SET PermissionKey = 'AdminEditProject' WHERE PermissionId = 18
UPDATE BugNet_Permissions SET PermissionKey = 'AddTimeEntry' WHERE PermissionId = 19
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteTimeEntry' WHERE PermissionId = 20
UPDATE BugNet_Permissions SET PermissionKey = 'AdminCreateProject' WHERE PermissionId = 21
UPDATE BugNet_Permissions SET PermissionKey = 'AddQuery' WHERE PermissionId = 22
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteQuery' WHERE PermissionId = 23
UPDATE BugNet_Permissions SET PermissionKey = 'AdminCloneProject' WHERE PermissionId = 24
UPDATE BugNet_Permissions SET PermissionKey = 'AddSubIssue' WHERE PermissionId = 25
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteSubIssue' WHERE PermissionId = 26
UPDATE BugNet_Permissions SET PermissionKey = 'AddParentIssue' WHERE PermissionId = 27
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteParentIssue' WHERE PermissionId = 28
UPDATE BugNet_Permissions SET PermissionKey = 'AdminDeleteProject' WHERE PermissionId = 29
UPDATE BugNet_Permissions SET PermissionKey = 'ViewProjectCalendar' WHERE PermissionId = 30
UPDATE BugNet_Permissions SET PermissionKey = 'ChangeIssueStatus' WHERE PermissionId = 31
UPDATE BugNet_Permissions SET PermissionKey = 'EditQuery' WHERE PermissionId = 32
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_GetIssuesByProjectIdAndCustomFieldView]'))
DROP VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssuesView]'))
DROP VIEW [dbo].[BugNet_IssuesView]
GO

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
	ISNULL(AssignedUsers.UserName, N'none') AS AssignedUsername, 
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
    dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId 
LEFT OUTER JOIN
    dbo.aspnet_Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId 
LEFT OUTER JOIN
    dbo.aspnet_Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId 
LEFT OUTER JOIN
    dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId 
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

GO

CREATE VIEW [dbo].[BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, dbo.BugNet_Issues.IssueOwnerUserId, 
                      dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                      dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, 
                      dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'none') AS PriorityName, 
					  ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName,N'none') AS IssueTypeName, 
                      ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'none') AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'none') AS StatusName, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'none') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'none') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'none') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N'none') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N'none') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 'none') 
                      AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, 'none') 
                      AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') 
                      AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate, 
					  dbo.BugNet_Projects.ProjectDisabled, 
					  CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) AS IsClosed
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Project_GetRoadMap]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
	@ProjectId int
AS
SELECT 
	PM.SortOrder AS MilestoneSortOrder,
	IssueId, 
	IssueTitle, 
	IssueDescription, 
	IssueStatusId, 
	IssuePriorityId, 
	IssueTypeId, 
	IssueCategoryId, 
	BugNet_IssuesView.ProjectId, 
	IssueResolutionId, 
	IssueCreatorUserId, 
	IssueAssignedUserId, 
	IssueOwnerUserId, 
	IssueDueDate, 
	BugNet_IssuesView.IssueMilestoneId, 
	IssueVisibility, 
	BugNet_IssuesView.DateCreated, 
	IssueEstimation, 
	LastUpdate, 
	LastUpdateUserId, 
	ProjectName, 
	ProjectCode, 
	PriorityName, 
	IssueTypeName, 
	CategoryName, 
	StatusName, 
	ResolutionName, 
	BugNet_IssuesView.MilestoneName, 
	BugNet_IssuesView.MilestoneDueDate,
	IssueAffectedMilestoneId, 
	AffectedMilestoneName,
	AffectedMilestoneImageUrl,
	LastUpdateUserName, 
	AssignedUserName, 
	AssignedDisplayName, 
	CreatorUserName, 
	CreatorDisplayName, 
	OwnerUserName, 
	OwnerDisplayName, 
	LastUpdateDisplayName, 
	PriorityImageUrl, 
	IssueTypeImageUrl, 
	StatusImageUrl, 
	BugNet_IssuesView.MilestoneImageUrl, 
	ResolutionImageUrl, 
	TimeLogged, 
	IssueProgress, 
	[Disabled], 
	IssueVotes,
	IsClosed
FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM on IssueMilestoneId = MilestoneId 
WHERE 
	BugNet_IssuesView.ProjectId = @ProjectId AND BugNet_IssuesView.Disabled = 0
AND 
	IssueMilestoneId IN (SELECT DISTINCT IssueMilestoneId FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId))
ORDER BY 
	(CASE WHEN PM.SortOrder IS NULL THEN 1 ELSE 0 END),PM.SortOrder , IssueStatusId ASC, IssueTypeId ASC,IssueCategoryId ASC, AssignedUserName ASC
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectMailbox_GetMailboxById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxById]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectMailbox_GetMailboxByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectMailbox_GetProjectByMailbox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxById]
    @ProjectMailboxId int
AS

SET NOCOUNT ON
    
SELECT 
	BugNet_ProjectMailboxes.*,
	u.Username AssignToUserName,
	p.DisplayName AssignToDisplayName,
	BugNet_ProjectIssueTypes.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes ON BugNet_ProjectIssueTypes.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.ProjectMailboxId = @ProjectMailboxId
GO

CREATE  PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId int
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.Username AssignToUserName,
	p.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId		
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
    @mailbox nvarchar(100) 
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.Username AssignToUserName,
	p.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.MailBox = @mailbox
GO

CREATE PROCEDURE [BugNet_ProjectStatus_CanDeleteStatus]
	@StatusId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectStatus WHERE StatusId = @StatusId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueStatusId = @StatusId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [BugNet_ProjectPriorities_CanDeletePriority]
	@PriorityId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssuePriorityId = @PriorityId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [BugNet_ProjectResolutions_CanDeleteResolution]
	@ResolutionId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueResolutionId = @ResolutionId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [BugNet_ProjectIssueTypes_CanDeleteIssueType]
	@IssueTypeId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueTypeId = @IssueTypeId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [BugNet_ProjectMilestones_CanDeleteMilestone]
	@MilestoneId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE ((IssueMilestoneId = @MilestoneId) OR (IssueAffectedMilestoneId = @MilestoneId))
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0


GO

COMMIT

SET NOEXEC OFF
GO