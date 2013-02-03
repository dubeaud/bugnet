/****** Object:  Table [dbo].[BugNet_UserProfiles]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_UserProfiles](
	[UserName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DisplayName] [nvarchar](100) NULL,
	[IssuesPageSize] [int] NULL,
	[PreferredLocale] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NOT NULL,
	[SelectedIssueColumns] [nvarchar](50) NULL,
	[ReceiveEmailNotifications] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_UserProfiles] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_RequiredFieldList]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_RequiredFieldList](
	[RequiredFieldId] [int] NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[FieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_RequiredFieldList] PRIMARY KEY CLUSTERED 
(
	[RequiredFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ApplicationLog]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BugNet_ApplicationLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_BugNet_ApplicationLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BugNet_HostSettings]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_HostSettings](
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_BugNet_HostSettings] PRIMARY KEY CLUSTERED 
(
	[SettingName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_Languages]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_Languages](
	[LanguageId] [int] IDENTITY(1,1) NOT NULL,
	[CultureCode] [nvarchar](50) NOT NULL,
	[CultureName] [nvarchar](200) NOT NULL,
	[FallbackCulture] [nvarchar](50) NULL,
 CONSTRAINT [PK_BugNet_Languages] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectCustomFieldTypes]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldTypes](
	[CustomFieldTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CustomFieldTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldTypes] PRIMARY KEY CLUSTERED 
(
	[CustomFieldTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_Permissions]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_Permissions](
	[PermissionId] [int] NOT NULL,
	[PermissionKey] [nvarchar](50) NOT NULL,
	[PermissionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_Permissions] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Permission_GetAllPermissions]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions] AS

SELECT PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ApplicationLog_GetLog]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog] 
@FilterType nvarchar(50) = NULL
AS


SELECT L.* FROM BugNet_ApplicationLog L 
WHERE  
((@FilterType IS NULL) OR (Level = @FilterType))
ORDER BY L.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ApplicationLog_ClearLog]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_ClearLog] 
	
AS
	DELETE FROM BugNet_ApplicationLog
GO
/****** Object:  StoredProcedure [dbo].[BugNet_HostSetting_UpdateHostSetting]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_HostSetting_UpdateHostSetting]
 @SettingName	nvarchar(50),
 @SettingValue 	nvarchar(2000)
AS
UPDATE BugNet_HostSettings SET
	SettingName = @SettingName,
	SettingValue = @SettingValue
WHERE
	SettingName  = @SettingName
GO
/****** Object:  StoredProcedure [dbo].[BugNet_HostSetting_GetHostSettings]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_HostSetting_GetHostSettings] AS

SELECT SettingName, SettingValue FROM BugNet_HostSettings
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Languages_GetInstalledLanguages]    Script Date: 11/12/2012 16:36:11 ******/
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
/****** Object:  StoredProcedure [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RequiredFieldId, FieldName, FieldValue FROM BugNet_RequiredFieldList
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_User_GetUserIdByUserName]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_User_GetUserIdByUserName]
	@UserName NVARCHAR(75),
	@UserId UNIQUEIDENTIFIER OUTPUT
AS

SET NOCOUNT ON

SELECT @UserId = UserId
FROM aspnet_Users
WHERE LoweredUserName = LOWER(@UserName)
GO
/****** Object:  Table [dbo].[BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BugNet_Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](50) NOT NULL,
	[ProjectCode] [nvarchar](50) NOT NULL,
	[ProjectDescription] [nvarchar](max) NOT NULL,
	[AttachmentUploadPath] [nvarchar](256) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[ProjectDisabled] [bit] NOT NULL,
	[ProjectAccessType] [int] NOT NULL,
	[ProjectManagerUserId] [uniqueidentifier] NOT NULL,
	[ProjectCreatorUserId] [uniqueidentifier] NOT NULL,
	[AllowAttachments] [bit] NOT NULL,
	[AttachmentStorageType] [int] NULL,
	[SvnRepositoryUrl] [nvarchar](255) NULL,
	[AllowIssueVoting] [bit] NOT NULL,
	[ProjectImageFileContent] [varbinary](max) NULL,
	[ProjectImageFileName] [nvarchar](150) NULL,
	[ProjectImageContentType] [nvarchar](50) NULL,
	[ProjectImageFileSize] [bigint] NULL,
 CONSTRAINT [PK_BugNet_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BugNet_ProjectCustomFields]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectCustomFields](
	[CustomFieldId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[CustomFieldName] [nvarchar](50) NOT NULL,
	[CustomFieldRequired] [bit] NOT NULL,
	[CustomFieldDataType] [int] NOT NULL,
	[CustomFieldTypeId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFields] PRIMARY KEY CLUSTERED 
(
	[CustomFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_CreateNewProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
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
/****** Object:  Table [dbo].[BugNet_ProjectCategories]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectCategories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ParentCategoryId] [int] NOT NULL,
	[Disabled] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_UpdateProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_UpdateProject]
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
		SvnRepositoryUrl = @SvnRepositoryUrl,
		AllowIssueVoting = @AllowIssueVoting
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
		ProjectImageFileSize = @ProjectImageFileSize,
		AllowIssueVoting = @AllowIssueVoting
	WHERE
		ProjectId = @ProjectId
GO
/****** Object:  Table [dbo].[BugNet_ProjectResolutions]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectResolutions](
	[ResolutionId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ResolutionName] [nvarchar](50) NOT NULL,
	[ResolutionImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectResolutions] PRIMARY KEY CLUSTERED 
(
	[ResolutionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectPriorities]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectPriorities](
	[PriorityId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[PriorityName] [nvarchar](50) NOT NULL,
	[PriorityImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectPriorities] PRIMARY KEY CLUSTERED 
(
	[PriorityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectNotifications]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectNotifications](
	[ProjectNotificationid] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectNotifications] PRIMARY KEY CLUSTERED 
(
	[ProjectNotificationid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectIssueTypes]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectIssueTypes](
	[IssueTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[IssueTypeName] [nvarchar](50) NOT NULL,
	[IssueTypeImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectIssueTypes] PRIMARY KEY CLUSTERED 
(
	[IssueTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectMilestones]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectMilestones](
	[MilestoneId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[MilestoneName] [nvarchar](50) NOT NULL,
	[MilestoneImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[MilestoneDueDate] [datetime] NULL,
	[MilestoneReleaseDate] [datetime] NULL,
	[MilestoneNotes] [nvarchar](max) NULL,
	[MilestoneCompleted] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectMilestones] PRIMARY KEY CLUSTERED 
(
	[MilestoneId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_ProjectStatus]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectStatus](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[StatusImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsClosedState] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_Queries]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_Queries](
	[QueryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[QueryName] [nvarchar](255) NOT NULL,
	[IsPublic] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Queries] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BugNet_ProjectsView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_ProjectsView]
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
/****** Object:  Table [dbo].[BugNet_UserProjects]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_UserProjects](
	[UserId] [uniqueidentifier] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[UserProjectId] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[SelectedIssueColumns] [nvarchar](255) NULL,
 CONSTRAINT [PK_BugNet_UserProjects] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[ProjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BugNet_UserView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_UserView]
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
/****** Object:  Table [dbo].[BugNet_Roles]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[RoleDescription] [nvarchar](256) NOT NULL,
	[AutoAssign] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_RolePermissions]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_RolePermissions](
	[PermissionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_UpdateRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_UpdateRole]
	@RoleId 			int,
	@RoleName			nvarchar(256),
	@RoleDescription 	nvarchar(256),
	@AutoAssign			bit,
	@ProjectId			int
AS
UPDATE BugNet_Roles SET
	RoleName = @RoleName,
	RoleDescription = @RoleDescription,
	AutoAssign = @AutoAssign,
	ProjectId = @ProjectId	
WHERE
	RoleId = @RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_User_GetUsersByProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int
AS
SELECT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	aspnet_Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  aspnet_Membership M 
	ON U.UserId = M.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1
ORDER BY DisplayName ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Query_GetQueryById]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[BugNet_Query_GetQueriesByUserName]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
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
/****** Object:  StoredProcedure [dbo].[BugNet_Query_SaveQuery]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_SaveQuery] 
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF EXISTS(SELECT QueryName FROM BugNet_Queries WHERE QueryName = @QueryName AND UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	RETURN 0
END

INSERT BugNet_Queries
(
	UserId,
	ProjectId,
	QueryName,
	IsPublic
)
VALUES
(
	@UserId,
	@ProjectId,
	@QueryName,
	@IsPublic
)
RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_GetAllRoles]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_GetAllRoles]
AS
SELECT RoleId, RoleName,RoleDescription,ProjectId,AutoAssign FROM BugNet_Roles
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_DeleteRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_DeleteRole]
	@RoleId Int 
AS
DELETE 
	BugNet_Roles
WHERE
	RoleId = @RoleId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_CreateNewRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_CreateNewRole]
  @ProjectId 	int,
  @RoleName 		nvarchar(256),
  @RoleDescription 	nvarchar(256),
  @AutoAssign	bit
AS
	INSERT BugNet_Roles
	(
		ProjectId,
		RoleName,
		RoleDescription,
		AutoAssign
	)
	VALUES
	(
		@ProjectId,
		@RoleName,
		@RoleDescription,
		@AutoAssign
	)
RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId]
	@Username	nvarchar(255),
 	@ProjectId	int,
 	@Columns nvarchar(255)
AS
DECLARE 
	@UserId UNIQUEIDENTIFIER	
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE BugNet_UserProjects
	SET [SelectedIssueColumns] = @Columns 
	WHERE UserId = @UserId AND ProjectId = @ProjectId;
	
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_RoleExists]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_RoleExists]
    @RoleName   nvarchar(256),
    @ProjectId	int
AS
BEGIN
    IF (EXISTS (SELECT RoleName FROM BugNet_Roles WHERE @RoleName = RoleName AND ProjectId = @ProjectId))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  Table [dbo].[BugNet_UserRoles]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_UserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_GetRolesByProject]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
	@ProjectId int
AS
SELECT RoleId,ProjectId, RoleName, RoleDescription, AutoAssign
FROM BugNet_Roles
WHERE ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_GetRoleById]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_GetRoleById]
	@RoleId int
AS
SELECT RoleId, ProjectId, RoleName, RoleDescription, AutoAssign 
FROM BugNet_Roles
WHERE RoleId = @RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]
	@ProjectId int,
	@IssueTypeId int,
	@IssueTypeName NVARCHAR(50),
	@IssueTypeImageUrl NVARCHAR(255),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldIssueTypeId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId
SELECT @OldIssueTypeId = IssueTypeId FROM BugNet_ProjectIssueTypes WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectIssueTypes SET
	ProjectId = @ProjectId,
	IssueTypeName = @IssueTypeName,
	IssueTypeImageUrl = @IssueTypeImageUrl,
	SortOrder = @SortOrder
WHERE IssueTypeId = @IssueTypeId

UPDATE BugNet_ProjectIssueTypes SET
	SortOrder = @OldSortOrder
WHERE IssueTypeId = @OldIssueTypeId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]
	@ProjectId int
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	SortOrder,
	IssueTypeImageUrl
FROM 
	BugNet_ProjectIssueTypes
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]
 @IssueTypeId INT
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	IssueTypeImageUrl,
	SortOrder
FROM 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]
	@IssueTypeIdToDelete INT
AS
DELETE 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]
 @ProjectId	    INT,
 @IssueTypeName NVARCHAR(50),
 @IssueTypeImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT IssueTypeId  FROM BugNet_ProjectIssueTypes WHERE LOWER(IssueTypeName)= LOWER(@IssueTypeName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectIssueTypes 
   	( 
		ProjectId, 
		IssueTypeName,
		IssueTypeImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@IssueTypeName,
		@IssueTypeImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN -1
GO
/****** Object:  Table [dbo].[BugNet_QueryClauses]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_QueryClauses](
	[QueryClauseId] [int] IDENTITY(1,1) NOT NULL,
	[QueryId] [int] NOT NULL,
	[BooleanOperator] [nvarchar](50) NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[ComparisonOperator] [nvarchar](50) NOT NULL,
	[FieldValue] [nvarchar](50) NOT NULL,
	[DataType] [int] NOT NULL,
	[CustomFieldId] [int] NULL,
 CONSTRAINT [PK_BugNet_QueryClauses] PRIMARY KEY CLUSTERED 
(
	[QueryClauseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_UpdateStatus]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_UpdateStatus]
	@ProjectId int,
	@StatusId int,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@SortOrder int,
	@IsClosedState bit
AS

DECLARE @OldSortOrder int
DECLARE @OldStatusId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectStatus WHERE StatusId = @StatusId
SELECT @OldStatusId = StatusId FROM BugNet_ProjectStatus WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId
		
UPDATE BugNet_ProjectStatus SET
	ProjectId = @ProjectId,
	StatusName = @StatusName,
	StatusImageUrl = @StatusImageUrl,
	SortOrder = @SortOrder,
	IsClosedState = @IsClosedState
WHERE StatusId = @StatusId

UPDATE BugNet_ProjectStatus SET
	SortOrder = @OldSortOrder
WHERE StatusId = @OldStatusId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]
		@ProjectId Int
AS
SELECT StatusId, ProjectId, StatusName,SortOrder, StatusImageUrl, IsClosedState
FROM BugNet_ProjectStatus
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_GetStatusById]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusById]
	@StatusId int
AS
SELECT
	StatusId,
	ProjectId,
	StatusName,
	SortOrder,
	StatusImageUrl,
	IsClosedState
FROM 
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_DeleteStatus]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_DeleteStatus]
 	@StatusIdToDelete INT
AS
DELETE
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_CreateNewStatus]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CreateNewStatus]
 	@ProjectId INT,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@IsClosedState bit
AS
IF NOT EXISTS(SELECT StatusId  FROM BugNet_ProjectStatus WHERE LOWER(StatusName)= LOWER(@StatusName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectStatus
	(
		ProjectId, 
		StatusName ,
		StatusImageUrl,
		SortOrder,
		IsClosedState
	) VALUES (
		@ProjectId, 
		@StatusName,
		@StatusImageUrl,
		@SortOrder,
		@IsClosedState
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_UpdateResolution]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_UpdateResolution]
	@ProjectId int,
	@ResolutionId int,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldResolutionId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId
SELECT @OldResolutionId = ResolutionId FROM BugNet_ProjectResolutions WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectResolutions SET
	ProjectId = @ProjectId,
	ResolutionName = @ResolutionName,
	ResolutionImageUrl = @ResolutionImageUrl,
	SortOrder = @SortOrder
WHERE ResolutionId = @ResolutionId

UPDATE BugNet_ProjectResolutions SET
	SortOrder = @OldSortOrder
WHERE ResolutionId = @OldResolutionId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]
		@ProjectId Int
AS
SELECT ResolutionId, ProjectId, ResolutionName,SortOrder, ResolutionImageUrl 
FROM BugNet_ProjectResolutions
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_GetResolutionById]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionById]
	@ResolutionId int
AS
SELECT
	ResolutionId,
	ProjectId,
	ResolutionName,
	SortOrder,
	ResolutionImageUrl
FROM 
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_DeleteResolution]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_DeleteResolution]
 	@ResolutionIdToDelete INT
AS
DELETE
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_CreateNewResolution]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CreateNewResolution]
 	@ProjectId INT,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50)
AS
IF NOT EXISTS(SELECT ResolutionId  FROM BugNet_ProjectResolutions WHERE LOWER(ResolutionName)= LOWER(@ResolutionName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectResolutions
	(
		ProjectId, 
		ResolutionName ,
		ResolutionImageUrl,
		SortOrder
	) VALUES (
		@ProjectId, 
		@ResolutionName,
		@ResolutionImageUrl,
		@SortOrder
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO
/****** Object:  Table [dbo].[BugNet_ProjectMailBoxes]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectMailBoxes](
	[ProjectMailboxId] [int] IDENTITY(1,1) NOT NULL,
	[MailBox] [nvarchar](100) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[AssignToUserId] [uniqueidentifier] NULL,
	[IssueTypeId] [int] NULL,
 CONSTRAINT [PK_BugNet_ProjectMailBoxes] PRIMARY KEY CLUSTERED 
(
	[ProjectMailboxId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername] 
	@Username nvarchar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @UserName

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN aspnet_Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	U.UserId = @UserId
ORDER BY
	DisplayName
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId] 
	@ProjectId Int
AS

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN aspnet_Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	P.ProjectId = @ProjectId
ORDER BY
	DisplayName
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE UserName = @Username
DELETE 
	BugNet_ProjectNotifications
WHERE
	ProjectId = @ProjectId
	AND UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
	@ProjectId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUserName

IF NOT EXISTS( SELECT ProjectNotificationId FROM BugNet_ProjectNotifications WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT BugNet_ProjectNotifications
	(
		ProjectId,
		UserId
	)
	VALUES
	(
		@ProjectId,
		@UserId
	)
	RETURN scope_identity()
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_UpdateMilestone]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
	@ProjectId int,
	@MilestoneId int,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@SortOrder int,
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted bit
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
	MilestoneReleaseDate = @MilestoneReleaseDate,
	MilestoneNotes = @MilestoneNotes,
	MilestoneCompleted = @MilestoneCompleted
WHERE MilestoneId = @MilestoneId

UPDATE BugNet_ProjectMilestones SET
	SortOrder = @OldSortOrder
WHERE MilestoneId = @OldMilestoneId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
	@ProjectId INT,
	@MilestoneCompleted bit
AS
SELECT * FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId AND 
MilestoneCompleted = (CASE WHEN  @MilestoneCompleted = 1 THEN MilestoneCompleted ELSE @MilestoneCompleted END) ORDER BY SortOrder ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_GetMilestoneById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
 @MilestoneId INT
AS
SELECT
	MilestoneId,
	ProjectId,
	MilestoneName,
	MilestoneImageUrl,
	SortOrder,
	MilestoneDueDate,
	MilestoneReleaseDate,
	MilestoneNotes,
	MilestoneCompleted
FROM 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_DeleteMilestone]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_DeleteMilestone]
	@MilestoneIdToDelete INT
AS
DELETE 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
 	@ProjectId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted bit
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
		MilestoneDueDate ,
		MilestoneReleaseDate,
		MilestoneNotes,
		MilestoneCompleted
	) VALUES (
		@ProjectId, 
		@MilestoneName,
		@MilestoneImageUrl,
		@SortOrder,
		@MilestoneDueDate,
		@MilestoneReleaseDate,
		@MilestoneNotes,
		@MilestoneCompleted
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_UpdatePriority]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
	@ProjectId int,
	@PriorityId int,
	@PriorityName NVARCHAR(50),
	@PriorityImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldPriorityId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId
SELECT @OldPriorityId = PriorityId FROM BugNet_ProjectPriorities WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectPriorities SET
	ProjectId = @ProjectId,
	PriorityName = @PriorityName,
	PriorityImageUrl = @PriorityImageUrl,
	SortOrder = @SortOrder
WHERE PriorityId = @PriorityId

UPDATE BugNet_ProjectPriorities SET
	SortOrder = @OldSortOrder
WHERE PriorityId = @OldPriorityId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_GetPriorityById]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPriorityById]
	@PriorityId int
AS
SELECT
	PriorityId,
	ProjectId,
	PriorityName,
	SortOrder,
	PriorityImageUrl
FROM 
	BugNet_ProjectPriorities
WHERE
	PriorityId = @PriorityId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]
	@ProjectId int
AS
SELECT
	PriorityId,
	ProjectId,
	PriorityName,
	SortOrder,
	PriorityImageUrl
FROM 
	BugNet_ProjectPriorities
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_DeletePriority]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_DeletePriority]
 @PriorityIdToDelete	INT
AS
DELETE 
	BugNet_ProjectPriorities
WHERE
	PriorityId = @PriorityIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_CreateNewPriority]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
 @ProjectId	    INT,
 @PriorityName        NVARCHAR(50),
 @PriorityImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT PriorityId  FROM BugNet_ProjectPriorities WHERE LOWER(PriorityName)= LOWER(@PriorityName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectPriorities 
   	( 
		ProjectId, 
		PriorityName,
		PriorityImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@PriorityName,
		@PriorityImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[BugNet_GetProjectSelectedColumnsWithUserIdAndProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_GetProjectSelectedColumnsWithUserIdAndProjectId]
	@Username	nvarchar(255),
 	@ProjectId	int,
 	@ReturnValue nvarchar(255) OUT
AS
DECLARE 
	@UserId UNIQUEIDENTIFIER	
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	SET @ReturnValue = (SELECT [SelectedIssueColumns] FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId);
	
END
GO
/****** Object:  Table [dbo].[BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_Issues](
	[IssueId] [int] IDENTITY(1,1) NOT NULL,
	[IssueTitle] [nvarchar](500) NOT NULL,
	[IssueDescription] [nvarchar](max) NOT NULL,
	[IssueStatusId] [int] NULL,
	[IssuePriorityId] [int] NULL,
	[IssueTypeId] [int] NULL,
	[IssueCategoryId] [int] NULL,
	[ProjectId] [int] NOT NULL,
	[IssueAffectedMilestoneId] [int] NULL,
	[IssueResolutionId] [int] NULL,
	[IssueCreatorUserId] [uniqueidentifier] NOT NULL,
	[IssueAssignedUserId] [uniqueidentifier] NULL,
	[IssueOwnerUserId] [uniqueidentifier] NULL,
	[IssueDueDate] [datetime] NULL,
	[IssueMilestoneId] [int] NULL,
	[IssueVisibility] [int] NOT NULL,
	[IssueEstimation] [decimal](5, 2) NOT NULL,
	[IssueProgress] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateUserId] [uniqueidentifier] NOT NULL,
	[Disabled] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Issues] PRIMARY KEY CLUSTERED 
(
	[IssueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_RemoveUserFromProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE 
	BugNet_UserProjects
WHERE
	UserId = @UserId AND ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_IsUserProjectMember]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@Username	nvarchar(255),
 	@ProjectId	int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username

IF EXISTS( SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_AddUserToProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
@UserName nvarchar(255),
@ProjectId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT  BugNet_UserProjects
	(
		UserId,
		ProjectId,
		DateCreated
	)
	VALUES
	(
		@UserId,
		@ProjectId,
		getdate()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_UpdateCustomField]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_UpdateCustomField]
	@CustomFieldId Int,
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
UPDATE 
	BugNet_ProjectCustomFields 
SET
	ProjectId = @ProjectId,
	CustomFieldName = @CustomFieldName,
	CustomFieldDataType = @CustomFieldDataType,
	CustomFieldRequired = @CustomFieldRequired,
	CustomFieldTypeId = @CustomFieldTypeId
WHERE 
	CustomFieldId = @CustomFieldId
GO
/****** Object:  Table [dbo].[BugNet_ProjectCustomFieldSelections]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldSelections](
	[CustomFieldSelectionId] [int] IDENTITY(1,1) NOT NULL,
	[CustomFieldId] [int] NOT NULL,
	[CustomFieldSelectionValue] [nvarchar](255) NOT NULL,
	[CustomFieldSelectionName] [nvarchar](255) NOT NULL,
	[CustomFieldSelectionSortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldSelections] PRIMARY KEY CLUSTERED 
(
	[CustomFieldSelectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectId AND LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT BugNet_ProjectCustomFields
	(
		ProjectId,
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		CustomFieldTypeId
	)
	VALUES
	(
		@ProjectId,
		@CustomFieldName,
		@CustomFieldDataType,
		@CustomFieldRequired,
		@CustomFieldTypeId
	)

	RETURN scope_identity()
END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_UpdateCategory]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_UpdateCategory]
	@CategoryId int,
	@ProjectId int,
	@CategoryName nvarchar(100),
	@ParentCategoryId int
AS


UPDATE BugNet_ProjectCategories SET
	ProjectId = @ProjectId,
	CategoryName = @CategoryName,
	ParentCategoryId = @ParentCategoryId
WHERE CategoryId = @CategoryId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_GetCustomFieldById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldById] 
	@CustomFieldId Int
AS

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
WHERE
	Fields.CustomFieldId = @CustomFieldId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId] 
	@ProjectId Int
AS
SELECT
	ProjectId,
	CustomFieldId,
	CustomFieldName,
	CustomFieldDataType,
	CustomFieldRequired,
	'' CustomFieldValue,
	CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields
WHERE
	ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetPublicProjects]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
AS
SELECT * FROM 
	BugNet_ProjectsView
WHERE 
	ProjectAccessType = 1 AND ProjectDisabled = 0
ORDER BY ProjectName ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectsByMemberUsername]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
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
	SvnRepositoryUrl,
	AllowIssueVoting
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
     (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND (UP.UserId = @UserId  or ProjectManagerUserId=@UserId ))
 
ORDER BY ProjectName ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectMembers]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId Int
AS
SELECT Username
FROM 
	aspnet_users
LEFT OUTER JOIN
	BugNet_UserProjects
ON
	aspnet_users.UserId = BugNet_UserProjects.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY Username ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectByCode]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
@ProjectCode nvarchar(50)
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectCode = @ProjectCode
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_DeleteCategory]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId Int 
AS
UPDATE BugNet_ProjectCategories SET
	[Disabled] = 1
WHERE
	CategoryId = @CategoryId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_CreateNewCategory]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
  @ProjectId int,
  @CategoryName nvarchar(100),
  @ParentCategoryId int
AS
	INSERT BugNet_ProjectCategories
	(
		ProjectId,
		CategoryName,
		ParentCategoryId
	)
	VALUES
	(
		@ProjectId,
		@CategoryName,
		@ParentCategoryId
	)
RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetAllProjects]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
AS
SELECT * FROM BugNet_ProjectsView
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_DeleteProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProject]
    @ProjectIdToDelete int
AS

--Delete these first
DELETE FROM BugNet_Issues WHERE ProjectId = @ProjectIdToDelete

--Now Delete everything that was attached to a project and an issue
DELETE FROM BugNet_ProjectCategories WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_UserProjects WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMailBoxes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectIdToDelete

--now delete everything attached to the project
DELETE FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Roles WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Queries WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectNotifications WHERE ProjectId = @ProjectIdToDelete

--now delete the project
DELETE FROM BugNet_Projects WHERE ProjectId = @ProjectIdToDelete
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetMemberRolesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
	@ProjectId Int
AS

SELECT ISNULL(UsersProfile.DisplayName, aspnet_Users.UserName) as DisplayName, BugNet_Roles.RoleName
FROM
	aspnet_Users INNER JOIN
	BugNet_UserProjects ON aspnet_Users.UserId = BugNet_UserProjects.UserId INNER JOIN
	BugNet_UserRoles ON aspnet_Users.UserId = BugNet_UserRoles.UserId INNER JOIN
	BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId LEFT OUTER JOIN
	BugNet_UserProfiles AS UsersProfile ON aspnet_Users.UserName = UsersProfile.UserName

WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY DisplayName, RoleName ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Permission_GetRolePermission]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[BugNet_Permission_GetRolePermission]  AS

SELECT R.RoleId, R.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName, P.PermissionName
FROM BugNet_RolePermissions RP
JOIN
BugNet_Permissions P ON RP.PermissionId = P.PermissionId
JOIN
BugNet_Roles R ON RP.RoleId = R.RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Permission_GetPermissionsByRole]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleId int
 AS
SELECT BugNet_Permissions.PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
INNER JOIN BugNet_RolePermissions on BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId
WHERE RoleId = @RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_CloneProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_CloneProject] 
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
  ProjectId = @ProjectId  AND Disabled = 0


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
/****** Object:  StoredProcedure [dbo].[BugNet_Permission_DeleteRolePermission]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId Int,
	@RoleId Int 
AS
DELETE 
	BugNet_RolePermissions
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Permission_AddRolePermission]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId int,
	@RoleId int
AS
IF NOT EXISTS (SELECT PermissionId FROM BugNet_RolePermissions WHERE PermissionId = @PermissionId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_RolePermissions
	(
		PermissionId,
		RoleId
	)
	VALUES
	(
		@PermissionId,
		@RoleId
	)
END
GO
/****** Object:  Table [dbo].[BugNet_IssueNotifications]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueNotifications](
	[IssueNotificationId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueNotifications] PRIMARY KEY CLUSTERED 
(
	[IssueNotificationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_IssueWorkReports]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueWorkReports](
	[IssueWorkReportId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[WorkDate] [datetime] NOT NULL,
	[Duration] [decimal](4, 2) NOT NULL,
	[IssueCommentId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueWorkReports] PRIMARY KEY CLUSTERED 
(
	[IssueWorkReportId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_IssueAttachments]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BugNet_IssueAttachments](
	[IssueAttachmentId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](80) NOT NULL,
	[FileSize] [int] NOT NULL,
	[ContentType] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Attachment] [varbinary](max) NULL,
 CONSTRAINT [PK_BugNet_IssueAttachments] PRIMARY KEY CLUSTERED 
(
	[IssueAttachmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BugNet_IssueHistory]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueHistory](
	[IssueHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[FieldChanged] [nvarchar](50) NOT NULL,
	[OldValue] [nvarchar](50) NOT NULL,
	[NewValue] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueHistory] PRIMARY KEY CLUSTERED 
(
	[IssueHistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_IssueComments]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueComments](
	[IssueCommentId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueComments] PRIMARY KEY CLUSTERED 
(
	[IssueCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_IssueVotes]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueVotes](
	[IssueVoteId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueVotes] PRIMARY KEY CLUSTERED 
(
	[IssueVoteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugNet_IssueRevisions]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_IssueRevisions](
	[IssueRevisionId] [int] IDENTITY(1,1) NOT NULL,
	[Revision] [int] NOT NULL,
	[IssueId] [int] NOT NULL,
	[Repository] [nvarchar](400) NOT NULL,
	[RevisionAuthor] [nvarchar](100) NOT NULL,
	[RevisionDate] [nvarchar](100) NOT NULL,
	[RevisionMessage] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Branch] [nvarchar](255) NULL,
	[Changeset] [nvarchar](100) NULL,
 CONSTRAINT [PK_BugNet_IssueRevisions] PRIMARY KEY CLUSTERED 
(
	[IssueRevisionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_Delete]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_Delete]
	@IssueId Int
AS
UPDATE BugNet_Issues SET
	Disabled = 1
WHERE
	IssueId = @IssueId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_CreateNewIssue]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS 'Number' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueMilestoneId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS 'Number' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueAssignedUserId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_UpdateLastUpdated]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateLastUpdated]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_UpdateIssue]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
  @IssueId Int,
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
  @LastUpdateUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER
DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM aspnet_users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM aspnet_users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM aspnet_users WHERE UserName = @IssueOwnerUserName
SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		IssueTitle = @IssueTitle,
		IssueCategoryId = @IssueCategoryId,
		ProjectId = @ProjectId,
		IssueStatusId = @IssueStatusId,
		IssuePriorityId = @IssuePriorityId,
		IssueMilestoneId = @IssueMilestoneId,
		IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
		IssueAssignedUserId = @IssueAssignedUserId,
		IssueOwnerUserId = @IssueOwnerUserId,
		IssueTypeId = @IssueTypeId,
		IssueResolutionId = @IssueResolutionId,
		IssueDueDate = @IssueDueDate,
		IssueVisibility = @IssueVisibility,
		IssueEstimation = @IssueEstimation,
		IssueProgress = @IssueProgress,
		IssueDescription = @IssueDescription,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
	
	/*EXEC BugNet_IssueHistory_CreateNewHistory @IssueId, @IssueCreatorId*/
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectPriorities_CanDeletePriority]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CanDeletePriority]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]    Script Date: 11/12/2012 16:36:11 ******/
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetMailboxById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]    Script Date: 11/12/2012 16:36:11 ******/
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]    Script Date: 11/12/2012 16:36:11 ******/
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
/****** Object:  Table [dbo].[BugNet_ProjectCustomFieldValues]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldValues](
	[CustomFieldValueId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[CustomFieldId] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldValues] PRIMARY KEY CLUSTERED 
(
	[CustomFieldValueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectStatus_CanDeleteStatus]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CanDeleteStatus]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Query_UpdateQuery]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_UpdateQuery] 
	@QueryId Int,
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

UPDATE 
	BugNet_Queries 
SET
	UserId = @UserId,
	ProjectId = @ProjectId,
	QueryName = @QueryName,
	IsPublic = @IsPublic
WHERE 
	QueryId = @QueryId

DELETE FROM BugNet_QueryClauses WHERE QueryId = @QueryId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Query_SaveQueryClause]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_SaveQueryClause] 
  @QueryId INT,
  @BooleanOperator NVarChar(50),
  @FieldName NVarChar(50),
  @ComparisonOperator NVarChar(50),
  @FieldValue NVarChar(50),
  @DataType INT,
  @CustomFieldId INT = NULL
AS
INSERT BugNet_QueryClauses
(
  QueryId,
  BooleanOperator,
  FieldName,
  ComparisonOperator,
  FieldValue,
  DataType, 
  CustomFieldId
) 
VALUES (
  @QueryId,
  @BooleanOperator,
  @FieldName,
  @ComparisonOperator,
  @FieldValue,
  @DataType,
  @CustomFieldId
)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_ProjectCustomFieldSelections
WHERE
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById] 
	@CustomFieldSelectionId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_ProjectCustomFieldSelections
WHERE
	CustomFieldSelectionId = @CustomFieldSelectionId
ORDER BY CustomFieldSelectionSortOrder
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_GetProjectRolesByUser]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BugNet_Role_GetProjectRolesByUser] 
	@UserName       nvarchar(256),
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	R.RoleName,
		R.ProjectId,
		R.RoleDescription,
		R.RoleId,
		R.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN aspnet_users ON BugNet_UserRoles.UserId = aspnet_users.UserId
INNER JOIN BugNet_Roles R ON BugNet_UserRoles.RoleId = R.RoleId
WHERE  aspnet_users.UserId = @UserId
AND    (R.ProjectId IS NULL OR R.ProjectId = @ProjectId)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_RemoveUserFromRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
	@UserName	nvarchar(256),
	@RoleId		Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_IsUserInRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BugNet_Role_IsUserInRole] 
	@UserName		nvarchar(256),
	@RoleId			int,
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	UR.UserId,
		UR.RoleId
FROM	BugNet_UserRoles UR
INNER JOIN BugNet_Roles R ON UR.RoleId = R.RoleId
WHERE	UR.UserId = @UserId
AND		UR.RoleId = @RoleId
AND		R.ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_GetRolesByUser]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BugNet_Role_GetRolesByUser] 
	@UserName       nvarchar(256)
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	BugNet_Roles.RoleName,
		BugNet_Roles.ProjectId,
		BugNet_Roles.RoleDescription,
		BugNet_Roles.RoleId,
		BugNet_Roles.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN aspnet_users ON BugNet_UserRoles.UserId = aspnet_users.UserId
INNER JOIN BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId
WHERE  aspnet_users.UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_AddUserToRole]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_AddUserToRole]
	@UserName nvarchar(256),
	@RoleId int
AS

DECLARE @ProjectId int
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName
SELECT	@ProjectId = ProjectId FROM BugNet_Roles WHERE RoleId = @RoleId

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId) AND @RoleId <> 1
BEGIN
 EXEC BugNet_Project_AddUserToProject @UserName, @ProjectId
END

IF NOT EXISTS (SELECT UserId FROM BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_UserRoles
	(
		UserId,
		RoleId
	)
	VALUES
	(
		@UserId,
		@RoleId
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Query_GetSavedQuery]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_GetSavedQuery] 
  @QueryId INT
AS

SELECT 
	BooleanOperator,
	FieldName,
	ComparisonOperator,
	FieldValue,
	DataType,
	CustomFieldId
FROM 
	BugNet_QueryClauses
WHERE 
	QueryId = @QueryId;
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Query_DeleteQuery]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Query_DeleteQuery] 
  @QueryId Int
AS
DELETE BugNet_Queries WHERE QueryId = @QueryId
DELETE BugNet_QueryClauses WHERE QueryId = @QueryId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Role_RoleHasPermission]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Role_RoleHasPermission] 
	@ProjectID 		int,
	@Role 			nvarchar(256),
	@PermissionKey	nvarchar(50)
AS

SELECT COUNT(*) FROM BugNet_RolePermissions INNER JOIN BugNet_Roles ON BugNet_Roles.RoleId = BugNet_RolePermissions.RoleId INNER JOIN
BugNet_Permissions ON BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId

WHERE ProjectId = @ProjectID 
AND 
PermissionKey = @PermissionKey
AND 
BugNet_Roles.RoleName = @Role
GO
/****** Object:  Table [dbo].[BugNet_RelatedIssues]    Script Date: 11/12/2012 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_RelatedIssues](
	[PrimaryIssueId] [int] NOT NULL,
	[SecondaryIssueId] [int] NOT NULL,
	[RelationType] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_GetRelatedIssues]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
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
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_GetParentIssues]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetParentIssues]
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
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON PrimaryIssueId = IssueId
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	SecondaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	PrimaryIssueId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_GetChildIssues]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetChildIssues]
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
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON SecondaryIssueId = IssueId
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	PrimaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	SecondaryIssueId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	( (PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId) OR (PrimaryIssueId = @SecondaryIssueId AND SecondaryIssueId = @PrimaryIssueId) )
	AND RelationType = @RelationType
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_DeleteParentIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[BugNet_RelatedIssue_DeleteParentIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @SecondaryIssueId
	AND SecondaryIssueId = @PrimaryIssueId
	AND RelationType = @RelationType
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_DeleteChildIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteChildIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @PrimaryIssueId
	AND SecondaryIssueId = @SecondaryIssueId
	AND RelationType = @RelationType
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE (PrimaryIssueId = @PrimaryIssueId OR PrimaryIssueId = @SecondaryIssueId) AND (SecondaryIssueId = @SecondaryIssueId OR SecondaryIssueId = @PrimaryIssueId) AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@SecondaryIssueId,
		@PrimaryIssueId,
		@RelationType
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_CreateNewParentIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewParentIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @SecondaryIssueId AND SecondaryIssueId = @PrimaryIssueId AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@SecondaryIssueId,
		@PrimaryIssueId,
		@RelationType
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_RelatedIssue_CreateNewChildIssue]    Script Date: 11/12/2012 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewChildIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@PrimaryIssueId,
		@SecondaryIssueId,
		@RelationType
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
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
/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN aspnet_Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]
 @IssueAttachmentId INT
AS
SELECT
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN aspnet_Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueAttachmentId = @IssueAttachmentId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]
 @IssueAttachmentId INT
AS
DELETE
FROM
	BugNet_IssueAttachments
WHERE
	IssueAttachmentId = @IssueAttachmentId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
  @IssueId int,
  @FileName nvarchar(100),
  @FileSize Int,
  @ContentType nvarchar(50),
  @CreatorUserName nvarchar(255),
  @Description nvarchar(80),
  @Attachment Image
AS
-- Get Uploaded UserID
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugNet_IssueAttachments
(
	IssueId,
	FileName,
	Description,
	FileSize,
	ContentType,
	DateCreated,
	UserId,
	Attachment
)
VALUES
(
	@IssueId,
	@FileName,
	@Description,
	@FileSize,
	@ContentType,
	GetDate(),
	@UserId,
	@Attachment
	
)
RETURN scope_identity()
GO
/****** Object:  View [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssueRevisions
WHERE
	IssueId = @IssueId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueRevision_DeleteIssueRevisions]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueRevision_DeleteIssueRevisions] 
  @IssueRevisionId Int
AS
DELETE FROM
	BugNet_IssueRevisions
WHERE
	IssueRevisionId = @IssueRevisionId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId int,
	@Revision int,
	@Repository nvarchar(400),
	@RevisionDate nvarchar(100),
	@RevisionAuthor nvarchar(100),
	@RevisionMessage ntext,
	@Changeset nvarchar(100),
	@Branch nvarchar(255)
AS

INSERT BugNet_IssueRevisions
(
	Revision,
	IssueId,
	Repository,
	RevisionAuthor,
	RevisionDate,
	RevisionMessage,
	Changeset,
	Branch,
	DateCreated
) 
VALUES 
(
	@Revision,
	@IssueId,
	@Repository,
	@RevisionAuthor,
	@RevisionDate,
	@RevisionMessage,
	@Changeset,
	@Branch,
	GetDate()
)

RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueVote_HasUserVoted]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @VoteUserName

BEGIN
    IF EXISTS(SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueVote_CreateNewIssueVote]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @VoteUserName

IF NOT EXISTS( SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
BEGIN
	INSERT BugNet_IssueVotes
	(
		IssueId,
		UserId,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		GETDATE()
	)
	RETURN scope_identity()
END
GO
/****** Object:  View [dbo].[BugNet_IssuesView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, dbo.BugNet_Issues.IssueOwnerUserId, 
                      dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                      dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, 
                      dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') 
                      AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, 
                      N'Unassigned') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N'Unassigned') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 
                      'Unassigned') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, 
                      'Unassigned') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') 
                      AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate, dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) 
                      AS IsClosed, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.LastUpdate, 112) AS DATETIME) AS LastUpdateAsDate, 
					  CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.DateCreated, 112) AS DATETIME) AS DateCreatedAsDate
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
/****** Object:  StoredProcedure [dbo].[BugNet_IssueComment_UpdateIssueComment]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
	@IssueCommentId int,
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@Comment ntext
AS

DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName

UPDATE BugNet_IssueComments SET
	IssueId = @IssueId,
	UserId = @UserId,
	Comment = @Comment
WHERE IssueCommentId= @IssueCommentId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN aspnet_Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueComment_GetIssueCommentById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
 @IssueCommentId INT
AS
SELECT
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN aspnet_Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueCommentId = @IssueCommentId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueComment_DeleteIssueComment]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BugNet_IssueComment_DeleteIssueComment]
	@IssueCommentId Int
AS
DELETE 
	BugNet_IssueComments
WHERE
	IssueCommentId = @IssueCommentId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueComment_CreateNewIssueComment]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueComment_CreateNewIssueComment]
	@IssueId int,
	@CreatorUserName NVarChar(255),
	@Comment ntext
AS
-- Get Last Update UserID
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugNet_IssueComments
(
	IssueId,
	UserId,
	DateCreated,
	Comment
) 
VALUES 
(
	@IssueId,
	@UserId,
	GetDate(),
	@Comment
)

/* Update the LastUpdate fields of this bug*/
UPDATE BugNet_Issues SET LastUpdate = GetDate(),LastUpdateUserId = @UserId WHERE IssueId = @IssueId

RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]
	@IssueId INT
AS
SELECT      
	IssueWorkReportId,
	BugNet_IssueWorkReports.IssueId,
	WorkDate,
	Duration,
	BugNet_IssueWorkReports.IssueCommentId,
	BugNet_IssueWorkReports.UserId CreatorUserId, 
	U.UserName CreatorUsername,
	IsNull(DisplayName,'') CreatorDisplayName,
    ISNULL(BugNet_IssueComments.Comment, '') Comment
FROM         
	BugNet_IssueWorkReports
	INNER JOIN aspnet_Users U ON BugNet_IssueWorkReports.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
	LEFT OUTER JOIN BugNet_IssueComments ON BugNet_IssueComments.IssueCommentId =  BugNet_IssueWorkReports.IssueCommentId
WHERE
	 BugNet_IssueWorkReports.IssueId = @IssueId
ORDER BY WorkDate DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]
	@IssueWorkReportId int
AS
DELETE 
	BugNet_IssueWorkReports
WHERE
	IssueWorkReportId = @IssueWorkReportId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@IssueCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugNet_IssueWorkReports
(
	IssueId,
	UserId,
	WorkDate,
	Duration,
	IssueCommentId
) 
VALUES 
(
	@IssueId,
	@CreatorUserId,
	@WorkDate,
	@Duration,
	@IssueCommentID
)
RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level
*/

