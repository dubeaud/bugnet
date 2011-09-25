using System;
using System.Drawing;
using System.Net;
using System.Net.Mail;
using BugNET.BLL;
using BugNET.BLL.Notifications;
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
              
                HostSettingManager.UpdateHostSetting("HostEmailAddress", HostEmail.Text);
                HostSettingManager.UpdateHostSetting("SMTPServer", SMTPServer.Text);
                HostSettingManager.UpdateHostSetting("SMTPAuthentication", SMTPEnableAuthentication.Checked.ToString());
                HostSettingManager.UpdateHostSetting("SMTPUsername", SMTPUsername.Text);
                HostSettingManager.UpdateHostSetting("SMTPPassword", SMTPPassword.Text);
                HostSettingManager.UpdateHostSetting("SMTPDomain", SMTPDomain.Text);
                HostSettingManager.UpdateHostSetting("SMTPPort", SMTPPort.Text);
                HostSettingManager.UpdateHostSetting("SMTPUseSSL", SMTPUseSSL.Checked.ToString());
                HostSettingManager.UpdateHostSetting("SMTPEMailFormat", SMTPEmailFormat.SelectedValue);
                HostSettingManager.UpdateHostSetting("SMTPEmailTemplateRoot", SMTPEmailTemplateRoot.Text);
                return true;

        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            HostEmail.Text = HostSettingManager.GetHostSetting("HostEmailAddress");
            SMTPServer.Text = HostSettingManager.GetHostSetting("SMTPServer");
            SMTPEnableAuthentication.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("SMTPAuthentication"));
            SMTPUsername.Text = HostSettingManager.GetHostSetting("SMTPUsername");
            SMTPPort.Text = HostSettingManager.GetHostSetting("SMTPPort");
            SMTPUseSSL.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("SMTPUseSSL"));
            SMTPPassword.Attributes.Add("value", HostSettingManager.GetHostSetting("SMTPPassword"));
            ShowSMTPAuthenticationFields();
            SMTPEmailFormat.SelectedValue = HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text).ToString();
            SMTPEmailTemplateRoot.Text = HostSettingManager.GetHostSetting("SMTPEmailTemplateRoot", "~/templates").ToString();
            SMTPDomain.Text = HostSettingManager.GetHostSetting("SMTPDomain", string.Empty).ToString();
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
                    SmtpClient smtp = new SmtpClient(SMTPServer.Text, int.Parse(SMTPPort.Text));
                    smtp.EnableSsl = SMTPUseSSL.Checked;

                    if (SMTPEnableAuthentication.Checked)
                        smtp.Credentials = new NetworkCredential(SMTPUsername.Text, SMTPPassword.Text, SMTPDomain.Text);

                    MailMessage message = new MailMessage(HostEmail.Text, HostEmail.Text,string.Format(GetLocalResourceObject("EmailConfigurationTestSubject").ToString(), HostSettingManager.GetHostSetting("ApplicationTitle")), string.Empty);
                    message.IsBodyHtml = false;

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
