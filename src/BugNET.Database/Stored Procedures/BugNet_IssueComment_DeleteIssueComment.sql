CREATE PROCEDURE [dbo].[BugNet_IssueComment_DeleteIssueComment]
	@IssueCommentId Int
AS
DELETE 
	BugNet_IssueComments
WHERE
	IssueCommentId = @IssueCommentId