SET NOCOUNT ON

DECLARE
	@DefaultCulture NVARCHAR(50)

SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId AS NotificationUserId,
	U.UserName AS NotificationUsername,
	ISNULL(DisplayName,'') AS NotificationDisplayName,
	M.Email AS NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles UP ON U.UserName = UP.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_DeleteIssueNotification]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
	@IssueId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE UserName = @Username
DELETE 
	BugNet_IssueNotifications
WHERE
	IssueId = @IssueId
	AND UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
	@IssueId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUserName

IF (NOT EXISTS(SELECT IssueNotificationId FROM BugNet_IssueNotifications WHERE UserId = @UserId AND IssueId = @IssueId) AND @UserId IS NOT NULL)
BEGIN
	INSERT BugNet_IssueNotifications
	(
		IssueId,
		UserId
	)
	VALUES
	(
		@IssueId,
		@UserId
	)
	RETURN scope_identity()
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
	@IssueId int
AS
 SELECT
	IssueHistoryId,
	IssueId,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'') CreatorDisplayName,
	FieldChanged,
	OldValue,
	NewValue,
	DateCreated
FROM 
	BugNet_IssueHistory
	INNER JOIN aspnet_Users U ON BugNet_IssueHistory.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE 
	IssueId = @IssueId
ORDER BY
	DateCreated DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
  @IssueId int,
  @CreatedUserName nvarchar(255),
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_users WHERE UserName = @CreatedUserName

	INSERT BugNet_IssueHistory
	(
		IssueId,
		UserId,
		FieldChanged,
		OldValue,
		NewValue,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN scope_identity()
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomFieldSelection_Update]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_Update]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]
	@IssueId Int,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(MAX)
