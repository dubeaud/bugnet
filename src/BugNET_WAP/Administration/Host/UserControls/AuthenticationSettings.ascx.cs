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
            HostSettingManager.UpdateHostSetting(HostSettingNames.ADPassword, ADPassword.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.TwitterAuthentication, TwitterAuthentication.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.TwitterConsumerKey, TwitterConsumerKey.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.TwitterConsumerSecret, TwitterConsumerSecret.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.FacebookAuthentication, FacebookAuthentication.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.FacebookAppId, FacebookAppId.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.FacebookAppSecret, FacebookAppSecret.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.GoogleAuthentication, GoogleAuthentication.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.GoogleClientId, GoogleClientId.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.GoogleClientSecret, GoogleClientSecret.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.MicrosoftClientId, MicrosoftClientId.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.MicrosoftClientSecret, MicrosoftClientSecret.Text);
            HostSettingManager.UpdateHostSetting(HostSettingNames.MicrosoftAuthentication, MicrosoftAuthentication.Checked.ToString());

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
            UserRegistration.SelectedValue = HostSettingManager.Get(HostSettingNames.UserRegistration,(int)Common.UserRegistration.Public).ToString();
            AnonymousAccess.SelectedValue = HostSettingManager.Get(HostSettingNames.AnonymousAccess, true).ToString();
            ADPassword.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.ADPassword));
            TwitterAuthentication.Checked = HostSettingManager.Get(HostSettingNames.TwitterAuthentication, false);
            TwitterConsumerKey.Text = HostSettingManager.Get(HostSettingNames.TwitterConsumerKey);
            TwitterConsumerSecret.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.TwitterConsumerSecret));
            FacebookAuthentication.Checked = HostSettingManager.Get(HostSettingNames.FacebookAuthentication, false);
            FacebookAppId.Text = HostSettingManager.Get(HostSettingNames.FacebookAppId);
            FacebookAppSecret.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.FacebookAppSecret));
            GoogleAuthentication.Checked = HostSettingManager.Get(HostSettingNames.GoogleAuthentication, false);
            GoogleClientId.Text = HostSettingManager.Get(HostSettingNames.GoogleClientId);
            GoogleClientSecret.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.GoogleClientSecret));
            MicrosoftAuthentication.Checked = HostSettingManager.Get(HostSettingNames.MicrosoftAuthentication, false);
            MicrosoftClientId.Text = HostSettingManager.Get(HostSettingNames.MicrosoftClientId);
            MicrosoftClientSecret.Attributes.Add("value", HostSettingManager.Get(HostSettingNames.MicrosoftClientSecret));
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