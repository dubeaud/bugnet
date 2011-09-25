using System;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;

namespace BugNET.UnitTests
{


    /// <summary>
    /// Attachment Unit Tests
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class IssueAttachmentTests
    {
        protected IssueAttachment testAttachment;
        protected int Id;
        protected string Description;
        protected int Size;
        protected int IssueId;
        protected string UploadedUserName;
        protected string ContentType;
        protected string FileName;
        protected string UploadedUserDisplayName;
        protected DateTime UploadedDate;

        /// <summary>
        /// Setup Values
        /// </summary>
        [SetUp]
        public void Init()
        {
            Id = 1;
            Description = "This is a test description for the file attachment";
            Size = 1024;
            IssueId = 1;
            UploadedUserName = "dubeaud";
            ContentType = "text/xml";
            FileName = "TestFile.xml";
            UploadedUserDisplayName = "Davin Dubeau";
            UploadedDate = DateTime.Parse("01-Jan-2005");
        }


        /// <summary>
        /// Creations this instance.
        /// </summary>
        [Test]
        public void TestCreation()
        {
            //testAttachment = new IssueAttachment(Id, IssueId, FileName, Description, Size, ContentType, UploadedUserName, UploadedDate);

            //Assert.AreEqual(Id, testAttachment.Id);
            //Assert.AreEqual(IssueId, testAttachment.IssueId);
            //Assert.AreEqual(FileName, testAttachment.FileName);
            //Assert.AreEqual(1024, testAttachment.Size);
            //Assert.AreEqual(Description, testAttachment.Description);
            //Assert.AreEqual(ContentType, testAttachment.ContentType);
            //Assert.AreEqual(UploadedUserName, testAttachment.UploadedUserName);
            //Assert.AreEqual(UploadedDate, testAttachment.UploadedDate);
        }

        /// <summary>
        /// Creation1s this instance.
        /// </summary>
        [Test]
        public void TestCreation1()
        {
            //testAttachment = new IssueAttachment(IssueId, FileName, Description, Size, ContentType, UploadedUserName);
            //Assert.AreEqual(0, testAttachment.Id);
            //Assert.AreEqual(IssueId, testAttachment.IssueId);
            //Assert.AreEqual(FileName, testAttachment.FileName);
            //Assert.AreEqual(1024, testAttachment.Size);
            //Assert.AreEqual(Description, testAttachment.Description);
            //Assert.AreEqual(ContentType, testAttachment.ContentType);
            //Assert.AreEqual(UploadedUserName, testAttachment.UploadedUserName);
            //Assert.AreEqual(DateTime.Now, testAttachment.UploadedDate);
        }  

    }
}
