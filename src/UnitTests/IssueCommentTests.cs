using System;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;

namespace BugNET.UnitTests
{
    /// <summary>
    /// Test Fixture for Comment
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class IssueCommentTests
    {
        private IssueComment TestComment;
        private int Id;
        private int IssueId;
        private string Comment;
        private string CreatorUserName;
        private string CreatorDisplayName;
        private Guid CreatorUserId;
        private DateTime DateAdded;
        private string CreatorEmail;

        /// <summary>
        /// Setup Values
        /// </summary>
        [SetUp]
        public void Init()
        {
            Id = 5;
            IssueId = 200;
            Comment = "This is a new comment for testing";
            CreatorUserName = "dubeaud";
            CreatorDisplayName = "Davin Dubeau";
            CreatorUserId = new Guid("BF68338E-1EE5-49a3-BC63-8F7A7D3AFA5B");
            DateAdded = DateTime.Parse("01-Jan-2005");
            CreatorEmail = "info@tekhorror.com";
        }

        /// <summary>
        /// Tests the creation.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            TestComment = new IssueComment(Id, IssueId, Comment, CreatorUserName, CreatorUserId,CreatorDisplayName, DateAdded);

            Assert.AreEqual(Id, TestComment.Id);
            Assert.AreEqual(IssueId, TestComment.IssueId);
            Assert.AreEqual(Comment, TestComment.Comment);
            Assert.AreEqual(CreatorUserId, TestComment.CreatorUserId);
            Assert.AreEqual(CreatorUserName, TestComment.CreatorUserName);
            Assert.AreEqual(CreatorDisplayName, TestComment.CreatorDisplayName);
            //Assert.AreEqual(CreatorEmail, TestComment.CreatorEmail);
            Assert.AreEqual(DateAdded, TestComment.DateCreated);


        }
        /// <summary>
        /// Tests the creation1.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            TestComment = new IssueComment(IssueId, Comment, CreatorUserName);

            Assert.AreEqual(IssueId, TestComment.IssueId);
            Assert.AreEqual(Comment, TestComment.Comment);
            Assert.AreEqual(CreatorUserName, TestComment.CreatorUserName);

            //Test Empty Values
            Assert.AreEqual(0, TestComment.Id);
            Assert.AreEqual(Guid.Empty, TestComment.CreatorUserId);
            Assert.IsNotNull(TestComment.DateCreated);

        }
    }
}
