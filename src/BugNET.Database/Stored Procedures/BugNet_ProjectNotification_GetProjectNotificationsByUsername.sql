CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUserName] 
	@UserName nvarchar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = Id FROM AspNetUsers WHERE UserName = @UserName

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.Id NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	U.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN AspNetUsers U ON BugNet_ProjectNotifications.UserId = U.Id
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	U.Id = @UserId
ORDER BY
	DisplayName
