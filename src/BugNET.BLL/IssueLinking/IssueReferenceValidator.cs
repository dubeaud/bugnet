namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for validating an issue reference which means checking if
    /// a given issue actually exists in the system.
    /// </summary>
    public class IssueReferenceValidator
    {
        public virtual bool IsValidIssue(int issueId)
        {
            return IssueManager.GetById(issueId) != null;
        }
    }
}
