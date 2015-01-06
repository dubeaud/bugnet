using System;
using BugNET.Common;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;
using System.Web.UI.WebControls;
using System.Web.Configuration;

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
            System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration("~");
            HttpRuntimeSection section = config.GetSection("system.web/httpRuntime") as HttpRuntimeSection;

            HostSettingManager.UpdateHostSetting(HostSettingNames.AllowAttachments, AllowAttachments.Checked.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.AttachmentStorageType, AttachmentStorageType.SelectedValue);
            HostSettingManager.UpdateHostSetting(HostSettingNames.AllowedFileExtensions, AllowedFileExtentions.Text.Trim());
            HostSettingManager.UpdateHostSetting(HostSettingNames.FileSizeLimit, section.MaxRequestLength.ToString());
            HostSettingManager.UpdateHostSetting(HostSettingNames.AttachmentUploadPath, txtUploadPath.Text.Trim().EndsWith(@"\") ? txtUploadPath.Text.Trim() : txtUploadPath.Text.Trim() + @"\");
            return true;
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            AllowAttachments.Checked = HostSettingManager.Get(HostSettingNames.AllowAttachments, false);
            AttachmentStorageTypeRow.Visible = AllowAttachments.Checked;
            if (AttachmentStorageType.Visible)
            {
                AttachmentStorageType.SelectedValue = Convert.ToInt32(HostSettingManager.Get(HostSettingNames.AttachmentStorageType)).ToString();
                AttachmentUploadPathRow.Visible = AllowAttachments.Checked && AttachmentStorageType.SelectedValue == "1";
            }

            AllowedFileExtentions.Text = HostSettingManager.Get(HostSettingNames.AllowedFileExtensions);

            System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration("~");
            HttpRuntimeSection section = config.GetSection("system.web/httpRuntime") as HttpRuntimeSection;
            double maxFileSize = Math.Round(section.MaxRequestLength / 1024.0, 1);

            FileSizeLimit.Text = string.Format("{0} MB", maxFileSize.ToString());
            txtUploadPath.Text = HostSettingManager.Get(HostSettingNames.AttachmentUploadPath);
        }

        #endregion

        /// <summary>
        /// Allows the attachments changed.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AllowAttachmentsChanged(object sender, EventArgs e)
        {
            if (!AllowAttachments.Checked)
                txtUploadPath.Text = string.Empty;

            AttachmentStorageTypeRow.Visible = AllowAttachments.Checked;
            AttachmentUploadPathRow.Visible = AllowAttachments.Checked && AttachmentStorageType.SelectedValue == "1";
        }

        /// <summary>
        /// Handles the Changed event of the AttachmentStorageType control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AttachmentStorageType_Changed(object sender, EventArgs e)
        {
            if (AttachmentStorageType.SelectedValue != "1")
                txtUploadPath.Text = string.Empty;

            AttachmentUploadPathRow.Visible = AllowAttachments.Checked && AttachmentStorageType.SelectedValue == "1";
        }

        //protected void validUploadPath_ServerValidate(object source, ServerValidateEventArgs args)
        //{
        //    // BGN-1909
        //    args.IsValid = Utilities.CheckUploadPath(txtUploadPath.Text);
        //}
    }
}