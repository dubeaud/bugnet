using System;
using System.Threading;
using System.Web;
using BugNET.BLL;
using log4net;

namespace BugNET.HttpModules
{
    public class MailboxReaderModule : IHttpModule
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(MailboxReaderModule));
        static System.Threading.Timer timer;

        /// <summary>
        /// The smallest interval which is reasonable and will not cause
        /// system problems.
        /// Value is 10 seconds
        /// </summary>
        int minInterval = 10000;
        const int CNST_DefaultInterval = 120000;
        int interval = CNST_DefaultInterval;

        /// <summary>
        /// The amount of consecutive reader errors in a give time frame
        /// before the reader is disabled.        
        /// </summary>
        const int CNST_MaxReaderErrors = 10;



        /// <summary>
        /// Indicates the timer is running
        /// </summary>
        bool isTimerRunning = false;

        /// <summary>
        /// Gets the name of the module.
        /// </summary>
        /// <value>The name of the module.</value>
        public String ModuleName
        {
            get { return "MailboxReaderModule"; }
        }

        #region IHttpModule Members

        /// <summary>
        /// Disposes of the resources (other than memory) used by the module that implements <see cref="T:System.Web.IHttpModule"></see>.
        /// </summary>
        public void Dispose()
        {
            timer = null;
        }

        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpApplication"></see> that provides access to the methods, properties, and events common to all application objects within an ASP.NET application</param>
        public void Init(HttpApplication application)
        {
            bool ReaderEnabled = Convert.ToBoolean(HostSettingManager.GetHostSetting("Pop3ReaderEnabled"));

            // only run the rest of the code if we need to
            if (ReaderEnabled)
            {
                if (!isTimerRunning)
                {
                    try
                    {
                        interval = Convert.ToInt32(HostSettingManager.GetHostSetting("Pop3Interval"));
                    }
                    catch
                    {
                        Log.Warn(string.Format("Error in BugNET setting 'Pop3Interval'. Expecting Integer, value read '{0}'. ", HostSettingManager.GetHostSetting("Pop3Interval")));
                        interval = CNST_DefaultInterval;
                        Log.Warn(string.Format("Using default setting for 'Pop3Interval' in milliseconds '{0}'. ", CNST_DefaultInterval.ToString()));
                    }

                    if (interval < minInterval)
                    {
                        interval = minInterval;
                        Log.Warn(string.Format("'Pop3Interval' is too small. Using minimun threshold of {0}ms. ", minInterval.ToString()));
                    }

                    Log.Info("Enabling POP3 Reader");

                    // Wire-up application events
                    if (timer == null)
                    {
                        // Clear the number of consecutive errors we may have only when
                        // creating the timer.
                        ReaderErrors = 0;

                        timer = new System.Threading.Timer(new TimerCallback(ScheduledWorkCallback),
                        application.Context, interval, interval);
                    }
                }
            }
        }

        /// <summary>
        /// Scheduleds the work callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        private void ScheduledWorkCallback(object sender)
        {
            if (timer != null)
            {
                //stop the timer
                try
                {
                    timer.Change(Timeout.Infinite, Timeout.Infinite);

                    HttpContext context = (HttpContext)sender;
                    Poll(context);
                }
                finally
                {
                    // only restart the timer if all is ok
                    if (isReaderErrorFree)
                    {
                        if (isTimerRunning)
                        {
                            if (timer != null)
                            {
                                //start the timer 
                                timer.Change(interval, interval);
                            }
                        }
                    }
                }
            }
            else
            {
                // TIMER == NULL ????
                Log.Error("Mailbox reader timer is null!");

                ReaderErrors++;
                // Are there too many errors?
                CheckToDisableReader();
            }
        }

        /// <summary>
        /// Polls the mailbox using the specified context.
        /// </summary>
        /// <param name="context">The context.</param>
        private void Poll(HttpContext context)
        {
            //poll mailboxes here.
            HttpContext.Current = context;
            try
            {
                MailboxReader.MailboxReader mailboxReader = new MailboxReader.MailboxReader(HostSettingManager.GetHostSetting("Pop3Server"),
                        Convert.ToInt32(HostSettingManager.GetHostSetting("PopPort")),
                        Boolean.Parse(HostSettingManager.GetHostSetting("Pop3UseSSL")),
                        HostSettingManager.GetHostSetting("Pop3Username"),
                        HostSettingManager.GetHostSetting("Pop3Password"),
                        Convert.ToBoolean(HostSettingManager.GetHostSetting("Pop3InlineAttachedPictures")),
                        HostSettingManager.GetHostSetting("Pop3BodyTemplate"),
                        Convert.ToBoolean(HostSettingManager.GetHostSetting("Pop3DeleteAllMessages")),
                        HostSettingManager.GetHostSetting("Pop3ReportingUsername"),
                        Convert.ToBoolean(HostSettingManager.GetHostSetting("Pop3ProcessAttachments")));
                mailboxReader.ReadMail();

                // Clear the number of consecutive errors.
                ReaderErrors = 0;
            }
            catch (Exception ex)
            {
                //   Log.Error("Mailbox reader failed", ex); // too many log entries
                // Increment the number of consecutive errors.
                ReaderErrors++;
            }

            // Are there too many errors?
            CheckToDisableReader();
        }

        #endregion

        /// <summary>
        /// Internal flag to indicate if the reader has had too many errors.
        /// </summary>
        private bool isReaderErrorFree = true;

        private int ReaderErrors = 0;



        /// <summary>
        /// Checks to see if the reader has had a certain amount of errors
        /// consecutively. If it does it disables the mail reader.
        /// </summary>
        /// <returns>True, if the reader was disabled.</returns>
        private bool CheckToDisableReader()
        {
            if (ReaderErrors >= CNST_MaxReaderErrors)
            {
                DisableMailReaderWithLog();
                return true;
            }
            return false;
        }

        /// <summary>
        /// Disables the Mail Reader and log the event.
        /// </summary>
        private void DisableMailReaderWithLog()
        {
            Log.Error("Too many consecutive errors using pop3 reader.");
            Log.Error("POP3 Reader Disabled.");
            // Set the internal flag to off
            isReaderErrorFree = false;
            isTimerRunning = false;
            if (timer != null)
            {
                //try
                //{
                //    timer.Change(Timeout.Infinite, Timeout.Infinite);
                //}
                //finally
                //{
                timer.Dispose();
                //}
            }
        }

    }
}
