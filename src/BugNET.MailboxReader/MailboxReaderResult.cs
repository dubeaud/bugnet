using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.MailboxReader
{
    public class MailboxReaderResult
    {
        public MailboxReaderResult()
        {
            MailboxEntries = new List<MailboxEntry>();
            ProcessingMessages = new List<string>();
        }

        public MailboxReaderResult(ResultStatuses status) : base()
        {
            Status = status;
        }

        public ResultStatuses Status { get; set; }
        public Exception LastException { get; set; }
        public IList<MailboxEntry> MailboxEntries { get; set; }
        public IList<string> ProcessingMessages { get; set; }
    }
}