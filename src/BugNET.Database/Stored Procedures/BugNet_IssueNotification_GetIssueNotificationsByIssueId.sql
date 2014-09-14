
CREATE PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS


SET NOCOUNT ON
DECLARE @DefaultCulture NVARCHAR(50)
SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

DECLARE @tmpTable TABLE (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUserName nvarchar(50), NotificationDisplayName nvarchar(50), NotificationEmail nvarchar(50), NotificationCulture NVARCHAR(50))
INSERT @tmpTable

SELECT 
	IssueNotificationId,
	IssueId,
	U.Id NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	U.Email NotificationEmail,
	ISNULL(u.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN AspNetUsers U ON BugNet_IssueNotifications.UserId = U.Id
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.Id NotificationUserId,
	u.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	U.Email NotificationEmail,
	ISNULL(u.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	AspNetUsers u
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.Id = p.UserId

SELECT DISTINCT IssueId,NotificationUserId, NotificationUserName, NotificationDisplayName, NotificationEmail, NotificationCulture FROM @tmpTable ORDER BY NotificationDisplayName
