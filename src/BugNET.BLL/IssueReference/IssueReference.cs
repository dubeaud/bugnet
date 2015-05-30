namespace BugNET.BLL
{
    /// <summary>
    /// This class represents a parsed reference to an issue
    /// </summary>
    public class IssueReference
    {
        public string ProjectCode { get; set; }

        public string IssueId { get; set; }

        public string Token { get; set; }
    }
}