
ALTER TABLE [dbo].[BugNet_UserProfiles] 
	DROP COLUMN [NotificationTypes];
GO

ALTER TABLE [dbo].[BugNet_UserProfiles]
	ADD [ReceiveEmailNotifications] BIT DEFAULT 1 NOT NULL;
GO

UPDATE BugNet_HostSettings
SET SettingValue = 'templates/NewMailboxIssue.xslt'
WHERE SettingName = 'Pop3BodyTemplate'
GO

ALTER PROCEDURE [BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level
*/

SET NOCOUNT ON

DECLARE
	@DefaultCulture NVARCHAR(50)

SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId AS NotificationUserId,
	U.UserName AS NotificationUsername,
	ISNULL(DisplayName,'') AS NotificationDisplayName,
	M.Email AS NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles UP ON U.UserName = UP.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName
GO