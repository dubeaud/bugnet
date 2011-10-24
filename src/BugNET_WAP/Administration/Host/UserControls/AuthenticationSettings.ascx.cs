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
            HostSettingManager.UpdateHostSetting(HostSettingNames.UserAccountSource, UserAccountSource.SelectedValue);
            HostSettingManager.UpdateHostSetting(HostSettingNames.ADUserName, ADUserName.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.ADPath, ADPath.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.UserRegistration, UserRegistration.SelectedValue);
            HostSettingManager.UpdateHostSetting(HostSettingNames.AnonymousAccess, AnonymousAccess.SelectedValue);
            HostSettingManager.UpdateHostSetting(HostSettingNames.OpenIdAuthentication, OpenIdAuthentication.SelectedValue);
            HostSettingManager.UpdateHostSetting(HostSettingNames.ADPassword, ADPassword.Text);
            return true;
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            UserAccountSource.SelectedValue = HostSettingManager.Get(HostSettingNames.UserAccountSource);
            ADUserName.Text = HostSettingManager.Get(HostSettingNames.ADUserName);
            ADPath.Text = HostSettingManager.Get(HostSettingNames.ADPath);
            UserRegistration.SelectedValue = HostSettingManager.Get(HostSettingNames.UserRegistration,(int)Globals.UserRegistration.Public).ToString();
            AnonymousAccess.SelectedValue = HostSettingManager.Get(HostSettingNames.AnonymousAccess, true).ToString();
            OpenIdAuthentication.SelectedValue = HostSettingManager.Get(HostSettingNames.OpenIdAuthentication);
            ADPassword.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.ADPassword));
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