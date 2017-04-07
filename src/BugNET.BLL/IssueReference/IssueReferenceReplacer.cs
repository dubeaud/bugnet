using System.Collections.Generic;
using System.Text;

namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for replacing issue references in the description of an issue with 
    /// links to that issue.
    /// </summary>
    public class IssueReferenceReplacer
    {
        public string Replace(string description, List<IssueReferenceLink> issueReferenceLinks)
        {
            var result = new StringBuilder(description);
            foreach (IssueReferenceLink issueReferenceLink in issueReferenceLinks)
            {
                result.Replace(issueReferenceLink.Token, issueReferenceLink.Link);
            }
            return result.ToString();
        }
    }
}