using System;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class LoggingSettings : System.Web.UI.UserControl, IEditHostSettingControl
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
            if (EmailErrors.Checked)
                LoggingManager.ConfigureEmailLoggingAppender();
            else
                LoggingManager.RemoveEmailLoggingAppender();

            HostSettingManager.UpdateHostSetting("ErrorLoggingEmailAddress", ErrorLoggingEmail.Text);
            HostSettingManager.UpdateHostSetting("EmailErrors", EmailErrors.Checked.ToString());
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            ErrorLoggingEmail.Text = HostSettingManager.GetHostSetting("ErrorLoggingEmailAddress");
            EmailErrors.Checked = Boolean.Parse(HostSettingManager.GetHostSetting("EmailErrors"));
        }

        #endregion
    }
}