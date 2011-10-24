namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for HostSettings.
    /// </summary>
    public class HostSetting
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="HostSetting"/> class.
        /// </summary>
        /// <param name="settingName">Name of the setting.</param>
        /// <param name="settingValue">The setting value.</param>
        public HostSetting(string settingName, string settingValue)
        {
            SettingName = settingName;
            SettingValue = settingValue;
        }

        public HostSetting()
        {
            SettingName = string.Empty;
            SettingValue = string.Empty;
        }

        /// <summary>
        /// Gets the name of the setting.
        /// </summary>
        /// <value>The name of the setting.</value>
        public string SettingName { get; set; }

        /// <summary>
        /// Gets the setting value.
        /// </summary>
        /// <value>The setting value.</value>
        public string SettingValue { get; set; }
    }
}
