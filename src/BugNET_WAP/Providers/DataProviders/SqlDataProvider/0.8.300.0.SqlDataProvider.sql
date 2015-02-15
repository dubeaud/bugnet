/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

CREATE TABLE dbo.Tmp_BugNet_UserProfiles
	(
	UserName nvarchar(256) NOT NULL,
	FirstName nvarchar(100) NULL,
	LastName nvarchar(100) NULL,
	DisplayName nvarchar(100) NULL,
	IssuesPageSize int NULL,
	NotificationTypes nvarchar(255) NULL,
	PreferredLocale nvarchar(50) NULL,
	LastUpdate datetime NOT NULL,
	SelectedIssueColumns nvarchar(50) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.BugNet_UserProfiles)
	 EXEC('INSERT INTO dbo.Tmp_BugNet_UserProfiles (UserName, FirstName, LastName, DisplayName, IssuesPageSize, NotificationTypes, PreferredLocale, LastUpdate, SelectedIssueColumns)
		SELECT UserName, FirstName, LastName, DisplayName, IssuesPageSize, NotificationTypes, PreferredLocale, LastUpdate, SelectedIssueColumns FROM dbo.BugNet_UserProfiles WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.BugNet_UserProfiles
GO
EXECUTE sp_rename N'dbo.Tmp_BugNet_UserProfiles', N'BugNet_UserProfiles', 'OBJECT' 
GO
ALTER TABLE dbo.BugNet_UserProfiles ADD CONSTRAINT
	PK_BugNet_UserProfiles PRIMARY KEY CLUSTERED 
	(
	UserName
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level*/
declare @tmpTable table (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUsername nvarchar(256), NotificationDisplayName nvarchar(100), NotificationEmail nvarchar(100))
INSERT @tmpTable

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.UserId NotificationUserId,
	u.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	m.Email NotificationEmail
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	aspnet_Users u,
	aspnet_Membership m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT DISTINCT IssueId,NotificationUserId, NotificationUsername, NotificationDisplayName, NotificationEmail FROM @tmpTable
GO

INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages', N'en', N'CouldNotCreateUploadDirectory', N'There was an error creating the upload directory.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages', N'en', N'CouldNotLoadNotificationType', N'There was an error loading the notification type.')
INSERT [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES (N'ErrorMessages', N'en', N'CouldNotCreateDefaultProjectRoles', N'There was an error creating the default project roles.')
GO

COMMIT
GO

SET NOEXEC OFF
GO