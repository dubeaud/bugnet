using System;
using System.Drawing;
using System.Net;
using System.Net.Mail;
using BugNET.BLL;
using BugNET.BLL.Notifications;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Host.UserControls
{
    public partial class MailSettings : System.Web.UI.UserControl, IEditHostSettingControl
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(MailSettings));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        #region IEditHostSettingControl Members

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
              
                HostSettingManager.UpdateHostSetting(HostSettingNames.HostEmailAddress, HostEmail.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPServer, SMTPServer.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPAuthentication, SMTPEnableAuthentication.Checked.ToString());
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPUsername, SMTPUsername.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPPassword, SMTPPassword.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPDomain, SMTPDomain.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPPort, SMTPPort.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPUseSSL, SMTPUseSSL.Checked.ToString());
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPEMailFormat, SMTPEmailFormat.SelectedValue);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SMTPEmailTemplateRoot, SMTPEmailTemplateRoot.Text);
                return true;

        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            HostEmail.Text = HostSettingManager.Get(HostSettingNames.HostEmailAddress);
            SMTPServer.Text = HostSettingManager.Get(HostSettingNames.SMTPServer);
            SMTPEnableAuthentication.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.SMTPAuthentication));
            SMTPUsername.Text = HostSettingManager.Get(HostSettingNames.SMTPUsername);
            SMTPPort.Text = HostSettingManager.Get(HostSettingNames.SMTPPort);
            SMTPUseSSL.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.SMTPUseSSL));
            SMTPPassword.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.SMTPPassword));
            ShowSMTPAuthenticationFields();
            SMTPEmailFormat.SelectedValue = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, (int)EmailFormatType.Text).ToString();
            SMTPEmailTemplateRoot.Text = HostSettingManager.Get(HostSettingNames.SMTPEmailTemplateRoot, "~/templates");
            SMTPDomain.Text = HostSettingManager.Get(HostSettingNames.SMTPDomain, string.Empty);
        }

        #endregion

        /// <summary>
        /// Tests the email settings.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void TestEmailSettings_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(HostEmail.Text))
                {
                    var smtp = new SmtpClient(SMTPServer.Text, int.Parse(SMTPPort.Text))
                                   {EnableSsl = SMTPUseSSL.Checked};

                    if (SMTPEnableAuthentication.Checked)
                        smtp.Credentials = new NetworkCredential(SMTPUsername.Text, SMTPPassword.Text, SMTPDomain.Text);

                    var message = new MailMessage(HostEmail.Text, HostEmail.Text,
                                                  string.Format(
                                                      GetLocalResourceObject("EmailConfigurationTestSubject").ToString(),
                                                      HostSettingManager.Get(
                                                          HostSettingNames.ApplicationTitle)), string.Empty)
                                      {IsBodyHtml = false};

                    smtp.Send(message);

                    lblEmail.Text = GetLocalResourceObject("EmailConfigurationTestSuccess").ToString();
                    lblEmail.ForeColor = Color.Green;
                }
                else
                {
                    lblEmail.Text = GetLocalResourceObject("MissingHostEmail").ToString();
                    lblEmail.ForeColor = Color.Red;
                }

            }
            catch (Exception ex)
            {
                lblEmail.Text = string.Format(GetLocalResourceObject("SeeErrorLog").ToString(), ex.Message);
                lblEmail.ForeColor = Color.Red;
                Log.Error(GetLocalResourceObject("ConfigurationTestError").ToString(), ex);
            }

        }

        /// <summary>
        /// Handles the CheckChanged event of the SMTPEnableAuthentication control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SMTPEnableAuthentication_CheckChanged(object sender, EventArgs e)
        {
            ShowSMTPAuthenticationFields();
        }

        /// <summary>
        /// Shows the SMTP authentication fields.
        /// </summary>
        private void ShowSMTPAuthenticationFields()
        {
            if (SMTPEnableAuthentication.Checked)
            {
                trSMTPUsername.Visible = true;
                trSMTPPassword.Visible = true;
                trSMTPDomain.Visible = true;
            }
            else
            {
                trSMTPUsername.Visible = false;
                trSMTPPassword.Visible = false;
                trSMTPDomain.Visible = true;
            }
        }

    }
}
