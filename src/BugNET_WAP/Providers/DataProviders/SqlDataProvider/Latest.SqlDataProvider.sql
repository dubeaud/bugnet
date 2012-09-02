
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