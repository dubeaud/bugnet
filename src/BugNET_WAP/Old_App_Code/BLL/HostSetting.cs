using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Caching;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
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

        /// <summary>
        /// Updates the host setting.
        /// </summary>
        /// <param name="settingName">Name of the setting.</param>
        /// <param name="settingValue">The setting value.</param>
        /// <returns></returns>
        public static bool UpdateHostSetting(string settingName, string settingValue)
        {
            if (GetHostSettings().Contains(settingName))
            {
                if (DataProviderManager.Provider.UpdateHostSetting(settingName, settingValue))
                {
                    HttpContext.Current.Cache.Remove("HostSettings");
                    GetHostSettings();
                }
            }
            return false;
        }



        /// <summary>
        /// Gets the host setting.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static string GetHostSetting(string key)
        {
            if (GetHostSettings().Contains(key))
            {
                return Convert.ToString(GetHostSettings()[key]);
            }
            else
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// Gets the host setting
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value if the setting is missing or is an invalid type</param>
        /// <returns></returns>
        public static int GetHostSetting(string key, int defaultValue)
        {
            int val = defaultValue;

            if (GetHostSettings().Contains(key))
            {
                string setting = Convert.ToString(GetHostSettings()[key]);
                if (!int.TryParse(setting, out val)) // tryparse fail return default value
                    return defaultValue;
            }

            return val;
        }

        /// <summary>
        /// Gets the host setting
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value if the setting is missing or is an invalid type</param>
        /// <returns></returns>
        public static bool GetHostSetting(string key, bool defaultValue)
        {
            bool val = defaultValue;
            string setting = "";

            if (GetHostSettings().Contains(key))
            {
                setting = Convert.ToString(GetHostSettings()[key]);
                if (bool.TryParse(setting.ToLower(), out val))
                    return val;
            }

            return val;
        }

        /// <summary>
        /// Gets the host setting
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value if the setting is missing or is an invalid type</param>
        /// <returns></returns>
        public static string GetHostSetting(string key, string defaultValue)
        {
            string val = defaultValue;
            string setting = "";

            if (GetHostSettings().Contains(key))
            {
                setting = Convert.ToString(GetHostSettings()[key]);
                if (setting.Length > 0)
                    val = setting;
            }

            return val;
        }

        /// <summary>
        /// Gets the host settings.
        /// </summary>
        /// <returns></returns>
        public static Hashtable GetHostSettings()
        {
            Hashtable h;
            h = (Hashtable)HttpRuntime.Cache["HostSettings"];

            if (h == null)
            {
                h = new Hashtable();

                List<HostSetting> al = DataProviderManager.Provider.GetHostSettings();

                foreach (HostSetting hs in al)
                {
                    h.Add(hs.SettingName, hs.SettingValue);
                }

                HttpRuntime.Cache.Insert("HostSettings", h);
            }

            return h;
        }

    }
}
