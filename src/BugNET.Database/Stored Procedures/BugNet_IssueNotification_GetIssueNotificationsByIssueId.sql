
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
	U.UserId NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN Memberships M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles UP ON U.UserName = UP.UserName
WHERE
	IssueId = @IssueId
	AND M.Email IS NOT NULL
ORDER BY
	DisplayName

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.UserId NotificationUserId,
	u.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	m.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	Users u,
	Memberships m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT DISTINCT IssueId,NotificationUserId, NotificationUserName, NotificationDisplayName, NotificationEmail, NotificationCulture FROM @tmpTable ORDER BY NotificationDisplayName
