CREATE TABLE [dbo].[BugNet_HostSettings] (
    [SettingName]  NVARCHAR (50)  NOT NULL,
    [SettingValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_BugNet_HostSettings] PRIMARY KEY CLUSTERED ([SettingName] ASC)
);

