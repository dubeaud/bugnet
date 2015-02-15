using System.Reflection;
using LumiSoft.Net.Mail;
using NUnit.Framework;

namespace BugNET.MailboxReader.Tests
{
    [Category("Mailbox Reader")]
    [TestFixture]
    public class MailboxReaderTests
    {

        public void CanReturnBugNetMailboxReaderSettings()
        {
            var config = Helpers.GetBugNetConfig();

            Assert.AreNotSame(string.Empty, config.Password);
        }

        /// <summary>
        /// Test runner.
        /// </summary>
        /// <remarks>
        /// This is just a stub for running the complete mailbox execution to aid in debugging, it is by no means a proper integration test.  It is used
        /// mostly to interrogate the populated entities returned from the mailbox fetch in the debugger.
        /// 
        /// Don't hate me, I know you have done this kind of thing before too... ;)
        /// </remarks>
        public void Runner()
        {
            // create the instance
            var mailboxReader = new MailboxReader(Helpers.GetBugNetConfig());

            // read the mail for the mailboxes
            var result = mailboxReader.ReadMail();
        }

        [Test]
        public void html_email_with_image_attachment_has_one_image_attachment()
        {

            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.html_email_with_image_attachment.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "html email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("image", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "image");
        }

        [Test]
        public void html_email_with_bad_header_has_one_image_attachment()
        {
            // with the bad header for some reason this email inline attachments are missing GetAttachments process via the body boundaries
            // rather than the layout of the boundaries in the email.
            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.html_email_with_bad_header.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "html email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("image", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "image");
        }

        [Test]
        public void html_email_with_body_image_has_one_image_attachment()
        {
            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.html_email_with_body_image.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "html email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("image", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "image");
        }

        [Test]
        public void html_email_with_message_attachment_has_one_message_attachment()
        {

            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.html_email_with_message_attachment.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "html email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("message", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "message");
        }

        [Test]
        public void rtf_email_with_image_attachment_has_one_attachment()
        {

            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.rtf_email_with_image_attachment.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "rtf email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("image", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "image");
        }

        [Test]
        public void rtf_email_with_message_attachment_has_one_message_attachment()
        {
            var result = Mail_Message.ParseFromStream(Assembly.GetExecutingAssembly().GetManifestResourceStream("BugNET.MailboxReader.Tests.rtf_email_with_message_attachment.txt"));
            var attachments = result.GetAttachments(true);

            Assert.AreEqual(1, attachments.Length, "rtf email had {0} attachments we expected {1}", attachments.Length, 1);

            var mimeEntity = attachments[0].Body.Entity;
            Assert.AreEqual("message", mimeEntity.ContentType.Type, "email has attachment type {0} we expected {1}", mimeEntity.ContentType.Type, "message");
        }

        [Test]
        public void TestStub()
        {

        }
    }
}