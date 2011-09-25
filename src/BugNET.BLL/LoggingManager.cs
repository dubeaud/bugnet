using System;
using System.Configuration;
using System.Web;
using log4net;
using log4net.Appender;

namespace BugNET.BLL
{
    /// <summary>
    /// Logging Class
    /// </summary>
    public static class LoggingManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Configures the logging.
        /// </summary>
        public static void ConfigureLogging()
        {
            ConfigureAdoNetAppender();
            //if email notification of errors are enabled create a smtp logging appender.
            if (Convert.ToBoolean(HostSettingManager.GetHostSetting("EmailErrors")))
                ConfigureEmailLoggingAppender();

        }

        /// <summary>
        /// Configures the ADO net appender.
        /// </summary>
        private static void ConfigureAdoNetAppender()
        {
            // Get the Hierarchy object that organizes the loggers
            var hier =
              log4net.LogManager.GetRepository() as log4net.Repository.Hierarchy.Hierarchy;

            if (hier == null) return;

            //get ADONetAppender
            var adoAppender =
                (AdoNetAppender)hier.Root.GetAppender("AdoNetAppender");

            if (adoAppender == null) return;

            adoAppender.ConnectionString = ConfigurationManager.ConnectionStrings["BugNET"].ConnectionString;
            adoAppender.ActivateOptions(); //refresh settings of appender
        }

        /// <summary>
        /// Adds the email logging appender.
        /// </summary>
        public static void ConfigureEmailLoggingAppender()
        {
            var hier =
            (log4net.Repository.Hierarchy.Hierarchy)log4net.LogManager.GetRepository();

            if (hier == null) return;

            var appender = (SmtpAppender)hier.Root.GetAppender("SmtpAppender") ?? new SmtpAppender();

            appender.Name = "SmtpAppender";
            appender.From = HostSettingManager.GetHostSetting("HostEmailAddress");
            appender.To = HostSettingManager.GetHostSetting("ErrorLoggingEmailAddress");
            appender.Subject = "BugNET Error";
            appender.SmtpHost = HostSettingManager.GetHostSetting("SMTPServer");
            appender.Priority = System.Net.Mail.MailPriority.High;
            appender.Threshold = log4net.Core.Level.Error;
            appender.BufferSize = 0;

            //create patternlayout
            var patternLayout = new
                log4net.Layout.PatternLayout("%newline%date [%thread] %-5level %logger [%property{NDC}] - %message%newline%newline%newline");

            patternLayout.ActivateOptions();
            appender.Layout = patternLayout;
            appender.ActivateOptions();

            //add appender to root logger
            hier.Root.AddAppender(appender);
        }

        /// <summary>
        /// Removes the email logging appender.
        /// </summary>
        public static void RemoveEmailLoggingAppender()
        {
            var hier =
             log4net.LogManager.GetRepository() as log4net.Repository.Hierarchy.Hierarchy;

            if (hier == null) return;

            var appender =
                (SmtpAppender)hier.Root.GetAppender("SmtpAppender");

            if (appender != null)
                hier.Root.RemoveAppender("SmtpAppender");
        }

        /// <summary>
        /// Gets the error message resource.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static string GetErrorMessageResource(string key)
        {
            return HttpContext.GetGlobalResourceObject("Exceptions", key) as string;
        }
    }
}
