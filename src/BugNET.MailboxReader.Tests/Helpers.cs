using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using BugNET.BLL;
using BugNET.Common;
using EmailFormatType = BugNET.Common.EmailFormatType;
using HostSettingNames = BugNET.Common.HostSettingNames;

namespace BugNET.MailboxReader.Tests
{
    public static class Helpers
    {
        public static string GetEmailTemplateContent()
        {
            var template = string.Empty;

            using (var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.NewMailboxIssue.xslt")) 
            {
                if (stream != null)
                {
                    using (var reader = new StreamReader(stream)) 
                    {
                        template = reader.ReadToEnd(); 
                    }
                }
            }

            return template;
        }

        public static MailboxReaderConfig GetBugNetConfig()
        {
            var state = new MailboxReaderThreadState
            {
                UploadsFolderPath = @"c:\temp\",
            };

            var hostSettings = HostSettingManager.LoadHostSettings();

            var emailFormat = HostSettingManager.Get(hostSettings, HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            var mailBoxConfig = new MailboxReaderConfig
            {
                Server = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Server, string.Empty),
                Port = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Port, 110),
                UseSsl = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3UseSSL, false),
                Username = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Username, string.Empty),
                Password = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3Password, string.Empty),
                ProcessInlineAttachedPictures = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3InlineAttachedPictures, false),
                DeleteAllMessages = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3DeleteAllMessages, false),
                ReportingUserName = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3ReportingUsername, string.Empty),
                ProcessAttachments = HostSettingManager.Get(hostSettings, HostSettingNames.Pop3ProcessAttachments, true),
                UploadsFolderPath = state.UploadsFolderPath,
                EmailFormatType = emailFormat,
                BodyTemplate = GetEmailTemplateContent()
            };

            return mailBoxConfig;
        }
    }
}
