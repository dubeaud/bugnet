using System;
using System.Collections;
using System.Text;


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
		public StringBuilder Content = new StringBuilder();
        /// <summary>
        /// 
        /// </summary>
		public DateTime Date;
        /// <summary>
        /// 
        /// </summary>
		public string Title;
        /// <summary>
        /// 
        /// </summary>
		public string From;
        /// <summary>
        /// 
        /// </summary>
		public ProjectMailbox ProjectMailbox;
        /// <summary>
        /// 
        /// </summary>
        public ArrayList MailAttachments = new ArrayList();
    }
}
