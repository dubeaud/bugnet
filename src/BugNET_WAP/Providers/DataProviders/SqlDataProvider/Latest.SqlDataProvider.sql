INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('de-DE', 'German (Germany)', 'en-US')
GO

IF NOT EXISTS(SELECT * FROM [dbo].[BugNet_HostSettings] WHERE [SettingName] = 'EnableGravatar')
BEGIN
    INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('EnableGravatar', 'False')
END
GO