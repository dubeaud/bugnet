using BugNET.BLL;

using NUnit.Framework;

namespace BugNET.Tests
{
    [TestFixture]
    public class IssueNumberToIssueLinkConverterTest
    {
        [Test]
        public void Convert_EmptyDescription_ReturnsEmptyDescription()
        {
            var issueNumberToLinkConverter = CreateIssueNumberToLinkConverter(issueIsValid:true);
            string result = issueNumberToLinkConverter.Convert("aa", string.Empty);
            Assert.That(result, Is.EqualTo(string.Empty));
        }

        [Test]
        public void Convert_DescriptionWithoutIssueNumbers_ReturnsDescription()
        {
            var issueNumberToLinkConverter = CreateIssueNumberToLinkConverter(issueIsValid: true);
            const string IssueDescription = "This is a very serious bug.";
            string result = issueNumberToLinkConverter.Convert("aa", IssueDescription);
            Assert.That(result, Is.EqualTo(IssueDescription));
        }

        [Test]
        public void Convert_DescriptionWithIssueNumber_ReturnsDescriptionWithLinkToIssueNumber()
        {
            var issueNumberToLinkConverter = CreateIssueNumberToLinkConverter(issueIsValid: true);
            const string IssueDescription = "This is a very serious bug just like BU123-23.";
            string result = issueNumberToLinkConverter.Convert("BU123", IssueDescription);
            string expectedResult = IssueDescription.Replace("BU123-23", "<a href=\"http://localhost/Issues/IssueDetail.aspx?id=23\" target=\"_blank\">BU123-23</a>");
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Convert_DescriptionWithIssueNumberThatIsNotValid_ReturnsTheSameDescription()
        {
            var issueNumberToLinkConverter = CreateIssueNumberToLinkConverter(issueIsValid: false);
            const string IssueDescription = "This is a very serious bug just like BU123-23.";
            string result = issueNumberToLinkConverter.Convert("BU123", IssueDescription);
            Assert.That(result, Is.EqualTo(IssueDescription));
        }

        private static IssueReferenceToLinkConverter CreateIssueNumberToLinkConverter(bool issueIsValid)
        {
            return new IssueReferenceToLinkConverter(
                new IssueReferenceParser(), 
                new IssueReferenceToIssueLink(new MockPathProvider("http://localhost")),
                new IssueReferenceReplacer(),
                new IssueReferenceValidatorMock() {ReturnValidIssue = issueIsValid});
        }
    }
}
