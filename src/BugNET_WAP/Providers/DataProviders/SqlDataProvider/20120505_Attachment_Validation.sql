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