CREATE PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
	@ActiveOnly BIT = NULL
AS
SELECT 
	ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	DateCreated,
	ProjectDisabled,
	ProjectAccessType,
	ManagerUserName,
	ManagerDisplayName,
	CreatorUserName,
	CreatorDisplayName,
	AllowAttachments,
	SvnRepositoryUrl,
	AllowIssueVoting
FROM 
	BugNet_ProjectsView 
WHERE (@ActiveOnly IS NULL OR (ProjectDisabled = ~@ActiveOnly))
