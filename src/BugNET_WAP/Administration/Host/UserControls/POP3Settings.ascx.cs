using System;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class POP3Settings : System.Web.UI.UserControl, IEditHostSettingControl
    {
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
        public bool Update()
        {    
            HostSettingManager.UpdateHostSetting("Pop3ReaderEnabled", POP3ReaderEnabled.Checked.ToString());
            HostSettingManager.UpdateHostSetting("Pop3Server", POP3Server.Text);
            HostSettingManager.UpdateHostSetting("Pop3UseSSL", POP3UseSSL.Checked.ToString());
            HostSettingManager.UpdateHostSetting("Pop3Username", POP3Username.Text);
            HostSettingManager.UpdateHostSetting("Pop3Password", POP3Password.Text);
            HostSettingManager.UpdateHostSetting("Pop3Interval", POP3Interval.Text);
            HostSettingManager.UpdateHostSetting("Pop3DeleteAllMessages", POP3DeleteMessages.Checked.ToString());
            HostSettingManager.UpdateHostSetting("Pop3InlineAttachedPictures", POP3ProcessAttachments.Checked.ToString());
            HostSettingManager.UpdateHostSetting("Pop3BodyTemplate", POP3BodyTemplate.Text);
            HostSettingManager.UpdateHostSetting("Pop3ReportingUsername", POP3ReportingUsername.Text);
            HostSettingManager.UpdateHostSetting("Pop3Port", POP3Port.Text);
            HostSettingManager.UpdateHostSetting("Pop3ProcessAttachments", POP3ProcessAttachments.Checked.ToString());
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            POP3ReaderEnabled.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("Pop3ReaderEnabled"));
            POP3Server.Text = HostSettingManager.GetHostSetting("Pop3Server");
            POP3UseSSL.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("Pop3UseSSL"));
            POP3Username.Text = HostSettingManager.GetHostSetting("Pop3Username");
            POP3Interval.Text = HostSettingManager.GetHostSetting("Pop3Interval");
            POP3DeleteMessages.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("Pop3DeleteAllMessages"));
            POP3ProcessAttachments.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("Pop3InlineAttachedPictures"));
            POP3BodyTemplate.Text = HostSettingManager.GetHostSetting("Pop3BodyTemplate");
            POP3ReportingUsername.Text = HostSettingManager.GetHostSetting("Pop3ReportingUsername");
            POP3Password.Attributes.Add("value", HostSettingManager.GetHostSetting("Pop3Password"));
            POP3Port.Text = HostSettingManager.GetHostSetting("Pop3Port");
            POP3ProcessAttachments.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("Pop3ProcessAttachments"));
        }

        #endregion
    }
}