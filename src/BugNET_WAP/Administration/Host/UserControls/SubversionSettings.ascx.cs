using System;
using System.IO;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class SubversionSettings : System.Web.UI.UserControl, IEditHostSettingControl
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
            
                //Validate the subversion integration fields
                if (EnableRepoCreation.Checked)
                {   
                    RepoRootPath.Text = RepoRootPath.Text.Trim();
                    RepoBackupPath.Text = RepoBackupPath.Text.Trim();

                    if(!RepoRootPath.Text.EndsWith(Path.DirectorySeparatorChar.ToString()))
                        RepoRootPath.Text += Path.DirectorySeparatorChar;

                    if (RepoRootPath.Text.Length == 0 || !Directory.Exists(RepoRootPath.Text))
                    {
                        Message1.Text = "The repository root directory does not exist. To enable subversion administration a valid local folder must exist to hold the repositories.";
                        Message1.IconType = BugNET.UserControls.Message.MessageType.Error;
                        Message1.Visible = true;
                        return false;
                    }

                    //Make sure the backup path is valid if it was given
                    if (RepoBackupPath.Text.Length > 0)
                    {
                        if (!RepoBackupPath.Text.EndsWith(Path.DirectorySeparatorChar.ToString()))
                            RepoBackupPath.Text += Path.DirectorySeparatorChar;

                        if (!Directory.Exists(RepoBackupPath.Text))
                        {
                            Message1.Text = "The repository backup directory does not exist. To disable backup capabilities leave the field empty.";
                            Message1.IconType = BugNET.UserControls.Message.MessageType.Error;
                            Message1.Visible = true;
                            return false;
                        }
                        else
                        {
                            if (string.Compare(RepoBackupPath.Text, RepoRootPath.Text, true) == 0)
                            {
                                Message1.Text = "The repository root and backup path can not be the same directory.";
                                Message1.IconType = BugNET.UserControls.Message.MessageType.Error;
                                Message1.Visible = true;
                                return false;
                            }
                        }

                    }
                } //End subversion integration validation


                HostSettingManager.UpdateHostSetting(HostSettingNames.EnableRepositoryCreation, EnableRepoCreation.Checked.ToString());
                HostSettingManager.UpdateHostSetting(HostSettingNames.RepositoryRootPath, RepoRootPath.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.RepositoryRootUrl, RepoRootUrl.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.RepositoryBackupPath, RepoBackupPath.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SvnAdminEmailAddress, SvnAdminEmailAddress.Text);
                HostSettingManager.UpdateHostSetting(HostSettingNames.SvnHookPath, SvnHookPath.Text);
                return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            bool enableRepoCreation;
            Boolean.TryParse(HostSettingManager.Get(HostSettingNames.EnableRepositoryCreation), out enableRepoCreation);

            EnableRepoCreation.Checked = enableRepoCreation;
            RepoRootPath.Text = HostSettingManager.Get(HostSettingNames.RepositoryRootPath);
            RepoRootUrl.Text = HostSettingManager.Get(HostSettingNames.RepositoryRootUrl);
            RepoBackupPath.Text = HostSettingManager.Get(HostSettingNames.RepositoryBackupPath);
            SvnAdminEmailAddress.Text = HostSettingManager.Get(HostSettingNames.SvnAdminEmailAddress);
            SvnHookPath.Text = HostSettingManager.Get(HostSettingNames.SvnHookPath);
        }

        public bool ShowSaveButton
        {
            get { return true; }
        }

        #endregion
    }
}