AS
UPDATE 
	BugNet_ProjectCustomFieldValues 
SET
	CustomFieldValue = @CustomFieldValue
WHERE
	IssueId = @IssueId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT BugNet_ProjectCustomFieldValues
	(
		IssueId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@IssueId,
		@CustomFieldId,
		@CustomFieldValue
	)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId] 
	@IssueId Int
AS
DECLARE @ProjectId Int
SELECT @ProjectId = ProjectId FROM BugNet_Issues WHERE IssueId = @IssueId

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
	LEFT OUTER JOIN BugNet_ProjectCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId AND FieldValues.IssueId = @IssueId)
WHERE
	Fields.ProjectId = @ProjectId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_DeleteCustomField]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN

	DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetCategoryById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoryById]
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
/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetChangeLog]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetChangeLog] 
	@ProjectId int
AS

SELECT * FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM on IssueMilestoneId = MilestoneId  
WHERE 
	BugNet_IssuesView.ProjectId = @ProjectId  
	AND Disabled = 0 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)
ORDER BY 
	(CASE WHEN PM.SortOrder IS NULL THEN 1 ELSE 0 END),PM.SortOrder, CategoryName ASC, IssueTypeName ASC, AssignedUserName ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetRoadMapProgress]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
	@ProjectId int,
	@MilestoneId int
