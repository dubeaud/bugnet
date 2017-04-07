using BugNET.BLL;

namespace BugNET.Tests
{
    /// <summary>
    /// This class is responsible for mocking the issue reference validator so that
    /// it is possible to test the dependencies of this class without a connection 
    /// to the database. The real validator uses the IssueManager to validate an issue.
    /// </summary>
    public class IssueReferenceValidatorMock : IssueReferenceValidator
    {
        public bool ReturnValidIssue { get; set; }

        public override bool IsValidIssue(int issueId)
        {
            return ReturnValidIssue;
        }
    }
}
