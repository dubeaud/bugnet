CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]
 @IssueAttachmentId INT
AS
DELETE
FROM
	BugNet_IssueAttachments
WHERE
	IssueAttachmentId = @IssueAttachmentId
