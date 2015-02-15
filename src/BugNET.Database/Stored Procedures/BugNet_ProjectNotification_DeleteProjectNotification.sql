CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
DELETE 
	BugNet_ProjectNotifications
WHERE
	ProjectId = @ProjectId
	AND UserId = @UserId
