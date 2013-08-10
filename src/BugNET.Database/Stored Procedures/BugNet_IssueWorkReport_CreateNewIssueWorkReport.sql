CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@IssueCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM Users WHERE UserName = @CreatorUserName
INSERT BugNet_IssueWorkReports
(
	IssueId,
	UserId,
	WorkDate,
	Duration,
	IssueCommentId
) 
VALUES 
(
	@IssueId,
	@CreatorUserId,
	@WorkDate,
	@Duration,
	@IssueCommentId
)
RETURN scope_identity()
