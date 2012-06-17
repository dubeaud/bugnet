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
    using System.Threading;
    using System.ComponentModel;
    using log4net;

    public class SmtpMailDeliveryService : IMailDeliveryService
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(SmtpMailDeliveryService));

        /// <summary>
        /// Sends the specified recipient email.
        /// </summary>
        /// <param name="recipientEmail">The recipient email.</param>
        /// <param name="message">The message.</param>
        /// <returns></returns>
        public void Send(string recipientEmail, MailMessage message)
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

            var client = new SmtpClient();               
            client.Host = smtpServer;
            client.Port = smtpPort;
            client.EnableSsl = smtpUseSSL;

            if (smtpAuthentictation)
            {
                client.Credentials = new NetworkCredential(smtpUsername, smtpPassword, smtpDomain);
            }

            // Set the method that is called back when the send operation ends.
            client.SendCompleted += new SendCompletedEventHandler(SendCompletedCallback);
            client.SendAsync(message, null);
        }

        /// <summary>
        /// Sends the completed callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.ComponentModel.AsyncCompletedEventArgs"/> instance containing the event data.</param>
        private static void SendCompletedCallback(object sender, AsyncCompletedEventArgs e)
        {
            if (e.Cancelled)
            {
                return;
            }

            if (e.Error != null)
            {
                // log the error message
                Log.Error(e.Error);
            }
        }
    }
}
