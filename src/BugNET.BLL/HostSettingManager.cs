using System;
using System.Collections;
using System.Web;
using BugNET.DAL;
using log4net;

namespace BugNET.BLL
{
    public sealed class HostSettingManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

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
            return GetHostSettings().Contains(key) ? Convert.ToString(GetHostSettings()[key]) : string.Empty;
        }

        /// <summary>
        /// Gets the host setting
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value if the setting is missing or is an invalid type</param>
        /// <returns></returns>
        public static int GetHostSetting(string key, int defaultValue)
        {
            var val = defaultValue;

            if (GetHostSettings().Contains(key))
            {
                var setting = Convert.ToString(GetHostSettings()[key]);
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
            var val = defaultValue;

            if (GetHostSettings().Contains(key))
            {
                var setting = Convert.ToString(GetHostSettings()[key]);
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
            var val = defaultValue;

            if (GetHostSettings().Contains(key))
            {
                var setting = Convert.ToString(GetHostSettings()[key]);
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

                var al = DataProviderManager.Provider.GetHostSettings();

                foreach (var hs in al)
                {
                    h.Add(hs.SettingName, hs.SettingValue);
                }

                HttpRuntime.Cache.Insert("HostSettings", h);
            }

            return h;
        }

        /// <summary>
        /// Gets the SMTP server.
        /// </summary>
        /// <value>The SMTP server.</value>
        public static string SmtpServer
        {
            get
            {
                var str = GetHostSetting("SMTPServer");

                if (String.IsNullOrEmpty(str))
                    throw (new ApplicationException("SmtpServer configuration is missing or not set, check the host settings"));

                return (str);
            }
        }

        /// <summary>
        /// Gets the host email address.
        /// </summary>
        /// <value>The host email address.</value>
        public static string HostEmailAddress
        {
            get
            {
                var str = GetHostSetting("HostEmailAddress");

                if (String.IsNullOrEmpty(str))
                    throw (new ApplicationException("Host email address is not set, check the host settings."));

                return (str);
            }
        }

        /// <summary>
        /// Gets the user account source.
        /// </summary>
        /// <value>The user account source.</value>
        public static string UserAccountSource
        {
            get
            {
                var str = GetHostSetting("UserAccountSource");

                if (String.IsNullOrEmpty(str))
                    throw (new ApplicationException("UserAccountSource configuration is not set properly, check the host settings."));

                return (str);
            }
        }

        /// <summary>
        /// Gets the default URL.
        /// </summary>
        /// <value>The default URL.</value>
        public static string DefaultUrl
        {
            get
            {
                var str = GetHostSetting("DefaultUrl");

                if (String.IsNullOrEmpty(str))
                {
                    throw (new ApplicationException("DefaultUrl configuration is not set, check the host settings."));
                }

                return str.EndsWith("/") ? (str) : (string.Concat(str, "/"));
            }
        }

        /// <summary>
        /// Gets the template path.  Virtual for unit testing
        /// </summary>
        /// <value>The template path.</value>
        public static string TemplatePath
        {
            get
            {
                var str = GetHostSetting("SMTPEmailTemplateRoot", "~/templates");

                str = HttpContext.Current.Server.MapPath(str);

                if (!System.IO.Directory.Exists(str))
                    throw new Exception(string.Format("The configured path: [{0}] does not exist, cannot load Xslt template", str));

                if (!str.EndsWith("\\"))
                    str += "\\";

                return (str);
            }
        }
    }
}
