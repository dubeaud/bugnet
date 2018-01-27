CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
	@UserName nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @Disabled bit
SET @Disabled = 1
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
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
	AttachmentStorageType,
	SvnRepositoryUrl,
	AllowIssueVoting
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
     (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND (UP.UserId = @UserId  or ProjectManagerUserId=@UserId ))
 
ORDER BY ProjectName ASC
