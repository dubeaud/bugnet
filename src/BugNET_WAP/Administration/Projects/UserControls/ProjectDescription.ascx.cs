using System.Linq;
using System;
using System.IO;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Projects.UserControls
{

    /// <summary>
	///		Summary description for ProjectDescription.
	/// </summary>
	public partial class ProjectDescription : System.Web.UI.UserControl,IEditProjectControl
	{
        private static readonly ILog Log = LogManager.GetLogger(typeof(ProjectDescription));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, EventArgs e)
		{
		}

		#region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
            get { return ((BasePage)Page).ProjectId; }
            set { ((BasePage)Page).ProjectId = value; }
		}

        /// <summary>
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return true; }
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
		public void Initialize()
        {
			ProjectManager.DataSource = UserManager.GetAllUsers();
			ProjectManager.DataBind();
            ProjectManager.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectUser").ToString(), ""));

			if (ProjectId > Globals.NEW_ID) 
			{
				var projectToUpdate = BLL.ProjectManager.GetById(ProjectId);

				if (projectToUpdate != null) 
				{
					txtName.Text = projectToUpdate.Name;
                    ProjectDescriptionHtmlEditor.Text = projectToUpdate.Description;
					txtUploadPath.Text = projectToUpdate.UploadPath;
					ProjectCode.Text = projectToUpdate.Code;
					rblAccessType.SelectedValue = projectToUpdate.AccessType.ToString();
                    ProjectManager.SelectedValue = projectToUpdate.ManagerUserName;
                    AllowAttachments.Checked = projectToUpdate.AllowAttachments;
                    AttachmentStorageTypeRow.Visible = AllowAttachments.Checked;
                    chkAllowIssueVoting.Checked = projectToUpdate.AllowIssueVoting;
                    if (AttachmentStorageType.Visible)
                    {
                        AttachmentStorageType.SelectedValue = Convert.ToInt32(projectToUpdate.AttachmentStorageType).ToString();
                        AttachmentUploadPathRow.Visible = AllowAttachments.Checked && AttachmentStorageType.SelectedValue == "1";
                        AttachmentStorageType.Enabled = false;
                    }
                    ProjectImage.ImageUrl = string.Format("~/DownloadAttachment.axd?id={0}&mode=project", ProjectId);
				}
			}
			else
			{
                rblAccessType.SelectedIndex = 0;
                ProjectImage.Visible = false;
                RemoveProjectImage.Visible = false;
			}
		}

        /// <summary>
        /// Handles the Click event of the RemoteProjectImage control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RemoveProjectImage_Click(object sender, EventArgs e)
        {
            BLL.ProjectManager.DeleteProjectImageById(ProjectId);
        }

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
		{
			if (Page.IsValid) 
			{
                var at = (rblAccessType.SelectedValue == "Public") ? Globals.ProjectAccessType.Public : Globals.ProjectAccessType.Private;
                var attachmentStorageType = (AttachmentStorageType.SelectedValue == "2") ? IssueAttachmentStorageTypes.Database : IssueAttachmentStorageTypes.FileSystem;

			    ProjectImage projectImage = null;

                // get the current file
                var uploadFile = ProjectImageUploadFile.PostedFile;

                // if there was a file uploaded
                if (uploadFile.ContentLength > 0)
                {
                    var isFileOk = false;
                    var allowedFileTypes = new string[3] { ".gif", ".png", ".jpg" };
                    var fileExt = Path.GetExtension(uploadFile.FileName);
                    var uploadedFileName = Path.GetFileName(uploadFile.FileName);

                    foreach (var newfileType in allowedFileTypes.Select(fileType => fileType.Substring(fileType.LastIndexOf("."))).Where(newfileType => newfileType.CompareTo(fileExt) == 0))
                    {
                        isFileOk = true;
                    }

                    //file type is not valid
                    if (!isFileOk)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                        return false;
                    }

                    //check for illegal filename characters
                    if (uploadedFileName.IndexOfAny(Path.GetInvalidFileNameChars()) != -1)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                        return false;
                    }

                    var fileSize = uploadFile.ContentLength;
                    var fileBytes = new byte[fileSize];
                    var myStream = uploadFile.InputStream;
                    myStream.Read(fileBytes, 0, fileSize);

                    projectImage = new ProjectImage(ProjectId, fileBytes, uploadedFileName, fileSize, uploadFile.ContentType);
                }

                var project = new Project
                                      {
                                          AccessType = at,
                                          Name = txtName.Text.Trim(),
                                          Id = ProjectId,
                                          CreatorUserName = Page.User.Identity.Name,
                                          CreatorDisplayName = string.Empty, 
                                          Description = ProjectDescriptionHtmlEditor.Text.Trim(),
                                          AllowAttachments = AllowAttachments.Checked,
                                          AllowIssueVoting = chkAllowIssueVoting.Checked,
                                          AttachmentStorageType = attachmentStorageType,
                                          Code = ProjectCode.Text.Trim(),
                                          Disabled = false,
                                          Image = projectImage,
                                          ManagerDisplayName = string.Empty,
                                          ManagerUserName = ProjectManager.SelectedValue,
                                          SvnRepositoryUrl = string.Empty,
                                          UploadPath = txtUploadPath.Text.Trim()
                                      };

                if (BLL.ProjectManager.SaveOrUpdate(project))
                {
                    ProjectId = project.Id;
                    return true;
                }

			    lblError.Text = LoggingManager.GetErrorMessageResource("SaveProjectError");
			}

			return false;
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

        protected void validUploadPath_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // BGN-1909
            args.IsValid = Utilities.CheckUploadPath("~" + Globals.UPLOAD_FOLDER + txtUploadPath.Text);
        }
	}
}
