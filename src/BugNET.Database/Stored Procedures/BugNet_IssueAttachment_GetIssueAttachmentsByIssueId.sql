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
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
