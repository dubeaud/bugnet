using System;
using System.IO;
using BugNET.BLL;
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


                HostSettingManager.UpdateHostSetting("EnableRepositoryCreation", EnableRepoCreation.Checked.ToString());
                HostSettingManager.UpdateHostSetting("RepositoryRootPath", RepoRootPath.Text);
                HostSettingManager.UpdateHostSetting("RepositoryRootUrl", RepoRootUrl.Text);
                HostSettingManager.UpdateHostSetting("RepositoryBackupPath", RepoBackupPath.Text);
                HostSettingManager.UpdateHostSetting("SvnAdminEmailAddress", SvnAdminEmailAddress.Text);
                HostSettingManager.UpdateHostSetting("SvnHookPath", SvnHookPath.Text);
                return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            bool enableRepoCreation = false;
            Boolean.TryParse(HostSettingManager.GetHostSetting("EnableRepositoryCreation"), out enableRepoCreation);

            EnableRepoCreation.Checked = enableRepoCreation;
            RepoRootPath.Text = HostSettingManager.GetHostSetting("RepositoryRootPath");
            RepoRootUrl.Text = HostSettingManager.GetHostSetting("RepositoryRootUrl");
            RepoBackupPath.Text = HostSettingManager.GetHostSetting("RepositoryBackupPath");
            SvnAdminEmailAddress.Text = HostSettingManager.GetHostSetting("SvnAdminEmailAddress");
            SvnHookPath.Text = HostSettingManager.GetHostSetting("SvnHookPath");
        }

        #endregion
    }
}