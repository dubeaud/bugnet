using System;
using System.Collections.Generic;

using BugNET.BLL;

using NUnit.Framework;

namespace BugNET.Tests
{
    [TestFixture]
    public class IssueReferenceParserTest
    {
        [Test]
        public void Parse_EmptyString_ReturnsEmptyList()
        {
            var IssueReferenceParser = new IssueReferenceParser();
            List<IssueReference> result = IssueReferenceParser.Parse("aa", string.Empty);
            Assert.That(result.Count, Is.EqualTo(0));
        }

        [Test]
        public void Parse_StringWithoutIssueReference_ReturnsEmptyList()
        {
            var IssueReferenceParser = new IssueReferenceParser();
            List<IssueReference> result = IssueReferenceParser.Parse("aa", "Description without issue number.");
            Assert.That(result.Count, Is.EqualTo(0));
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void Parse_EmptyProjectCode_ThrowsArgumentException()
        {
            var IssueReferenceParser = new IssueReferenceParser();
            IssueReferenceParser.Parse(string.Empty, "Description without issue number.");
        }

        [Test]
        public void Parse_StringWithSingleIssueReference_ReturnsListWithOne()
        {
            var IssueReferenceParser = new IssueReferenceParser();
            List<IssueReference> result = IssueReferenceParser.Parse("PR5431","PR5431-54");
            Assert.That(result.Count, Is.EqualTo(1));
            Assert.That(result[0].ProjectCode, Is.EqualTo("PR5431"));
            Assert.That(result[0].IssueId, Is.EqualTo("54"));
            Assert.That(result[0].Token, Is.EqualTo("PR5431-54"));
        }

        [Test]
        public void Parse_StringWithTwoIssueReferences_ReturnsListWithTwo()
        {
            var IssueReferenceParser = new IssueReferenceParser();
            List<IssueReference> result = IssueReferenceParser.Parse("PR5431", "This links PR5431-54 and PR5431-12 together");
            Assert.That(result.Count, Is.EqualTo(2));

            Assert.That(result[0].ProjectCode, Is.EqualTo("PR5431"));
            Assert.That(result[0].IssueId, Is.EqualTo("54"));
            Assert.That(result[0].Token, Is.EqualTo("PR5431-54"));

            Assert.That(result[1].ProjectCode, Is.EqualTo("PR5431"));
            Assert.That(result[1].IssueId, Is.EqualTo("12"));
            Assert.That(result[1].Token, Is.EqualTo("PR5431-12"));
        }
    }
}
