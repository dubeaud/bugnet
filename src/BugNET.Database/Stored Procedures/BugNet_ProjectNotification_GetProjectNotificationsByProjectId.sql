CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId] 
	@ProjectId Int
AS

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
WHERE
	P.ProjectId = @ProjectId
ORDER BY
	DisplayName
