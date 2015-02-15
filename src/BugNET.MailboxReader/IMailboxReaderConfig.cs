namespace BugNET.MailboxReader
{
    public interface IMailboxReaderConfig
    {
        string BodyTemplate { get; set; }
        bool DeleteAllMessages { get; set; }
        bool ProcessAttachments { get; set; }
        string ReportingUserName { get; set; }
        bool ProcessInlineAttachedPictures { get; set; }
    }
}