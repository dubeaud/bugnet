using BugNET.Common;
using NUnit.Framework;

namespace BugNET.Tests
{
    [Category("Utility")]
    [TestFixture]
    public class UtilityTests
    {

        [Test]
        public void ParseIssueIdFromValidBugNetIssueIdString()
        {
            const string input = "XXX-123";
            var output = Utilities.ParseFullIssueId(input);
            Assert.IsTrue(output.Equals(123));
        }

        [Test]
        public void ParseIssueIdFromValidIssueIdString()
        {
            const string input = "123";
            var output = Utilities.ParseFullIssueId(input);
            Assert.IsTrue(output.Equals(123));
        }

        [Test]
        public void ParseIssueIdFromBugNetIssueIdStringWithMultipleDashes()
        {
            const string input = "XXX-YYY-123"; // test when project code as a dash in it
            var output = Utilities.ParseFullIssueId(input);
            Assert.IsTrue(output.Equals(123));
        }

        [Test]
        public void WillReturnBadIssueIdFromInValidIssueIdString()
        {
            const string input = "123XX";
            var output = Utilities.ParseFullIssueId(input);
            Assert.IsTrue(output.Equals(-1));
        }

        [Test]
        public void WillReturnBadIssueIdFromInValidBugNetIssueIdString()
        {
            const string input = "YYY-123XX";
            var output = Utilities.ParseFullIssueId(input);
            Assert.IsTrue(output.Equals(-1));
        }
    }
}
