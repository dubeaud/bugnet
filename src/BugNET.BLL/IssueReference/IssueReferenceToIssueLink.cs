using System;
using System.Web;

namespace BugNET.BLL
{
    /// <summary>
    /// This class is responsible for converting a single ReferenceIssue to an IssueReferenceLink
    /// </summary>
    public class IssueReferenceToIssueLink
    {
        private readonly IPathProvider pathProvider;
        private const string IssueDetailUrl = "~/Issues/IssueDetail.aspx?id=";
        private const string LinkFormat = "<a href=\"{0}\" target=\"_blank\">{1}</a>";

        public IssueReferenceToIssueLink(IPathProvider pathProvider)
        {
            this.pathProvider = pathProvider;
        }

        public IssueReferenceLink Convert(IssueReference referenceIssue)
        {
            if (referenceIssue == null)
            {
                throw new ArgumentNullException("referenceIssue", "Cannot convert a project issue number that is null");
            }

            string url = pathProvider.GetAbsolutePath(IssueDetailUrl + referenceIssue.IssueId);
            string replacement = string.Format(LinkFormat, HttpUtility.HtmlAttributeEncode(url), HttpUtility.HtmlEncode(referenceIssue.Token));

            var issueReferenceLink = new IssueReferenceLink
            {
                Link = replacement, 
                Token = referenceIssue.Token
            };

            return issueReferenceLink;
        }
    }
}