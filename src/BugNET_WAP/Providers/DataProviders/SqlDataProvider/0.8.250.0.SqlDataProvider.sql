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
UPDATE BugNet_UserProfiles SET PreferredLocale = 'en-US' WHERE LOWER(PreferredLocale) = 'english'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
 @ProjectId int
AS
	SELECT 
		ISNULL(AssignedUsersProfile.DisplayName,u.Username ) AS 'Name',COUNT(I.IssueId) AS 'Number', u.UserName, ''
	FROM 
		BugNet_UserProjects pm 
		LEFT OUTER JOIN aspnet_Users u ON pm.UserId = u.UserId 
		LEFT OUTER JOIN BugNet_Issues I ON I.IssueAssignedUserId = u.UserId
		LEFT OUTER JOIN BugNet_UserProfiles AS AssignedUsersProfile ON u.UserName = AssignedUsersProfile.UserName
	WHERE 
		(pm.ProjectId = @ProjectId) 
		AND (I.ProjectId = @ProjectId ) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
	GROUP BY 
		u.Username, u.UserID,AssignedUsersProfile.DisplayName
	ORDER BY AssignedUsersProfile.DisplayName ASC
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Project_UpdateProject]    Script Date: 09/17/2010 10:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

/****** Object:  StoredProcedure [dbo].[BugNet_User_GetUsersByProjectId]    Script Date: 09/17/2010 13:18:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
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

/****** Object:  StoredProcedure [dbo].[BugNet_Project_DeleteProject]    Script Date: 09/15/2010 13:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Project_DeleteProject]
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

INSERT INTO [dbo].[BugNet_StringResources]
    VALUES ('Administration/Projects/EditProject.aspx', 'en', 'DisableProject', 'Disable Project')
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectByMailbox]    Script Date: 09/06/2010 13:02:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectByMailbox]
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

/****** Object:  StoredProcedure [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]    Script Date: 09/23/2010 13:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
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

COMMIT

SET NOEXEC OFF
GO