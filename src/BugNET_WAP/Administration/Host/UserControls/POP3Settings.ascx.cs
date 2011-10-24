using System;
using BugNET.BLL;
using BugNET.Common;
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
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3ReaderEnabled, POP3ReaderEnabled.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3Server, POP3Server.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3UseSSL, POP3UseSSL.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3Username, POP3Username.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3Password, POP3Password.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3Interval, POP3Interval.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3DeleteAllMessages, POP3DeleteMessages.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3InlineAttachedPictures, POP3ProcessAttachments.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3BodyTemplate, POP3BodyTemplate.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3ReportingUsername, POP3ReportingUsername.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3Port, POP3Port.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.Pop3ProcessAttachments, POP3ProcessAttachments.Checked.ToString());
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            POP3ReaderEnabled.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3ReaderEnabled));
            POP3Server.Text = HostSettingManager.Get(HostSettingNames.Pop3Server);
            POP3UseSSL.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3UseSSL));
            POP3Username.Text = HostSettingManager.Get(HostSettingNames.Pop3Username);
            POP3Interval.Text = HostSettingManager.Get(HostSettingNames.Pop3Interval);
            POP3DeleteMessages.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3DeleteAllMessages));
            POP3ProcessAttachments.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3InlineAttachedPictures));
            POP3BodyTemplate.Text = HostSettingManager.Get(HostSettingNames.Pop3BodyTemplate);
            POP3ReportingUsername.Text = HostSettingManager.Get(HostSettingNames.Pop3ReportingUsername);
            POP3Password.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.Pop3Password));
            POP3Port.Text = HostSettingManager.Get(HostSettingNames.Pop3Port);
            POP3ProcessAttachments.Checked = Boolean.Parse(HostSettingManager.Get(HostSettingNames.Pop3ProcessAttachments));
        }

        #endregion
    }
}