CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueCommentId,
	IssueId,
	Comment,
	U.Id CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN AspNetUsers U ON BugNet_IssueComments.UserId = U.Id
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
