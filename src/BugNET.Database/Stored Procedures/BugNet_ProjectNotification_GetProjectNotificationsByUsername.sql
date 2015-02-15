CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUserName] 
	@UserName nvarchar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN Memberships M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	U.UserId = @UserId
ORDER BY
	DisplayName
