using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using BugNET.Common;
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
        /// <param name="key">Key of the setting.</param>
        /// <param name="settingValue">The setting value.</param>
        /// <returns></returns>
        public static bool UpdateHostSetting(HostSettingNames key, string settingValue)
        {
            if (GetHostSettings().Contains(key.ToString()))
            {
                if (DataProviderManager.Provider.UpdateHostSetting(key.ToString(), settingValue))
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
        public static string Get(HostSettingNames key)
        {
            return Get(key, String.Empty);
        }

        public static T Get<T>(HostSettingNames key, T defaultValue) where T : IConvertible
        {
            var val = defaultValue;

            if (GetHostSettings().Contains(key.ToString()))
            {
                var setting = Convert.ToString(GetHostSettings()[key.ToString()]);

                var converter = TypeDescriptor.GetConverter(typeof(T));
                if (converter != null)
                {
                    // this will throw an exception when conversion is not possible
                    val = (T)converter.ConvertFromString(setting);
                }
            }

            return val;
        }

        /// <summary>
        /// Gets the host setting
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value if the setting is missing or is an invalid type</param>
        /// <returns></returns>
        public static bool Get(HostSettingNames key, bool defaultValue)
        {
            var val = defaultValue;

            if (GetHostSettings().Contains(key.ToString()))
            {
                var setting = Convert.ToString(GetHostSettings()[key.ToString()]).ToLower();
                if (setting.Equals("1")) return true;

                if (bool.TryParse(setting.ToLower(), out val))
                    return val;
            }

            return val;
        }

        /// <summary>
        /// Gets the host settings.
        /// </summary>
        /// <returns></returns>
        public static Hashtable GetHostSettings()
        {
            var h = (Hashtable)HttpRuntime.Cache["HostSettings"];

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
                var val = Get(HostSettingNames.SMTPServer);

                if (String.IsNullOrEmpty(val))
                    throw (new ApplicationException(string.Format("{0} configuration is missing or not set, check the host settings", HostSettingNames.SMTPServer)));

                return val;
            }
        }

        /// <summary>
        /// Gets the SMTP server.
        /// </summary>
        /// <value>The SMTP server.</value>
        public static int SmtpPort
        {
            get
            {
                var val = Get(HostSettingNames.SMTPPort, -1);

                if (val.Equals(-1))
                    throw (new ApplicationException(string.Format("{0} configuration is missing or not set, check the host settings", HostSettingNames.SMTPPort)));

                return val;
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
                var val = Get(HostSettingNames.HostEmailAddress);

                if (String.IsNullOrEmpty(val))
                    throw (new ApplicationException(string.Format("{0} configuration is missing or not set, check the host settings", HostSettingNames.HostEmailAddress)));

                return (val);
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
                var val = Get(HostSettingNames.UserAccountSource);

                if (String.IsNullOrEmpty(val))
                    throw (new ApplicationException(string.Format("{0} configuration is missing or not set, check the host settings", HostSettingNames.UserAccountSource)));

                return (val);
            }
        }

        /// <summary>
        /// Gets the application title.
        /// </summary>
        /// <value>The application title.</value>
        public static string ApplicationTitle
        {
            get
            {
                return Get(HostSettingNames.ApplicationTitle, "BugNET Issue Tracker");
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
                var val = Get(HostSettingNames.DefaultUrl);

                if (String.IsNullOrEmpty(val))
                    throw (new ApplicationException(string.Format("{0} configuration is missing or not set, check the host settings", HostSettingNames.DefaultUrl)));

                return val.EndsWith("/") ? (val) : (string.Concat(val, "/"));
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
                var val = Get(HostSettingNames.SMTPEmailTemplateRoot, "~/templates");

                val = HttpContext.Current.Server.MapPath(val);

                if (!System.IO.Directory.Exists(val))
                    throw new Exception(string.Format("The configured path: [{0}] does not exist, cannot load Xslt template", val));

                if (!val.EndsWith("\\"))
                    val += "\\";

                return (val);
            }
        }
    }
}
