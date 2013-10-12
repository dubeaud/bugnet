IF NOT EXISTS(SELECT * FROM [dbo].[BugNet_HostSettings] WHERE SettingName = 'EnableGravatar')
BEGIN
        INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('EnableGravatar', 'False')
END
GO