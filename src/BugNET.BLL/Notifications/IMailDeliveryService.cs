// -----------------------------------------------------------------------
// <copyright file="IMailDeliveryService.cs" company="BugNET">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL.Notifications
{
    using System.Net.Mail;

    public interface IMailDeliveryService
    {
        MailDeliveryResult Send(string recipientEmail, MailMessage message);
    }
}
