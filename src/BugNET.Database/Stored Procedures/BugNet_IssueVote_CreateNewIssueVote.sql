CREATE PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @VoteUserName

IF NOT EXISTS( SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
BEGIN
	INSERT BugNet_IssueVotes
	(
		IssueId,
		UserId,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		GETDATE()
	)
	RETURN scope_identity()
END
