using System;
using System.Collections;
using System.Text;
using System.Xml.Serialization;


namespace BugNET.Entities
{
	/// <summary>
	/// Summary description for Entry.
	/// </summary>
	public class MailboxEntry
	{
        /// <summary>
        /// Initializes a new instance of the <see cref="MailboxEntry"/> class.
        /// </summary>
		public MailboxEntry()
		{}

        /// <summary>
        /// 
        /// </summary>
        public string Content { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public DateTime Date { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string From { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public ProjectMailbox ProjectMailbox { get; set; }

        public Project Project { get; set; }

        /// <summary>
        /// The issue id generated from the saving of the mailbox entry
        /// </summary>
        public int IssueId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [XmlIgnore]
        public ArrayList MailAttachments = new ArrayList();

        /// <summary>
        /// The number of attachments that were processed and saved
        /// </summary>
        public int AttachmentsSavedCount { get; set; }

        /// <summary>
        /// Flag to indicate if the mailbox item was processed properly (parsed, saved)
        /// </summary>
        public bool WasProcessed { get; set; }

        /// <summary>
        /// Any messages from the process to parse and save the entry
        /// </summary>
        public string ProcessingMessage { get; set; }

        /// <summary>
        /// Flag to indicate if the content is HTML or not
        /// </summary>
        public bool IsHtml { get; set; }
    }
}
