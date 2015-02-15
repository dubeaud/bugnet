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
PRINT N'Altering [dbo].[BugNet_Projects]...';


GO
ALTER TABLE [dbo].[BugNet_Projects]
	ADD [AllowIssueVoting]        BIT             CONSTRAINT [DF_BugNet_Projects_AllowIssueVoting] DEFAULT ((1)) NOT NULL,
		[ProjectImageFileContent] VARBINARY (MAX) NULL,
		[ProjectImageFileName]    NVARCHAR (150)  NULL,
		[ProjectImageContentType] NVARCHAR (50)   NULL,
		[ProjectImageFileSize]    BIGINT          NULL;


GO


PRINT N'Altering [dbo].[BugNet_ProjectsView]...';


GO
ALTER VIEW dbo.BugNet_ProjectsView
AS
SELECT     TOP (100) PERCENT dbo.BugNet_Projects.ProjectId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, dbo.BugNet_Projects.ProjectDescription, 
					  dbo.BugNet_Projects.AttachmentUploadPath, dbo.BugNet_Projects.ProjectManagerUserId, dbo.BugNet_Projects.ProjectCreatorUserId, 
					  dbo.BugNet_Projects.DateCreated, dbo.BugNet_Projects.ProjectDisabled, dbo.BugNet_Projects.ProjectAccessType, Managers.UserName AS ManagerUserName, 
					  ISNULL(ManagerUsersProfile.DisplayName, N'none') AS ManagerDisplayName, Creators.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, 
					  N'none') AS CreatorDisplayName, dbo.BugNet_Projects.AllowAttachments, dbo.BugNet_Projects.AttachmentStorageType, dbo.BugNet_Projects.SvnRepositoryUrl, 
					  dbo.BugNet_Projects.AllowIssueVoting
FROM         dbo.BugNet_Projects INNER JOIN
					  dbo.aspnet_Users AS Managers ON Managers.UserId = dbo.BugNet_Projects.ProjectManagerUserId INNER JOIN
					  dbo.aspnet_Users AS Creators ON Creators.UserId = dbo.BugNet_Projects.ProjectCreatorUserId LEFT OUTER JOIN
					  dbo.BugNet_UserProfiles AS CreatorUsersProfile ON Creators.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
					  dbo.BugNet_UserProfiles AS ManagerUsersProfile ON Managers.UserName = ManagerUsersProfile.UserName
ORDER BY dbo.BugNet_Projects.ProjectName
GO

PRINT N'Refreshing [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]...';


GO
EXECUTE sp_refreshview N'dbo.BugNet_GetIssuesByProjectIdAndCustomFieldView';


GO
PRINT N'Refreshing [dbo].[BugNet_IssuesView]...';


GO
EXECUTE sp_refreshview N'dbo.BugNet_IssuesView';


GO


PRINT N'Altering [dbo].[BugNet_Project_CreateNewProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @ProjectName nvarchar(50),
 @ProjectCode nvarchar(50),
 @ProjectDescription 	nvarchar(1000),
 @ProjectManagerUserName nvarchar(255),
 @AttachmentUploadPath nvarchar(80),
 @ProjectAccessType int,
 @ProjectCreatorUserName nvarchar(255),
 @AllowAttachments int,
 @AttachmentStorageType	int,
 @SvnRepositoryUrl	nvarchar(255),
 @AllowIssueVoting bit,
 @ProjectImageFileContent varbinary(max),
 @ProjectImageFileName nvarchar(150),
 @ProjectImageContentType nvarchar(50),
 @ProjectImageFileSize bigint
AS
IF NOT EXISTS( SELECT ProjectId,ProjectCode  FROM BugNet_Projects WHERE LOWER(ProjectName) = LOWER(@ProjectName) OR LOWER(ProjectCode) = LOWER(@ProjectCode) )
BEGIN
	DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
	DECLARE @ProjectCreatorUserId UNIQUEIDENTIFIER
	SELECT @ProjectManagerUserId = UserId FROM aspnet_users WHERE Username = @ProjectManagerUserName
	SELECT @ProjectCreatorUserId = UserId FROM aspnet_users WHERE Username = @ProjectCreatorUserName
	
	INSERT BugNet_Projects 
	(
		ProjectName,
		ProjectCode,
		ProjectDescription,
		AttachmentUploadPath,
		ProjectManagerUserId,
		DateCreated,
		ProjectCreatorUserId,
		ProjectAccessType,
		AllowAttachments,
		AttachmentStorageType,
		SvnRepositoryUrl,
		AllowIssueVoting,
		ProjectImageFileContent,
		ProjectImageFileName,
		ProjectImageContentType,
		ProjectImageFileSize
	) 
	VALUES
	(
		@ProjectName,
		@ProjectCode,
		@ProjectDescription,
		@AttachmentUploadPath,
		@ProjectManagerUserId ,
		GetDate(),
		@ProjectCreatorUserId,
		@ProjectAccessType,
		@AllowAttachments,
		@AttachmentStorageType,
		@SvnRepositoryUrl,
		@AllowIssueVoting,
		@ProjectImageFileContent,
		@ProjectImageFileName,
		@ProjectImageContentType,
		@ProjectImageFileSize
	)
	RETURN scope_identity()
