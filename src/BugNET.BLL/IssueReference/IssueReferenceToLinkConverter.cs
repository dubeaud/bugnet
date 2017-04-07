using System.Collections.Generic;

namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for converting all the issue reference that are found in a 
    /// given description of an issue into links to the specified issues.
    /// </summary>
    public class IssueReferenceToLinkConverter
    {
        private readonly IssueReferenceParser issueReferenceParser;
        private readonly IssueReferenceToIssueLink issueReferenceToIssueLink;
        private readonly IssueReferenceReplacer issueReferenceReplacer;
        private readonly IssueReferenceValidator issueReferenceValidator;

        public IssueReferenceToLinkConverter(IssueReferenceParser issueReferenceParser,
            IssueReferenceToIssueLink issueReferenceToIssueLink, 
            IssueReferenceReplacer issueReferenceReplacer,
            IssueReferenceValidator issueReferenceValidator)
        {
            this.issueReferenceParser = issueReferenceParser;
            this.issueReferenceToIssueLink = issueReferenceToIssueLink;
            this.issueReferenceReplacer = issueReferenceReplacer;
            this.issueReferenceValidator = issueReferenceValidator;
        }

        public string Convert(string projectcode, string description)
        {
            List<IssueReference> projectIssueNumbers = issueReferenceParser.Parse(projectcode, description);
            var projectIssueNumberLinks = new List<IssueReferenceLink>();
            foreach (IssueReference issueReference in projectIssueNumbers)
            {
                if (issueReferenceValidator.IsValidIssue(int.Parse(issueReference.IssueId)))
                {
                    IssueReferenceLink issueReferenceLink = issueReferenceToIssueLink.Convert(issueReference);
                    projectIssueNumberLinks.Add(issueReferenceLink);
                }
            }
            return issueReferenceReplacer.Replace(description, projectIssueNumberLinks);
        }
    }
}