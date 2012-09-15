using System.Text;

namespace BugNET.MailboxReader
{
    public class MailBoxReaderArgs
    {
        public string Server { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public bool ProcessInlineAttachedPictures { get; set; }
        public bool DeleteAllMessages { get; set; }
        public string ReportingUserName { get; set; }
        public string BodyTemplate { get; set; }
        public int Port { get; set; }
        public bool UseSSL { get; set; }
        public bool ProcessAttachments { get; set; }

        public override string ToString()
        {
            var sb = new StringBuilder();

            sb.AppendFormat("MailBoxReader Config{0}", System.Environment.NewLine);
            sb.AppendFormat("Server: {0} {1}", Server, System.Environment.NewLine);
            sb.AppendFormat("Port: {0} {1}", Port, System.Environment.NewLine);
            sb.AppendFormat("UseSSL {0} {1}", UseSSL, System.Environment.NewLine);
            sb.AppendFormat("Username {0} {1}", Username, System.Environment.NewLine);
            sb.AppendFormat("Password {0} {1}", Password, System.Environment.NewLine);
            sb.AppendFormat("ProcessAttachments {0} {1}", ProcessAttachments, System.Environment.NewLine);
            sb.AppendFormat("ProcessInlineAttachedPictures {0} {1}", ProcessInlineAttachedPictures, System.Environment.NewLine);
            sb.AppendFormat("DeleteAllMessages {0} {1}", DeleteAllMessages, System.Environment.NewLine);
            sb.AppendFormat("ReportingUserName {0} {1}", ReportingUserName, System.Environment.NewLine);

            return sb.ToString();
        }
    }
}