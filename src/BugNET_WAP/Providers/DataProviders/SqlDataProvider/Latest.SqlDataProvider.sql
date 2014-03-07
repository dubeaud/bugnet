INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('GoogleAuthentication', 'False')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('FacebookAuthentication', 'False')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('FacebookAppId', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('FacebookAppSecret', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('TwitterAuthentication', 'False')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('TwitterConsumerKey', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('TwitterConsumerSecret', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('MicrosoftAuthentication', 'False')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('MicrosoftClientId', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('MicrosoftClientSecret', '')

DELETE FROM [dbo].[BugNet_HostSettings] WHERE SettingName = 'OpenIdAuthentication'
GO