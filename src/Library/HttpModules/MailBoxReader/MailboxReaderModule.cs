using System;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using BugNET.MailboxReader;
using log4net;

namespace BugNET.HttpModules
{    
    /// <summary>
    /// 
    /// </summary>
    public class MailboxReaderModule : IHttpModule
    {
        static readonly object _locker = new object();

        static readonly ILog Log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        
        static Timer _timer;

        /// <summary>
        /// The smallest interval which is reasonable and will not cause
        /// system problems.
        /// Value is 10 seconds
        /// </summary>
        const int MIN_INTERVAL = 10000;

        const int CNST_DEFAULT_INTERVAL = 120000;

        static int _interval;

        // the reader is polling the POP3 mailbox
        static bool _isMailboxReaderProcessing;

        // the timer is created and active
        static bool _timerIsActive;

        // the number of concurrent errors thrown
        static int _readerErrors;

        // has the number of concurrent errors hit the max and we have disabled the timer
        static bool _timerIsDisabled;

        /// <summary>
        /// The amount of consecutive reader errors in a give time frame
        /// before the reader is disabled.        
        /// </summary>
        const int CNST_MAX_READER_ERRORS = 10;

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
            // removed by WRH 2012-08-18
            // disposed is called at random times during the lifecycle and the issue is that the Init is not called again
            // because of this we should only clear resources that would otherwise be built again in the callback
            // the timer is not one of them.  by default the finalize thread should kill the timer when the handler
            // gets killed by the pipeline
            //_timer = null;
        }

        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="application"></param>
        public void Init(HttpApplication application)
        {
            var readerEnabled = HostSettingManager.Get(HostSettingNames.Pop3ReaderEnabled, false);

            // only run the rest of the code if we need to
            // check to see if the timer is active and the reader is now disabled
            // if so we will turn it off only if we are not processing a poll
            if (!readerEnabled)
            {
                lock (_locker)
                {
                    if (_timerIsActive && !_isMailboxReaderProcessing)
                    {
                        _timer.Change(Timeout.Infinite, Timeout.Infinite);
                        _isMailboxReaderProcessing = false;
                        _timerIsActive = false;
                        _timer.Dispose();
                        _timer = null;
                        Log.Warn("MailboxReaderModule: User disabled POP3 reader via host settings");
                    }
                }

                return;
            }

            // is the timer already active?
            if (_timerIsActive) return;

            Log.Info("MailboxReaderModule: Enabling POP3 reader");

            // get the interval
            _interval = HostSettingManager.Get(HostSettingNames.Pop3Interval, CNST_DEFAULT_INTERVAL);

            // if the interval is to small change to the min interval
            if (_interval < MIN_INTERVAL)
            {
                _interval = MIN_INTERVAL;
                Log.Warn(string.Format("MailboxReaderModule: [Pop3Interval] was too small. Using minimum threshold of {0} milliseconds", MIN_INTERVAL));
            }
            else
            {
                Log.Info(string.Format("MailboxReaderModule: Enabling threshold of {0} milliseconds", _interval));
            }

            // Clear the number of consecutive errors we may have only when
            // creating the timer.
            lock (_locker) _readerErrors = 0;

            var uploadPath = HostSettingManager.Get(HostSettingNames.AttachmentUploadPath);
            if(uploadPath.StartsWith("~"))
            {
                uploadPath = application.Context.Server.MapPath(uploadPath);
            }

            var state = new MailboxReaderThreadState
            {
                UploadsFolderPath = uploadPath,
            };

            // create the timer instance
            // don't spin it up right away, wait a few
            // this to allow the asp.net worker thread time to get going
            // no need to bog down the threading while spin up.
            _timer = new Timer(ScheduledWorkCallback, state, 15, _interval);

            // set the timer to active
            lock (_locker) _timerIsActive = true;
        }

