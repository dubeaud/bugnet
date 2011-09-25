using System;
using System.Collections;
using System.Text;
using BugNET.Entities;


namespace BugNET.BusinessLogicLayer.POP3Reader
{
	/// <summary>
	/// Summary description for Entry.
	/// </summary>
	public class MailboxEntry
	{
        /// <summary>
        /// Initializes a new instance of the <see cref="Entry"/> class.
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
