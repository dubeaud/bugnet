
ALTER TABLE [dbo].[BugNet_UserProfiles] 
	DROP COLUMN [NotificationTypes];
GO

ALTER TABLE [dbo].[BugNet_UserProfiles]
	ADD [RecieveEmailNotifications] BIT DEFAULT 1 NOT NULL;
GO
