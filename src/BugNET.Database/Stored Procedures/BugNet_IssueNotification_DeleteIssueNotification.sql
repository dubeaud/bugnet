CREATE PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
	@IssueId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
DELETE 
	BugNet_IssueNotifications
WHERE
	IssueId = @IssueId
	AND UserId = @UserId
