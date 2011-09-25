namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for HostSettings.
    /// </summary>
    public class HostSetting
    {
        private string _SettingName;
        private string _SettingValue;

        /// <summary>
        /// Initializes a new instance of the <see cref="T:HostSettings"/> class.
        /// </summary>
        /// <param name="settingName">Name of the setting.</param>
        /// <param name="settingValue">The setting value.</param>
        public HostSetting(string settingName, string settingValue)
        {
            _SettingName = settingName;
            _SettingValue = settingValue;
        }

        /// <summary>
        /// Gets the name of the setting.
        /// </summary>
        /// <value>The name of the setting.</value>
        public string SettingName
        {
            get { return _SettingName; }
        }
        /// <summary>
        /// Gets the setting value.
        /// </summary>
        /// <value>The setting value.</value>
        public string SettingValue
        {
            get { return _SettingValue; }
        }

        

    }
}
