CREATE PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @ProjectName nvarchar(50),
 @ProjectCode nvarchar(50),
 @ProjectDescription 	nvarchar(1000),
 @ProjectManagerUserName nvarchar(255),
 @AttachmentUploadPath nvarchar(80),
 @ProjectAccessType int,
 @ProjectCreatorUserName nvarchar(255),
 @AllowAttachments bit,
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
	SELECT @ProjectManagerUserId = UserId FROM Users WHERE UserName = @ProjectManagerUserName
	SELECT @ProjectCreatorUserId = UserId FROM Users WHERE UserName = @ProjectCreatorUserName
	
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
