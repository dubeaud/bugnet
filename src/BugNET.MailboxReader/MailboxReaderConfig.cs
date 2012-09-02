using BugNET.Common;
using log4net;

namespace BugNET.MailboxReader
{
    public class MailboxReaderConfig : IMailboxReaderConfig, ISmtpConfig
    {
        public string BodyTemplate { get; set; }
        public bool DeleteAllMessages { get; set; }
        public string Password { get; set; }
        public int Port { get; set; }
        public bool ProcessAttachments { get; set; }
        public string ReportingUserName { get; set; }
        public string Server { get; set; }
        public bool UseSsl { get; set; }
        public string Username { get; set; }
        public bool ProcessInlineAttachedPictures { get; set; }
        public string UploadsFolderPath { get; set; }
        public EmailFormatType EmailFormatType { get; set; }
        public string AllowedFileExtensions { get; set; }
        public long FileSizeLimit { get; set; }
    }
}