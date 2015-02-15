CREATE PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @VoteUserName

BEGIN
    IF EXISTS(SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
        RETURN(1)
    ELSE
        RETURN(0)
END