END
ELSE
  RETURN 0
GO
PRINT N'Altering [dbo].[BugNet_Project_CreateProjectMailbox]...';


GO

ALTER PROCEDURE [dbo].[BugNet_Project_CreateProjectMailbox]
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
PRINT N'Altering [dbo].[BugNet_Project_DeleteProjectMailbox]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO

ALTER PROCEDURE [dbo].[BugNet_Project_DeleteProjectMailbox]
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
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [dbo].[BugNet_Project_GetProjectsByMemberUsername]...';


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
	AllowIssueVoting,
	SvnRepositoryUrl
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
	 (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND (UP.UserId = @UserId  or ProjectManagerUserId=@UserId ))
 
ORDER BY ProjectName ASC
GO
PRINT N'Altering [dbo].[BugNet_Project_UpdateProject]...';


GO

ALTER PROCEDURE [dbo].[BugNet_Project_UpdateProject]
 @ProjectId 				int,
 @ProjectName				nvarchar(50),
 @ProjectCode				nvarchar(50),
 @ProjectDescription 		nvarchar(1000),
 @ProjectManagerUserName	nvarchar(255),
 @AttachmentUploadPath 		nvarchar(80),
 @ProjectAccessType			int,
 @ProjectDisabled			int,
 @AllowAttachments			bit,
 @AttachmentStorageType		int,
 @SvnRepositoryUrl	nvarchar(255),
 @AllowIssueVoting bit,
 @ProjectImageFileContent varbinary(max),
 @ProjectImageFileName nvarchar(150),
 @ProjectImageContentType nvarchar(50),
 @ProjectImageFileSize bigint
AS
DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
SELECT @ProjectManagerUserId = UserId FROM aspnet_users WHERE Username = @ProjectManagerUserName

IF @ProjectImageFileContent IS NULL
	UPDATE BugNet_Projects SET
		ProjectName = @ProjectName,
		ProjectCode = @ProjectCode,
		ProjectDescription = @ProjectDescription,
		ProjectManagerUserId = @ProjectManagerUserId,
		AttachmentUploadPath = @AttachmentUploadPath,
		ProjectAccessType = @ProjectAccessType,
		ProjectDisabled = @ProjectDisabled,
		AllowAttachments = @AllowAttachments,
		AttachmentStorageType = @AttachmentStorageType,
		SvnRepositoryUrl = @SvnRepositoryUrl
	WHERE
		ProjectId = @ProjectId
ELSE
	UPDATE BugNet_Projects SET
		ProjectName = @ProjectName,
		ProjectCode = @ProjectCode,
		ProjectDescription = @ProjectDescription,
		ProjectManagerUserId = @ProjectManagerUserId,
		AttachmentUploadPath = @AttachmentUploadPath,
		ProjectAccessType = @ProjectAccessType,
		ProjectDisabled = @ProjectDisabled,
		AllowAttachments = @AllowAttachments,
		AttachmentStorageType = @AttachmentStorageType,
		SvnRepositoryUrl = @SvnRepositoryUrl,
		ProjectImageFileContent = @ProjectImageFileContent,
		ProjectImageFileName = @ProjectImageFileName,
		ProjectImageContentType = @ProjectImageContentType,
		ProjectImageFileSize = @ProjectImageFileSize
	WHERE
		ProjectId = @ProjectId
GO
PRINT N'Altering [dbo].[BugNet_Query_GetQueriesByUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
	@UserName NVarChar(255),
	@ProjectId Int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT
	QueryId,
	QueryName + ' (' + BugNet_UserProfiles.DisplayName + ')' AS QueryName,
	IsPublic
FROM
	BugNet_Queries INNER JOIN
	aspnet_Users M ON BugNet_Queries.UserId = M.UserId JOIN
	BugNet_UserProfiles ON M.UserName = BugNet_UserProfiles.UserName
WHERE
	IsPublic = 1 AND ProjectId = @ProjectId
UNION
SELECT
	QueryId,
	QueryName,
	IsPublic
FROM
	BugNet_Queries
WHERE
	UserId = @UserId
	AND ProjectID = @ProjectId
	AND IsPublic = 0
ORDER BY
	QueryName
