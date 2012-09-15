namespace BugNET.MailboxReader
{
    public interface ISmtpConfig
    {
        string Server { get; set; }
        bool UseSsl { get; set; }
        string Username { get; set; }
        string Password { get; set; }
        int Port { get; set; }
    }
}