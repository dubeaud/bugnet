namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.IO;
    using System.Web;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;
    using log4net;

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
		protected void Page_Load(object sender, System.EventArgs e)
		{
		}

		#region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
            get
            {
                return ((BasePage)Page).ProjectId;
            }

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
        /// Initializes this instance.
        /// </summary>
		public void Initialize()
		{
           
			ProjectManager.DataSource = UserManager.GetAllUsers();
			ProjectManager.DataBind();
            ProjectManager.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectUser").ToString(), ""));

			if (ProjectId != 0) 
			{
				Project projectToUpdate = BugNET.BLL.ProjectManager.GetProjectById(ProjectId);

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
            BugNET.BLL.ProjectManager.DeleteProjectImage(ProjectId);
        }

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
		{
			if (Page.IsValid) 
			{
                Globals.ProjectAccessType at = (rblAccessType.SelectedValue == "Public") ? Globals.ProjectAccessType.Public : Globals.ProjectAccessType.Private;
                IssueAttachmentStorageTypes attachmentStorageType = (AttachmentStorageType.SelectedValue == "2") ? IssueAttachmentStorageTypes.Database : IssueAttachmentStorageTypes.FileSystem;
                Project newProject = null; 

                // get the current file
                HttpPostedFile uploadFile = ProjectImageUploadFile.PostedFile;
                HttpContext context = HttpContext.Current;

                // if there was a file uploaded
                if (uploadFile.ContentLength > 0)
                {
                    bool isFileOk = false;
                    string[] AllowedFileTypes = new string[3] { ".gif", ".png", ".jpg" };
                    string fileExt = System.IO.Path.GetExtension(uploadFile.FileName);
                    string uploadedFileName = Path.GetFileName(uploadFile.FileName);

                    foreach (string fileType in AllowedFileTypes)
                    {
                        string newfileType = fileType.Substring(fileType.LastIndexOf("."));
                        if (newfileType.CompareTo(fileExt) == 0)
                            isFileOk = true;
                    }

                    //file type is not valid
                    if (!isFileOk)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                        return false;
                    }

                    //check for illegal filename characters
                    if (uploadedFileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                        return false;
                    }

                    //if the file is ok save it.
                    if (isFileOk)
                    {
                            int fileSize = uploadFile.ContentLength;
                            byte[] fileBytes = new byte[fileSize];
                            System.IO.Stream myStream = uploadFile.InputStream;
                            myStream.Read(fileBytes, 0, fileSize);

                            ProjectImage projectImage = new ProjectImage(ProjectId, fileBytes, uploadedFileName, fileSize, uploadFile.ContentType);

                            newProject = new Project(ProjectId, txtName.Text.Trim(), ProjectCode.Text.Trim(), ProjectDescriptionHtmlEditor.Text.Trim(), ProjectManager.SelectedValue, string.Empty,
                            Page.User.Identity.Name, string.Empty, txtUploadPath.Text.Trim(), at, false, AllowAttachments.Checked, attachmentStorageType, string.Empty, chkAllowIssueVoting.Checked,
                            projectImage);
                    }
                }
                else
                {
                    newProject = new Project(ProjectId, txtName.Text.Trim(), ProjectCode.Text.Trim(), ProjectDescriptionHtmlEditor.Text.Trim(), ProjectManager.SelectedValue, string.Empty,
                        Page.User.Identity.Name, string.Empty, txtUploadPath.Text.Trim(), at, false, AllowAttachments.Checked, attachmentStorageType, string.Empty, chkAllowIssueVoting.Checked);
                   
                }

                if (BugNET.BLL.ProjectManager.SaveProject(newProject))
                {
                    ProjectId = newProject.Id;
                    return true;
                }
                else
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
            if (BugNET.BLL.ProjectManager.CheckUploadPath("~" + Globals.UPLOAD_FOLDER + txtUploadPath.Text))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }  
        }
	}
}
