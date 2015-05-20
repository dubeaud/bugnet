using System.Collections.Generic;
using System.Text.RegularExpressions;

using BugNET.BLL;

using NUnit.Framework;

namespace BugNET.Tests
{
    [TestFixture]
    public class IssueReferenceReplacerTest
    {
        [Test]
        public void Convert_DescriptionWithTwoValidIssueReferences_ReturnsDescriptionWithLinksToThoseTwoIssueReferences()
        {
            var projectIssueNumberLinks = new List<IssueReferenceLink>();
            const string HSD251Link = "<A href=\"http://localhost/issues/issuedetail.aspx?id=251\">HSD-251</A>"; 
            projectIssueNumberLinks.Add(new IssueReferenceLink { Link = HSD251Link, Token = "HSD-251"});
            const string HSD121Link = "<A href=\"http://localhost/issues/issuedetail.aspx?id=121\">HSD-121</A>";
            projectIssueNumberLinks.Add(new IssueReferenceLink { Link = HSD121Link, Token = "HSD-121"});
            
            var issueNumberReplacer = new IssueReferenceReplacer();
            string result = issueNumberReplacer.Replace(
                "This is the description of an issue that references HSD-251 and also should include a link to HSD-121", projectIssueNumberLinks);

            Assert.That(result.Contains(HSD251Link));
            Assert.That(result.Contains(HSD121Link));
        }

        [Test]
        public void Convert_DescriptionWithTwoSameIssueReferences_ReturnsDescriptionWithLinksToTwoSameIssueReferences()
        {
            var projectIssueNumberLinks = new List<IssueReferenceLink>();
            const string HSD251Link = "<A href=\"http://localhost/issues/issuedetail.aspx?id=251\">HSD-251</A>";
            projectIssueNumberLinks.Add(new IssueReferenceLink { Link = HSD251Link, Token = "HSD-251" });

            var issueNumberReplacer = new IssueReferenceReplacer();
            string result = issueNumberReplacer.Replace(
                "This is the description of an issue that references HSD-251 and also should include another link to HSD-251", projectIssueNumberLinks);

            int numberOfLinks = new Regex(Regex.Escape(HSD251Link)).Matches(result).Count;
            Assert.That(numberOfLinks, Is.EqualTo(2));
        }
    }
}