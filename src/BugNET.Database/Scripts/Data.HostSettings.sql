-- Reference Data for BugNet_HostSettings
MERGE INTO BugNet_HostSettings AS Target 
USING (VALUES 
	(N'AdminNotificationUsername', N'admin'),
	(N'ADPassword', N''),
	(N'ADPath', N''),
	(N'ADUserName', N''),
	(N'AllowedFileExtensions', N'*.*'),
	(N'ApplicationTitle', N'BugNET Issue Tracker'),
	(N'DefaultUrl', N'http://localhost/BugNet/'),
	(N'AnonymousAccess', N'False'),
	(N'UserRegistration', N'0'),
	(N'EmailErrors', N'False'),
	(N'EnableRepositoryCreation', N'True'),
	(N'ErrorLoggingEmailAddress', N'myemail@mysmtpserver.com'),
	(N'FileSizeLimit', N'2024'),
	(N'HostEmailAddress', N'noreply@mysmtpserver.com'),
	(N'Pop3BodyTemplate', N'templates/NewMailboxIssue.xslt'),
	(N'Pop3DeleteAllMessages', N'False'),
	(N'Pop3InlineAttachedPictures', N'False'),
	(N'Pop3Interval', N'6000'),
	(N'Pop3Password', N''),
	(N'Pop3ReaderEnabled', N'True'),
	(N'Pop3ReportingUsername', N'Admin'),
	(N'Pop3Server', N''),
	(N'Pop3Username', N'bugnetuser'),
	(N'Pop3UseSSL', N'False'),
	(N'RepositoryBackupPath', N''),
	(N'RepositoryRootPath', N'C:\\SVN\\'),
	(N'RepositoryRootUrl', N'svn://localhost/'),
	(N'SMTPAuthentication', N'False'),
	(N'SMTPPassword', N''),
	(N'SMTPPort', N'25'),
	(N'SMTPServer', N'localhost'),
	(N'SMTPUsername', N''),
	(N'SMTPUseSSL', N'False'),
	(N'SvnAdminEmailAddress', N''),
	(N'SvnHookPath', N''),
	(N'UserAccountSource', N'None'),
	(N'Version', N''),
	(N'WelcomeMessage', N'Welcome to your new BugNET installation! Log in as <br/><br/> Username: admin <br/>Password: password'),
	(N'OpenIdAuthentication', N'False'),
	(N'SMTPEmailTemplateRoot', N'~/templates'),
	(N'SMTPEMailFormat', N'2'),
	(N'SMTPDomain', N''),
	(N'ApplicationDefaultLanguage', N'en-US'),
	(N'Pop3ProcessAttachments', N'False'),
	(N'EnableGravatar', N'False'),
	(N'GoogleAuthentication', N'False'),
	(N'GoogleClientId', N''),
	(N'GoogleClientSecret', N''),
	(N'FacebookAuthentication', N'False'),
	(N'FacebookAppId', N''),
	(N'FacebookAppSecret', N''),
	(N'TwitterAuthentication', N'False'),
	(N'TwitterConsumerKey', N''),
	(N'TwitterConsumerSecret', N''),
	(N'MicrosoftAuthentication', N'False'),
	(N'MicrosoftClientId', N''),
	(N'MicrosoftClientSecret', N'')
) 
AS Source ([SettingName], [SettingValue]) 
ON Target.SettingName = Source.SettingName
-- update matched rows 
--WHEN MATCHED THEN 
--UPDATE SET SettingName = Source.SettingName, SettingValue = Source.SettingValue
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (SettingName, SettingValue) 
VALUES (SettingName, SettingValue) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;