        /// <summary>
        /// Schedule's the work callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        private static void ScheduledWorkCallback(object sender)
        {
            var state = sender as MailboxReaderThreadState;

            // if the timer is disabled the exit out
            lock (_locker) if (_timerIsDisabled) return;

            // are we currently processing the mailbox?
            // this is here to stop the mailbox processing when the callback is called again and we have not finished
            // processing the previous poll
            lock (_locker) if (_isMailboxReaderProcessing) return; 

            try
            {
                if (_timer == null)
                {
                    if (_readerErrors.Equals(0))
                    {
                        Log.Error("MailboxReaderModule: First instance of mailbox reader timer is null");
                    }

                    throw new Exception("MailboxReaderModule: Mailbox reader timer is null");
                }

                // set the flag we are processing
                lock (_locker) _isMailboxReaderProcessing = true;

                //stop the timer
                lock (_locker) _timer.Change(Timeout.Infinite, Timeout.Infinite);

                var assemblyUri = new Uri(Assembly.GetExecutingAssembly().CodeBase);
                var path = Path.GetDirectoryName(assemblyUri.LocalPath).Replace("\\bin", "");

                var hostSettings = HostSettingManager.LoadHostSettings();

                var emailFormat = HostSettingManager.Get(hostSettings, HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);
                var pop3TemplatePath = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3BodyTemplate, "templates/NewMailboxIssue.xslt");

                var mailBoxConfig = new MailboxReaderConfig
                {
                    Server = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Server, string.Empty),
                    Port = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Port, 110),
                    UseSsl = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3UseSSL, false),
                    Username = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Username, string.Empty),
                    Password = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Password, string.Empty),
                    ProcessInlineAttachedPictures = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3InlineAttachedPictures, false),
                    DeleteAllMessages = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3DeleteAllMessages, true),
                    ReportingUserName = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3ReportingUsername, string.Empty),
                    ProcessAttachments = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3ProcessAttachments, true),
                    UploadsFolderPath = (state == null) ? Path.Combine(HostSettingManager.Get(HostSettingNames.AttachmentUploadPath), path) : state.UploadsFolderPath,
                    AllowedFileExtensions = HostSettingManager.Get(hostSettings, HostSettingNames.AllowedFileExtensions, "."),
                    FileSizeLimit = HostSettingManager.Get(hostSettings, HostSettingNames.FileSizeLimit, 0),
                    EmailFormatType = emailFormat
                };

                if (File.Exists(Path.Combine(path, pop3TemplatePath)))
                {
                    mailBoxConfig.BodyTemplate = File.ReadAllText(Path.Combine(path, pop3TemplatePath));   
                }

                var mailboxReader = new MailboxReader.MailboxReader(mailBoxConfig);

                // read the mail for the mailboxes
                var result = mailboxReader.ReadMail();

                // handle the result of the read
                // we should never get an exception from the reader only statuses, this so we don't kill the background thread
                // unless it is absolute
                switch (result.Status)
                {
                    case ResultStatuses.None:
                    case ResultStatuses.Success:
                        lock (_locker) _readerErrors = 0;
                        break;
                    case ResultStatuses.Failed:
                        foreach (var processingMessage in result.ProcessingMessages)
                        {
                            Log.Warn(processingMessage);
                        }
                        break;
                    case ResultStatuses.FailedWithException:
                        Log.Error(result.LastException);
                        lock (_locker) _readerErrors++;
                        break;
                    default:
                        throw new ArgumentOutOfRangeException();
                }
            }
            catch(Exception ex)
            {
                Log.Error(ex);

                lock (_locker) 
                    _readerErrors++;
            }
            finally
            {
                // set the flag back so we are not processing
                _isMailboxReaderProcessing = false; 
            }

            lock (_locker)
            {
                if (_readerErrors < CNST_MAX_READER_ERRORS)
                {
                    if (_timer != null)
                    {
                        // start the timer up again
                        lock (_locker) _timer.Change(_interval, _interval);
                        return;   
                    }
                }                
            }

            Log.Error(string.Format("MailboxReaderModule: The Mailbox reader has thrown [{0}] consecutive errors and will be disabled", _readerErrors));

            _timerIsDisabled = true;

            if (_timer == null) return;
            _timerIsActive = false;
            _timer.Dispose();
        }

        #endregion
    }
}
