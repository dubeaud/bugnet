using System;
using System.Reflection;
using BugNET.BLL;
using BugNET.Common;
using Quartz;
using log4net;

namespace BugNET.MailboxReader
{
    public class MailBoxReaderJob : IJob
    {
        private static readonly ILog Log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region IJob Members

        public void Execute(IJobExecutionContext context)
        {
            Log.Info("QUARTZ: Scheduled Job started");

            var mailBoxArgs = new MailBoxReaderArgs
            {
                Server = HostSettingManager.Get(HostSettingNames.Pop3Server),
                Port = Convert.ToInt32(HostSettingManager.Get(HostSettingNames.Pop3Port)),
                UseSSL = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3UseSSL)),
                Username = HostSettingManager.Get(HostSettingNames.Pop3Username),
                Password = HostSettingManager.Get(HostSettingNames.Pop3Password),
                ProcessInlineAttachedPictures = Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3InlineAttachedPictures)),
                BodyTemplate = HostSettingManager.Get(HostSettingNames.Pop3BodyTemplate),
                DeleteAllMessages = Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3DeleteAllMessages)),
                ReportingUserName = HostSettingManager.Get(HostSettingNames.Pop3ReportingUsername),
                ProcessAttachments = Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.Pop3ProcessAttachments))
            };

            var mailboxReader = new MailboxReader(mailBoxArgs);
            mailboxReader.ReadMail();
        }

        #endregion
    }
}