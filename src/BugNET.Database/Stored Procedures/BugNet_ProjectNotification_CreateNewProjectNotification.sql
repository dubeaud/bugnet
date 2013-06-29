CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
	@ProjectId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @NotificationUserName

IF NOT EXISTS( SELECT ProjectNotificationId FROM BugNet_ProjectNotifications WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT BugNet_ProjectNotifications
	(
		ProjectId,
		UserId
	)
	VALUES
	(
		@ProjectId,
		@UserId
	)
	RETURN scope_identity()
END
