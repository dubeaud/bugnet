using System;
using BugNET.Common;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class AttachmentSettings : System.Web.UI.UserControl, IEditHostSettingControl
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
            HostSettingManager.UpdateHostSetting(HostSettingNames.AllowedFileExtensions, AllowedFileExtentions.Text.Trim());
            HostSettingManager.UpdateHostSetting(HostSettingNames.FileSizeLimit, FileSizeLimit.Text.Trim());
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            AllowedFileExtentions.Text = HostSettingManager.Get(HostSettingNames.AllowedFileExtensions);
            FileSizeLimit.Text = HostSettingManager.Get(HostSettingNames.FileSizeLimit);
        }

        #endregion
    }
}