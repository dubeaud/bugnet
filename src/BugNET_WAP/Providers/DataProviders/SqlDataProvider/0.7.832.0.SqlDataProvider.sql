PRINT 'Updating Host Settings'
UPDATE HostSettings SET SettingValue = '@VERSION@.0' WHERE SettingName = 'Version'