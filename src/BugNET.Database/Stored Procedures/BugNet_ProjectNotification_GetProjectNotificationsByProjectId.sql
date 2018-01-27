CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId] 
	@ProjectId Int
AS

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
	P.ProjectId = @ProjectId
ORDER BY
	DisplayName
