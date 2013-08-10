CREATE PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
	@IssueId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @NotificationUserName

IF (NOT EXISTS(SELECT IssueNotificationId FROM BugNet_IssueNotifications WHERE UserId = @UserId AND IssueId = @IssueId) AND @UserId IS NOT NULL)
BEGIN
	INSERT BugNet_IssueNotifications
	(
		IssueId,
		UserId
	)
	VALUES
	(
		@IssueId,
		@UserId
	)
	RETURN scope_identity()
END