AS
SELECT (SELECT COUNT(*) FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND BugNet_IssuesView.Disabled = 0 
	AND IssueMilestoneId = @MilestoneId 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)) As ClosedCount , 
(SELECT COUNT(*) FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND ProjectId = @ProjectId AND IssueMilestoneId = @MilestoneId) As TotalCount
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetRoadMap]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  View [dbo].[BugNet_IssueMilestoneCountView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssueMilestoneCountView]
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
/****** Object:  View [dbo].[BugNet_IssueCommentsView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssueCommentsView]
AS
SELECT     dbo.BugNet_IssueComments.IssueCommentId, dbo.BugNet_IssueComments.IssueId, dbo.BugNet_IssuesView.ProjectId, dbo.BugNet_IssueComments.Comment, 
                      dbo.BugNet_IssueComments.DateCreated, dbo.BugNet_UserView.UserId AS CreatorUserId, dbo.BugNet_UserView.DisplayName AS CreatorDisplayName, 
                      dbo.BugNet_UserView.UserName AS CreatorUserName, dbo.BugNet_IssuesView.Disabled AS IssueDisabled, dbo.BugNet_IssuesView.IsClosed AS IssueIsClosed, 
                      dbo.BugNet_IssuesView.IssueVisibility, dbo.BugNet_IssuesView.ProjectCode, dbo.BugNet_IssuesView.ProjectName, dbo.BugNet_IssuesView.ProjectDisabled
FROM         dbo.BugNet_IssuesView INNER JOIN
                      dbo.BugNet_IssueComments ON dbo.BugNet_IssuesView.IssueId = dbo.BugNet_IssueComments.IssueId INNER JOIN
                      dbo.BugNet_UserView ON dbo.BugNet_IssueComments.UserId = dbo.BugNet_UserView.UserId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_ValidateDownload]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_ValidateDownload]
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
/****** Object:  View [dbo].[BugNet_IssueStatusCountView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssueStatusCountView]
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
/****** Object:  View [dbo].[BugNet_IssuePriorityCountView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssuePriorityCountView]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueById]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueById] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	IssueId = @IssueId
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuesByRelevancy]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByRelevancy] 
	@ProjectId int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM
	BugNet_IssuesView 
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND (IssueCreatorUserId = @UserId OR IssueAssignedUserId = @UserId OR IssueOwnerUserId = @UserId)
ORDER BY
	IssueId Desc
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuesByProjectId]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId
	AND Disabled = 0
Order By IssuePriorityId, IssueStatusId ASC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuesByOwnerUserName]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByOwnerUserName] 
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueOwnerUserId = @UserId
ORDER BY
	IssueId Desc
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuesByCreatorUserName]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByCreatorUserName] 
  @ProjectId Int,
  @UserName NVarChar(255)
AS
DECLARE @CreatorId UniqueIdentifier
SELECT @CreatorId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueCreatorUserId = @CreatorId
ORDER BY
	IssueId Desc
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueAssignedUserId = @UserId
ORDER BY
	IssueId Desc
GO
/****** Object:  View [dbo].[BugNet_IssueAssignedToCountView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_IssueAssignedToCountView]
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
/****** Object:  View [dbo].[BugNet_Issue_IssueTypeCountView]    Script Date: 11/12/2012 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BugNet_Issue_IssueTypeCountView]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetOpenIssues]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetOpenIssues] 
	@ProjectId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
ORDER BY
	IssueId Desc
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueUserCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueTypeCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueStatusCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
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
/****** Object:  StoredProcedure [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]    Script Date: 11/12/2012 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
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
/****** Object:  Default [DF_BugNet_IssueAttachments_DateCreated]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueAttachments] ADD  CONSTRAINT [DF_BugNet_IssueAttachments_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_IssueComments_DateCreated]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueComments] ADD  CONSTRAINT [DF_BugNet_IssueComments_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_IssueHistory_DateCreated]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueHistory] ADD  CONSTRAINT [DF_BugNet_IssueHistory_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_Issues_DueDate]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_DueDate]  DEFAULT ('1/1/1900 12:00:00 AM') FOR [IssueDueDate]
GO
/****** Object:  Default [DF_BugNet_Issues_Estimation]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_Estimation]  DEFAULT ((0)) FOR [IssueEstimation]
GO
/****** Object:  Default [DF_BugNet_Issues_IssueProgress]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_IssueProgress]  DEFAULT ((0)) FOR [IssueProgress]
GO
/****** Object:  Default [DF_BugNet_Issues_DateCreated]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_Issues_Disabled]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_Disabled]  DEFAULT ((0)) FOR [Disabled]
GO
/****** Object:  Default [DF_BugNet_ProjectCategories_ParentCategoryId]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCategories] ADD  CONSTRAINT [DF_BugNet_ProjectCategories_ParentCategoryId]  DEFAULT ((0)) FOR [ParentCategoryId]
GO
/****** Object:  Default [DF_BugNet_ProjectCategories_Disabled]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCategories] ADD  CONSTRAINT [DF_BugNet_ProjectCategories_Disabled]  DEFAULT ((0)) FOR [Disabled]
GO
/****** Object:  Default [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] ADD  CONSTRAINT [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]  DEFAULT ((0)) FOR [CustomFieldSelectionSortOrder]
GO
/****** Object:  Default [DF_BugNet_ProjectMilestones_CreateDate]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMilestones] ADD  CONSTRAINT [DF_BugNet_ProjectMilestones_CreateDate]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_ProjectMilestones_Completed]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMilestones] ADD  CONSTRAINT [DF_BugNet_ProjectMilestones_Completed]  DEFAULT ((0)) FOR [MilestoneCompleted]
GO
/****** Object:  Default [DF_BugNet_Projects_DateCreated]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_BugNet_Projects_Active]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_Active]  DEFAULT ((0)) FOR [ProjectDisabled]
GO
/****** Object:  Default [DF_BugNet_Projects_AllowAttachments]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_AllowAttachments]  DEFAULT ((1)) FOR [AllowAttachments]
GO
/****** Object:  Default [DF_BugNet_Projects_AllowIssueVoting]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_AllowIssueVoting]  DEFAULT ((1)) FOR [AllowIssueVoting]
GO
/****** Object:  Default [DF_BugNet_Queries_IsPublic]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Queries] ADD  CONSTRAINT [DF_BugNet_Queries_IsPublic]  DEFAULT ((0)) FOR [IsPublic]
GO
/****** Object:  Default [DF_BugNet_UserProfiles_RecieveEmailNotifications]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserProfiles] ADD  CONSTRAINT [DF_BugNet_UserProfiles_RecieveEmailNotifications]  DEFAULT ((1)) FOR [ReceiveEmailNotifications]
GO
/****** Object:  Default [DF__BugNet_Us__Selec__7E42ABEE]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserProjects] ADD  CONSTRAINT [DF__BugNet_Us__Selec__7E42ABEE]  DEFAULT ((0)) FOR [SelectedIssueColumns]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueAttachments_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueAttachments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_IssueAttachments] CHECK CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueAttachments_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueAttachments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueAttachments] CHECK CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueComments_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueComments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueComments] CHECK CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueComments_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueComments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueComments] CHECK CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueHistory_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueHistory]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueHistory] CHECK CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueHistory_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueHistory]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueHistory] CHECK CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueNotifications_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueNotifications] CHECK CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueNotifications_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueNotifications] CHECK CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueRevisions_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueRevisions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueRevisions] CHECK CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users] FOREIGN KEY([IssueAssignedUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_aspnet_Users1]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users1] FOREIGN KEY([IssueOwnerUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users1]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_aspnet_Users2]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users2] FOREIGN KEY([LastUpdateUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users2]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_aspnet_Users3]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users3] FOREIGN KEY([IssueCreatorUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users3]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectCategories]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories] FOREIGN KEY([IssueCategoryId])
REFERENCES [dbo].[BugNet_ProjectCategories] ([CategoryId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectIssueTypes]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes] FOREIGN KEY([IssueTypeId])
REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectMilestones]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones] FOREIGN KEY([IssueMilestoneId])
REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectMilestones1]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1] FOREIGN KEY([IssueAffectedMilestoneId])
REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectPriorities]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities] FOREIGN KEY([IssuePriorityId])
REFERENCES [dbo].[BugNet_ProjectPriorities] ([PriorityId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectResolutions]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions] FOREIGN KEY([IssueResolutionId])
REFERENCES [dbo].[BugNet_ProjectResolutions] ([ResolutionId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_Issues_BugNet_ProjectStatus]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus] FOREIGN KEY([IssueStatusId])
REFERENCES [dbo].[BugNet_ProjectStatus] ([StatusId])
GO
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueVotes_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueVotes_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
GO
ALTER TABLE [dbo].[BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueWorkReports_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueWorkReports]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_IssueWorkReports] CHECK CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_IssueWorkReports_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_IssueWorkReports]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_IssueWorkReports] CHECK CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCategories_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCategories]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectCategories] CHECK CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFields]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType] FOREIGN KEY([CustomFieldTypeId])
REFERENCES [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCustomFields_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFields]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields] FOREIGN KEY([CustomFieldId])
REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields] FOREIGN KEY([CustomFieldId])
REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId])
GO
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectIssueTypes_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectIssueTypes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectIssueTypes] CHECK CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectMailBoxes_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users] FOREIGN KEY([AssignToUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes] FOREIGN KEY([IssueTypeId])
REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId])
GO
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectMailBoxes_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectMilestones_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectMilestones]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectMilestones] CHECK CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectNotifications_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectNotifications] CHECK CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectNotifications_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectNotifications] CHECK CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectPriorities_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectPriorities]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectPriorities] CHECK CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectResolutions_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectResolutions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectResolutions] CHECK CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_Projects_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Projects_aspnet_Users] FOREIGN KEY([ProjectCreatorUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Projects] CHECK CONSTRAINT [FK_BugNet_Projects_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_Projects_aspnet_Users1]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Projects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Projects_aspnet_Users1] FOREIGN KEY([ProjectManagerUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Projects] CHECK CONSTRAINT [FK_BugNet_Projects_aspnet_Users1]
GO
/****** Object:  ForeignKey [FK_BugNet_ProjectStatus_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_ProjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_ProjectStatus] CHECK CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_Queries_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Queries]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Queries_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_Queries] CHECK CONSTRAINT [FK_BugNet_Queries_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_Queries_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Queries]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Queries_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_Queries] CHECK CONSTRAINT [FK_BugNet_Queries_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_QueryClauses_BugNet_Queries]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_QueryClauses]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries] FOREIGN KEY([QueryId])
REFERENCES [dbo].[BugNet_Queries] ([QueryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_QueryClauses] CHECK CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries]
GO
/****** Object:  ForeignKey [FK_BugNet_RelatedIssues_BugNet_Issues]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_RelatedIssues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues] FOREIGN KEY([PrimaryIssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_RelatedIssues] CHECK CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues]
GO
/****** Object:  ForeignKey [FK_BugNet_RelatedIssues_BugNet_Issues1]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_RelatedIssues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1] FOREIGN KEY([SecondaryIssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
GO
ALTER TABLE [dbo].[BugNet_RelatedIssues] CHECK CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1]
GO
/****** Object:  ForeignKey [FK_BugNet_RolePermissions_BugNet_Permissions]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_RolePermissions]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[BugNet_Permissions] ([PermissionId])
GO
ALTER TABLE [dbo].[BugNet_RolePermissions] CHECK CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions]
GO
/****** Object:  ForeignKey [FK_BugNet_RolePermissions_BugNet_Roles]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[BugNet_Roles] ([RoleId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_RolePermissions] CHECK CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles]
GO
/****** Object:  ForeignKey [FK_BugNet_Roles_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_Roles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Roles_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_Roles] CHECK CONSTRAINT [FK_BugNet_Roles_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_UserProjects_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_UserProjects] CHECK CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_UserProjects_BugNet_Projects]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_UserProjects] CHECK CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects]
GO
/****** Object:  ForeignKey [FK_BugNet_UserRoles_aspnet_Users]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_UserRoles] CHECK CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users]
GO
/****** Object:  ForeignKey [FK_BugNet_UserRoles_BugNet_Roles]    Script Date: 11/12/2012 16:36:06 ******/
ALTER TABLE [dbo].[BugNet_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[BugNet_Roles] ([RoleId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_UserRoles] CHECK CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles]
GO
