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
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN AspNetUsers U ON BugNet_IssueAttachments.UserId = U.Id
WHERE
	IssueAttachmentId = @IssueAttachmentId
