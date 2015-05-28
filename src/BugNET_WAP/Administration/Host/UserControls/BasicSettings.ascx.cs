using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class BasicSettings : System.Web.UI.UserControl, IEditHostSettingControl
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
        /// <returns></returns>
        public bool Update()
        {
           
                HostSettingManager.UpdateHostSetting(HostSettingNames.WelcomeMessage, WelcomeMessageHtmlEditor.Text.Trim());
                HostSettingManager.UpdateHostSetting(HostSettingNames.ApplicationTitle, ApplicationTitle.Text.Trim());
                HostSettingManager.UpdateHostSetting(HostSettingNames.DefaultUrl, DefaultUrl.Text.EndsWith("/") ? DefaultUrl.Text : DefaultUrl.Text = DefaultUrl.Text + "/");
                HostSettingManager.UpdateHostSetting(HostSettingNames.EnableGravatar, EnableGravatar.Checked.ToString());
                return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            //get hostsettings for this control here and bind them to ctrls
            ApplicationTitle.Text = HostSettingManager.Get(HostSettingNames.ApplicationTitle);
            WelcomeMessageHtmlEditor.Text = HostSettingManager.Get(HostSettingNames.WelcomeMessage);
            DefaultUrl.Text = HostSettingManager.Get(HostSettingNames.DefaultUrl);
            EnableGravatar.Checked = HostSettingManager.Get(HostSettingNames.EnableGravatar,true);
        }

        public bool ShowSaveButton
        {
            get { return true; }
        }

        #endregion
    }
}