using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
using BugNET.BusinessLogicLayer.POP3Reader;

namespace BugNET.UnitTests
{
    [Category("Business Logic Layer")]
    [TestFixture]
    public class MailBoxReaderTest
    {
        private int _Id;
        private int _Port;
        private bool _UseSSL;
        private string _Server;
        private string _Username;
        private string _Password;
        private string _BodyTemplate;
        private string _ReportingUserName;
        private bool _InlineAttachedPictures;
        private bool _DeleteAllMessages;        
        private MailboxEntry _entry;
        private bool _ProcessAttachments;

        /// <summary>
        /// Inits this instance.
        /// </summary>
        [SetUp]
        public void Init()
        {
            _Id = 1;
            //_Port = 995;
            _Port = 110;
            _UseSSL = false;
            _Server = "mail.bugnetproject.com";
            _Username = "poptest@bugnetproject.com";
            _Password = "poptest1";
            _BodyTemplate = "{0} {1} {2}";
            _InlineAttachedPictures  = false;
            _ReportingUserName = "Admin";
            _DeleteAllMessages= false;
            _ProcessAttachments = false;

            _entry = new MailboxEntry();
            //_entry.AttachmentFileNames.Clear();
            
            List<Project> p = Project.GetAllProjects();
            List<IssueType> issT = IssueType.GetIssueTypesByProjectId(p[0].Id);

            // _entry.ProjectMailbox = new ProjectMailbox("testmailbox@testserver.com", p[0].Id, "Admin", "", issT[0].Id);
        }

        [Test]
        public void TestCreation()
        {
            MailboxReader2 mbr = new MailboxReader2(_Server, _Port, _UseSSL, _Username, _Password, _InlineAttachedPictures, _BodyTemplate, _DeleteAllMessages, _ReportingUserName, _ProcessAttachments);
            mbr.ReadMail();
            Assert.IsNotNull(mbr);
            // not else to really test            
        }

        //private MailboxReader CreateMailBoxReader()
        //{
        //    return new MailboxReader(_server,_username, _password, _inlineAttachedPictures
        //        ,_bodyTemplate , _deleteAllMessages, _reportingUserName);
        //}

        /// <summary>
        /// Tests the creation.
        /// </summary>
        //[Test]
        //public void TestCreation()
        //{
        //    MailboxReader mbr = CreateMailBoxReader();
        //    Assert.IsNotNull(mbr);
        //    // not else to really test            
        //}

        /// <summary>
        /// Tests if an issue is added.
        /// </summary>
        //[Test]
        //public void TestSaveEntryNoAttachments()
        //{
        //    MailboxReader mbr = CreateMailBoxReader();
        //    Assert.IsNotNull(mbr);
        //    _entry.MailAttachments.Clear();
        //    _entry.AttachmentFileNames.Clear();

        //    mbr.SaveEntry(_entry);          
        //}


    }
}
