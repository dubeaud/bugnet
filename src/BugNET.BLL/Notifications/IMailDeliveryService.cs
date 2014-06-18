// -----------------------------------------------------------------------
// <copyright file="IMailDeliveryService.cs" company="BugNET">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL.Notifications
{
    using System.Net.Mail;
    using System.Threading.Tasks;

    public interface IMailDeliveryService
    {
        Task Send(string recipientEmail, MailMessage message);
    }
}
