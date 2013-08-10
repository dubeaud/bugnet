CREATE PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
	@IssueCommentId int,
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@Comment ntext
AS

DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatorUserName

UPDATE BugNet_IssueComments SET
	IssueId = @IssueId,
	UserId = @UserId,
	Comment = @Comment
WHERE IssueCommentId= @IssueCommentId
