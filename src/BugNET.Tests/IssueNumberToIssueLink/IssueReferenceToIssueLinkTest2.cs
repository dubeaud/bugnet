using System;

using BugNET.BLL;

using NUnit.Framework;

namespace BugNET.Tests
{
    [TestFixture]
    public class IssueReferenceToIssueLinkTest
    {
        [Test]
        public void Convert_ValidProjectIssueNumber_ReturnsValidLink()
        {
            var projectIssueNumber = new IssueReference
            {
                IssueId = "25",
                ProjectCode = "ABC55",
                Token = "ABC55-25"
            };

            var issueNumberToIssueLink = new IssueReferenceToIssueLink(new MockPathProvider("http://localhost"));
            IssueReferenceLink result = issueNumberToIssueLink.Convert(projectIssueNumber);
            Assert.That(result.Link, Is.EqualTo("<a href=\"http://localhost/Issues/IssueDetail.aspx?id=25\" target=\"_blank\">ABC55-25</a>"));
        }

        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void Convert_InvalidProjectNumber_ThrowsArgumentException()
        {
            var issueNumberToIssueLink = new IssueReferenceToIssueLink(new MockPathProvider("http://localhost"));
            issueNumberToIssueLink.Convert(null);
        }

    }
}
