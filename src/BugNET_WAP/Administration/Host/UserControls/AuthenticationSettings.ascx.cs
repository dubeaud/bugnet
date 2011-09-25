using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class AuthenticationSettings : System.Web.UI.UserControl, IEditHostSettingControl
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
            HostSettingManager.UpdateHostSetting("UserAccountSource", UserAccountSource.SelectedValue);
            HostSettingManager.UpdateHostSetting("ADUserName", ADUserName.Text);
            HostSettingManager.UpdateHostSetting("ADPath", ADPath.Text);
            HostSettingManager.UpdateHostSetting("UserRegistration", UserRegistration.SelectedValue);
            HostSettingManager.UpdateHostSetting("AnonymousAccess", AnonymousAccess.SelectedValue);
            HostSettingManager.UpdateHostSetting("OpenIdAuthentication", OpenIdAuthentication.SelectedValue);
            HostSettingManager.UpdateHostSetting("ADPassword", ADPassword.Text);
            return true;
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            UserAccountSource.SelectedValue = HostSettingManager.GetHostSetting("UserAccountSource");
            ADUserName.Text = HostSettingManager.GetHostSetting("ADUserName");
            ADPath.Text = HostSettingManager.GetHostSetting("ADPath");
            UserRegistration.SelectedValue = HostSettingManager.GetHostSetting("UserRegistration",(int)Globals.UserRegistration.Public).ToString();
            AnonymousAccess.SelectedValue = HostSettingManager.GetHostSetting("AnonymousAccess", true).ToString();
            OpenIdAuthentication.SelectedValue = HostSettingManager.GetHostSetting("OpenIdAuthentication");
            ADPassword.Attributes.Add("value", HostSettingManager.GetHostSetting("ADPassword"));
            ShowHideUserAccountSourceCredentials();
           
        }

        #endregion

        /// <summary>
        /// Handles the SelectedIndexChanged event of the UserAccountSource control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void UserAccountSource_SelectedIndexChanged(object sender, EventArgs e)
        {
            ShowHideUserAccountSourceCredentials();

        }

        /// <summary>
        /// Shows the hide user account source credentials.
        /// </summary>
        private void ShowHideUserAccountSourceCredentials()
        {
            if (UserAccountSource.SelectedValue != "None")
            {
                trADPassword.Visible = true;
                trADUserName.Visible = true;
                trADPath.Visible = true;
            }
            else
            {
                trADPassword.Visible = false;
                trADUserName.Visible = false;
                trADPath.Visible = false;
            }
        }
    }
}