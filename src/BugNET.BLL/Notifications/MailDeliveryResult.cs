// -----------------------------------------------------------------------
// <copyright file="MailDeliveryResult.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL.Notifications
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// The result of sending a mail message
    /// </summary>
    public class MailDeliveryResult
    {
        public bool Success { get; set; }
        public Exception Exception { get; set; }
    }
}
