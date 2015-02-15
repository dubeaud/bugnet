CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
 @IssueCommentId INT
AS
SELECT
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueCommentId = @IssueCommentId