GO
PRINT N'Creating [dbo].[BugNet_Query_GetQueryById]...';


GO
CREATE PROCEDURE [dbo].[BugNet_Query_GetQueryById] 
	@QueryId Int
AS

SELECT
	QueryId,
	QueryName,
	IsPublic
FROM
	BugNet_Queries
WHERE
	QueryId = @QueryId
ORDER BY
	QueryName
GO



INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'UserControls/TabMenu.ascx', N'en', N'NewIssue', N'New Issue') 
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Register.aspx', N'en', N'SecurityAnswerRequiredErrorMessage', N'Security answer is required.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Register.aspx', N'en', N'SecurityQuestionRequiredErrorMessage', N'Security question is required.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Administration/Host/UserControls/BasicSettings.ascx', N'en', N'AllowIssueVotingLabel.Text', N'Allow Issue Voting:')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Projects/ProjectCalendar.aspx',N'en',N'ListItem4.Text',N'Milestone Due Dates')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages', N'en', N'ProjectAccessDenied',	N'The user {0} does not have permission to this project.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages',	N'en', N'AccessDenied', N'Access Denied')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages',	N'en', N'AttachmentDeleteError', N'An error has occured deleing an IssueAttachment.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Login.aspx', N'en', N'Page.Title' , N'Login')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Projects/ReleaseNotes.aspx', N'en', N'Page.Title', N'Release Notes')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Projects/ReleaseNotes.aspx', N'en',	N'EditCopyNotes.Text',N'Edit / Copy Release Notes')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Projects/ReleaseNotes.aspx',N'en',N'EditCopyNotesDesc.Text',N'The text area below allows the project release notes to be edited and copied to another document.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages',	N'en',	N'DatabaseError', N'An error has occured accessing the database')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages', N'en', N'MailboxReaderError', N'An error has occured in processing the mailbox reader.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'Register.aspx', N'en', N'ConfirmPassword', N'Confirm Password')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'UserProfile.aspx', N'en', N'ConfirmPassword', N'Confirm Password')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'UserProfile.aspx', N'en', N'SecurityQuestionRequiredErrorMessage', N'Security Question Required')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'UserProfile.aspx', N'en', N'SecurityAnswerRequiredErrorMessage', N'Security Answer Required')

UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Manage Security Roles' 
	WHERE resourceKey = 'RolesTitle.Text' AND resourceType ='Administration/Projects/UserControls/ProjectRoles.ascx' AND cultureCode = 'en'
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Attachments' 
	WHERE resourceKey = 'AttachmentSettings' AND resourceType ='Administration/Host/UserControls/AttachmentSettings.ascx' AND cultureCode = 'en'   
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Authentication' 
	WHERE resourceKey = 'AuthenticationSettings' AND resourceType ='Administration/Host/UserControls/AuthenticationSettings.ascx' AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Basic' 
	WHERE resourceKey = 'BasicSettings' AND resourceType ='Administration/Host/UserControls/BasicSettings.ascx'	AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Logging' 
	WHERE resourceKey = 'LoggingSettings' AND resourceType ='Administration/Host/UserControls/LoggingSettings.ascx'	AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Mail / SMTP' 
	WHERE resourceKey = 'MailSettings' AND resourceType ='Administration/Host/UserControls/MailSettings.ascx'AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Notifications' 
	WHERE resourceKey = 'NotificationSettings' AND resourceType ='Administration/Host/UserControls/NotificationSettings.ascx' AND cultureCode = 'en'
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'POP3 / Mailbox' 
	WHERE resourceKey = 'POP3Settings' AND resourceType ='Administration/Host/UserControls/POP3Settings.ascx' AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources] 
	SET resourceValue = 'Subversion' 
	WHERE resourceKey = 'SubversionSettings' AND resourceType ='Administration/Host/UserControls/SubversionSettings.ascx' AND cultureCode = 'en'	
UPDATE [dbo].[BugNet_StringResources]  
	SET resourceValue = '{0} of {1} issues have been resolved'
	 WHERE resourceKey = 'ProgressMessage' AND resourceType ='Projects/RoadMap.aspx' AND cultureCode = 'en'		
GO


INSERT [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey],[PermissionName]) VALUES (29, N'ADMIN_DELETE_PROJECT', N'Delete a project')
INSERT [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey],[PermissionName]) VALUES (30, N'VIEW_PROJECT_CALENDAR', N'View the project calendar')
INSERT [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey],[PermissionName]) VALUES (31, N'CHANGE_ISSUE_STATUS', N'Change an issues status field')
INSERT [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey],[PermissionName]) VALUES (32, N'EDIT_QUERY',	N'Edit a query')
GO


COMMIT

SET NOEXEC OFF
GO