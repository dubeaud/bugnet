using System;
using System.Threading;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using log4net;

namespace BugNET.HttpModules
{
    public class MailboxReaderModule : IHttpModule
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(MailboxReaderModule));
        static Timer _timer;

        /// <summary>
        /// The smallest interval which is reasonable and will not cause
        /// system problems.
        /// Value is 10 seconds
        /// </summary>
        private const int MinInterval = 10000;

        const int CnstDefaultInterval = 120000;
        int _interval = CnstDefaultInterval;

        /// <summary>
        /// The amount of consecutive reader errors in a give time frame
        /// before the reader is disabled.        
        /// </summary>
        const int CnstMaxReaderErrors = 10;

        /// <summary>
        /// Indicates the timer is running
        /// </summary>
        bool _isTimerRunning;

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
            _timer = null;
        }

        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="application"></param>
        public void Init(HttpApplication application)
        {
            var readerEnabled = Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3ReaderEnabled));

            // only run the rest of the code if we need to
            if (!readerEnabled) return;

            if (!_isTimerRunning)
            {
                try
                {
                    _interval = Convert.ToInt32(HostSettingManager.Get(HostSettingNames.Pop3Interval));
                }
                catch
                {
                    Log.Warn(string.Format("Error in BugNET setting 'Pop3Interval'. Expecting Integer, value read '{0}'. ", HostSettingManager.Get(HostSettingNames.Pop3Interval)));
                    _interval = CnstDefaultInterval;
                    Log.Warn(string.Format("Using default setting for 'Pop3Interval' in milliseconds '{0}'. ", CnstDefaultInterval.ToString()));
                }

                if (_interval < MinInterval)
                {
                    _interval = MinInterval;
                    Log.Warn(string.Format("'Pop3Interval' is too small. Using minimun threshold of {0}ms. ", MinInterval.ToString()));
                }

                Log.Info("Enabling POP3 Reader");

                // Wire-up application events
                if (_timer == null)
                {
                    // Clear the number of consecutive errors we may have only when
                    // creating the timer.
                    _readerErrors = 0;

                    _timer = new Timer(ScheduledWorkCallback, application.Context, _interval, _interval);
                }
            }
        }

        /// <summary>
        /// Scheduleds the work callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        private void ScheduledWorkCallback(object sender)
        {
            if (_timer != null)
            {
                //stop the timer
                try
                {
                    _timer.Change(Timeout.Infinite, Timeout.Infinite);

                    var context = (HttpContext)sender;
                    Poll(context);
                }
                finally
                {
                    // only restart the timer if all is ok
                    if (_isReaderErrorFree)
                    {
                        if (_isTimerRunning)
                        {
                            if (_timer != null)
                            {
                                //start the timer 
                                _timer.Change(_interval, _interval);
                            }
                        }
                    }
                }
            }
            else
            {
                // TIMER == NULL ????
                Log.Error("Mailbox reader timer is null!");

                _readerErrors++;
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
                var mailboxReader = new MailboxReader.MailboxReader(HostSettingManager.Get(HostSettingNames.Pop3Server),
                        Convert.ToInt32(HostSettingManager.Get(HostSettingNames.Pop3Port)),
                        Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3UseSSL)),
                        HostSettingManager.Get(HostSettingNames.Pop3Username),
                        HostSettingManager.Get(HostSettingNames.Pop3Password),
                        Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3InlineAttachedPictures)),
                        HostSettingManager.Get(HostSettingNames.Pop3BodyTemplate),
                        Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3DeleteAllMessages)),
                        HostSettingManager.Get(HostSettingNames.Pop3ReportingUsername),
                        Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3ProcessAttachments)));
                mailboxReader.ReadMail();

                // Clear the number of consecutive errors.
                _readerErrors = 0;
            }
            catch (Exception)
            {
                //   Log.Error("Mailbox reader failed", ex); // too many log entries
                // Increment the number of consecutive errors.
                _readerErrors++;
            }

            // Are there too many errors?
            CheckToDisableReader();
        }

        #endregion

        /// <summary>
        /// Internal flag to indicate if the reader has had too many errors.
        /// </summary>
        private bool _isReaderErrorFree = true;

        private int _readerErrors;



        /// <summary>
        /// Checks to see if the reader has had a certain amount of errors
        /// consecutively. If it does it disables the mail reader.
        /// </summary>
        /// <returns>True, if the reader was disabled.</returns>
        private bool CheckToDisableReader()
        {
            if (_readerErrors >= CnstMaxReaderErrors)
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
            _isReaderErrorFree = false;
            _isTimerRunning = false;
            if (_timer != null)
            {
                //try
                //{
                //    timer.Change(Timeout.Infinite, Timeout.Infinite);
                //}
                //finally
                //{
                _timer.Dispose();
                //}
            }
        }

    }
}
