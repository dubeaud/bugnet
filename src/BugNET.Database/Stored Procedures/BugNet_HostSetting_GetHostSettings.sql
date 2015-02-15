CREATE PROCEDURE [dbo].[BugNet_HostSetting_GetHostSettings] AS

SELECT SettingName, SettingValue FROM BugNet_HostSettings
