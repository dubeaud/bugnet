// -----------------------------------------------------------------------
// <copyright file="SmtpMailDeliveryService.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL.Notifications
{
    using System;
    using System.Net.Mail;
    using System.Net;
    using BugNET.Common;

    public class SmtpMailDeliveryService : IMailDeliveryService
    {
        /// <summary>
        /// Sends the specified recipient email.
        /// </summary>
        /// <param name="recipientEmail">The recipient email.</param>
        /// <param name="message">The message.</param>
        /// <returns></returns>
        public MailDeliveryResult Send(string recipientEmail, MailMessage message)
        {
            message.To.Clear();
            message.To.Add(recipientEmail);
            message.From =  new MailAddress(HostSettingManager.HostEmailAddress);

            var smtpServer = HostSettingManager.SmtpServer;
            var smtpPort = int.Parse(HostSettingManager.Get(HostSettingNames.SMTPPort));
            var smtpAuthentictation = Convert.ToBoolean(HostSettingManager.Get(HostSettingNames.SMTPAuthentication));
            var smtpUseSSL = Boolean.Parse(HostSettingManager.Get(HostSettingNames.SMTPUseSSL));

            // Only fetch the password if you need it
            var smtpUsername = string.Empty;
            var smtpPassword = string.Empty;
            var smtpDomain = string.Empty;

            if (smtpAuthentictation)
            {
                smtpUsername = HostSettingManager.Get(HostSettingNames.SMTPUsername, string.Empty);
                smtpPassword = HostSettingManager.Get(HostSettingNames.SMTPPassword, string.Empty);
                smtpDomain = HostSettingManager.Get(HostSettingNames.SMTPDomain, string.Empty);
            }

            using (var client = new SmtpClient())
            {
                client.Host = smtpServer;
                client.Port = smtpPort;
                client.EnableSsl = smtpUseSSL;

                if (smtpAuthentictation)
                {
                    client.Credentials = new NetworkCredential(smtpUsername, smtpPassword, smtpDomain);
                }

                try
                {
                    client.Send(message);
                    return new MailDeliveryResult()
                    {
                        Success = true
                    };
                }
                catch (Exception ex)
                {
                    return new MailDeliveryResult()
                    {
                        Success = false,
                        Exception = ex
                    };
                }
            }


        }
    }
}
