/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectsByMemberUsername]    Script Date: 06/13/2012 12:09:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectsByMemberUsername]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
	@Username NVARCHAR(255),
	@ActiveOnly BIT
AS

SET NOCOUNT ON

DECLARE
	@RequestingUserID UNIQUEIDENTIFIER,
	@Disabled BIT,
	@IsSuperUser BIT

SET @Disabled = 1

IF @ActiveOnly = 1
	BEGIN
		SET @Disabled = 0
	END

EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @Username, @UserId = @RequestingUserID OUTPUT

SET @IsSuperUser =
(
	SELECT COUNT(*)
	FROM BugNet_UserRoles ur
	INNER JOIN BugNet_Roles r ON ur.RoleId = r.RoleId
	WHERE r.RoleId = 1
	AND ur.UserId = @RequestingUserId
)

SELECT DISTINCT 
	pv.ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	pv.DateCreated,
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
FROM [BugNet_ProjectsView] pv
LEFT JOIN BugNet_UserProjects up ON up.ProjectId = pv.ProjectId 
WHERE ProjectDisabled = @Disabled
AND (
		(@IsSuperUser = 1) OR /* super user can see all */
		(
			(ProjectAccessType = 1) OR /* project access is public */
			(
				ProjectAccessType = 2 AND
				(up.UserId = @RequestingUserId OR ProjectManagerUserId = @RequestingUserId)
			)
		)
	)
ORDER BY ProjectName ASC
GO


