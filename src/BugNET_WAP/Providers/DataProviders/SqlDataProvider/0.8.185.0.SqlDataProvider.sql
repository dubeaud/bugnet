/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: April 14th, 2010 20:14:22		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

ALTER TABLE BugNet_ProjectMilestones
ADD MilestoneReleaseDate datetime
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
 @MilestoneId INT
AS
SELECT
	MilestoneId,
	ProjectId,
	MilestoneName,
	MilestoneImageUrl,
	SortOrder,
	MilestoneDueDate,
	MilestoneReleaseDate
FROM 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneId
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
 	@ProjectId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME
AS
IF NOT EXISTS(SELECT MilestoneId  FROM BugNet_ProjectMilestones WHERE LOWER(MilestoneName)= LOWER(@MilestoneName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectMilestones 
	(
		ProjectId, 
		MilestoneName ,
		MilestoneImageUrl,
		SortOrder,
		MilestoneDueDate,
		MilestoneReleaseDate
	) VALUES (
		@ProjectId, 
		@MilestoneName,
		@MilestoneImageUrl,
		@SortOrder,
		@MilestoneDueDate,
		@MilestoneReleaseDate
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
	@ProjectId int,
	@MilestoneId int,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@SortOrder int,
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME
AS

DECLARE @OldSortOrder int
DECLARE @OldMilestoneId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId
SELECT @OldMilestoneId = MilestoneId FROM BugNet_ProjectMilestones WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectMilestones SET
	ProjectId = @ProjectId,
	MilestoneName = @MilestoneName,
	MilestoneImageUrl = @MilestoneImageUrl,
	SortOrder = @SortOrder,
	MilestoneDueDate = @MilestoneDueDate,
	MilestoneReleaseDate = @MilestoneReleaseDate
WHERE MilestoneId = @MilestoneId

UPDATE BugNet_ProjectMilestones SET
	SortOrder = @OldSortOrder
WHERE MilestoneId = @OldMilestoneId
GO

ALTER  PROCEDURE [dbo].[BugNet_Project_GetMailboxByProjectId]
	@ProjectId int
AS

SELECT BugNet_ProjectMailboxes.*,
	u.Username AssignToName,
	BugNet_ProjectIssueTypes.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_ProjectIssueTypes ON BugNet_ProjectIssueTypes.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId
GO

ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
	@Username nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @Disabled bit
SET @Disabled = 1
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username
IF @ActiveOnly = 1
BEGIN
	SET @Disabled = 0
END
SELECT DISTINCT 
	[BugNet_ProjectsView].ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	[BugNet_ProjectsView].DateCreated,
	ProjectDisabled,
	ProjectAccessType,
	ManagerUserName,
	ManagerDisplayName,
	CreatorUserName,
	CreatorDisplayName,
	AllowAttachments,
	AllowAttachments,
	AttachmentStorageType,
	SvnRepositoryUrl
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
     (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND UP.UserId = @UserId)

ORDER BY ProjectName ASC
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM aspnet_users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM aspnet_users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM aspnet_users WHERE UserName = @IssueOwnerUserName

	INSERT BugNet_Issues
	(
		IssueTitle,
		IssueDescription,
		IssueCreatorUserId,
		DateCreated,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		IssueAssignedUserId,
		ProjectId,
		IssueResolutionId,
		IssueMilestoneId,
		IssueAffectedMilestoneId,
		LastUpdateUserId,
		LastUpdate,
		IssueDueDate,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		IssueOwnerUserId
	)
	VALUES
	(
		@IssueTitle,
		@IssueDescription,
		@IssueCreatorUserId,
		GetDate(),
		@IssueStatusId,
		@IssuePriorityId,
		@IssueTypeId,
		@IssueCategoryId,
		@IssueAssignedUserId,
		@ProjectId,
		@IssueResolutionId,
		@IssueMilestoneId,
		@IssueAffectedMilestoneId,
		@IssueCreatorUserId,
		GetDate(),
		@IssueDueDate,
		@IssueVisibility,
		@IssueEstimation,
		@IssueProgress,
		@IssueOwnerUserId
	)
RETURN scope_identity()
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
 @ProjectId int
AS
	SELECT 
		p.PriorityName, COUNT(nt.IssuePriorityId) AS Number, p.PriorityId, p.PriorityImageUrl
	FROM   
		BugNet_ProjectPriorities p
	
	LEFT JOIN 
		(SELECT  
			IssuePriorityId, ProjectId 
		FROM   
			BugNet_Issues
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt  
		ON 
			p.PriorityId = nt.IssuePriorityId AND nt.ProjectId = @ProjectId
		WHERE 
			p.ProjectId = @ProjectId
		GROUP BY 
			p.PriorityName, p.PriorityId, p.PriorityImageUrl, p.SortOrder
		ORDER BY p.SortOrder
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
	SELECT 
		s.StatusName,COUNT(nt.IssueStatusId) as 'Number', s.StatusId, s.StatusImageUrl
	FROM 
		BugNet_ProjectStatus s 
	LEFT OUTER JOIN 
	(SELECT  
			IssueStatusId, ProjectId 
		FROM   
			BugNet_Issues 
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId)) nt  
		ON 
			s.StatusId = nt.IssueStatusId AND nt.ProjectId = @ProjectId
		WHERE 
			s.ProjectId = @ProjectId
		GROUP BY 
			s.StatusName, s.StatusId, s.StatusImageUrl, s.SortOrder
		ORDER BY s.SortOrder
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS
	SELECT 
		t.IssueTypeName, COUNT(nt.IssueTypeId) AS 'Number', t.IssueTypeId, t.IssueTypeImageUrl
	FROM  
		BugNet_ProjectIssueTypes t 
	LEFT OUTER JOIN 
	(SELECT  
			IssueTypeId, ProjectId 
		FROM   
			BugNet_Issues
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt  
		ON 
			t.IssueTypeId = nt.IssueTypeId AND nt.ProjectId = @ProjectId
		WHERE 
			t.ProjectId = @ProjectId
		GROUP BY 
			t.IssueTypeName, t.IssueTypeId, t.IssueTypeImageUrl, t.SortOrder
		ORDER BY
			t.SortOrder
GO

ALTER PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
AS
SELECT * FROM BugNet_ProjectsView
GO

ALTER PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_Issues
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId 
WHERE
	IssueId IN (SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE SecondaryIssueId = @IssueId AND RelationType = @RelationType)
	OR IssueId IN (SELECT SecondaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @IssueId AND RelationType = @RelationType)
ORDER BY
	IssueId
GO

ALTER VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueTitle, ' ' AS IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueOwnerUserId, dbo.BugNet_Issues.IssueDueDate, 
                      dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueVisibility, dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, 
                      dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, 
                      dbo.BugNet_ProjectPriorities.PriorityName, dbo.BugNet_ProjectIssueTypes.IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, 
                      N'none') AS CategoryName, dbo.BugNet_ProjectStatus.StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'none') 
                      AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'none') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'none') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N'none') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N'none') AS CreatorDisplayName, 
                      ISNULL(OwnerUsers.UserName, 'none') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
                      ISNULL(LastUpdateUsersProfile.DisplayName, 'none') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') 
                      AS PriorityImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, 
                      ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') 
                      AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, 
                      ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (dbo.BugNet_Issues.IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_ProjectCustomFields.CustomFieldName, 
                      dbo.BugNet_ProjectCustomFieldValues.CustomFieldValue, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate
FROM         dbo.BugNet_ProjectCustomFields INNER JOIN
                      dbo.BugNet_ProjectCustomFieldValues ON 
                      dbo.BugNet_ProjectCustomFields.CustomFieldId = dbo.BugNet_ProjectCustomFieldValues.CustomFieldId RIGHT OUTER JOIN
                      dbo.BugNet_Issues ON dbo.BugNet_ProjectCustomFieldValues.IssueId = dbo.BugNet_Issues.IssueId LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
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

CREATE PROCEDURE BugNet_StringResources_GetInstalledLanguageResources
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT cultureCode FROM BugNet_StringResources
END
GO

UPDATE [dbo].[BugNet_StringResources] SET resourceType = 'ErrorMessages' WHERE resourceType = 'Errors'
GO

INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Default.aspx','en','RegisterAnLoginMessage', 'You must login to vew projects on this site.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/Settings.aspx','en','POP3Mailbox', 'POP3 Mailbox')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','POP3Settings', 'POP3 Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','Enable', 'Enable')	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','Server', 'Server')	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','SSL', 'SSL')	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','PollingInterval', 'Polling Interval')			   
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','DeleteProcessedMessages', 'Delete Processed Messages')			   
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','ProcessAttachments', 'Process Attachments')	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','BodyTemplate', 'Body Template')	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Host/UserControls/POP3Settings.ascx','en','ReportingUsername', 'Reporting Username')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('UserControls/TabMenu.ascx','en','AdminProject', 'Edit Project') 
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Projects/EditProject.aspx','en','RestoreProject', 'Restore Project') 	
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('CommonTerms','en','ReleaseDate', 'Release Date') 	   
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Please <a href="../Login.aspx">login</a> to obtain access this resource.' 
	WHERE resourceKey = 'Message1' AND resourceType ='Errors/AccessDenied.aspx'		   
GO



COMMIT

SET NOEXEC OFF
GO


