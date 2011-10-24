using System;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{

    /// <summary>
	///		Summary description for ProjectDescription.
	/// </summary>
	public partial class ProjectSubversion : System.Web.UI.UserControl,IEditProjectControl
	{

        private int _projectId = -1;
        
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{

		}

        /// <summary>
        /// Handles the Click event of the createRepoBttn control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void createRepoBttn_Click(object sender, EventArgs e)
        {
            string name = repoName.Text.Trim();

            if(!SourceIntegrationManager.IsValidSubversionName(name)) {
                createErrorLbl.Text = LoggingManager.GetErrorMessageResource("InvalidRepositoryName");
                return;
            }

            svnOut.Text = SourceIntegrationManager.CreateRepository(name);

            string rootUrl = HostSettingManager.Get(HostSettingNames.RepositoryRootUrl);
            if(!rootUrl.EndsWith("/"))
                rootUrl += "/";

            svnUrl.Text = rootUrl + name;

        }

        /// <summary>
        /// Handles the Click event of the createTagBttn control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void createTagBttn_Click(object sender, EventArgs e)
        {
            string name = tagName.Text.Trim();
           
            if (tagComment.Text.Trim().Length == 0)
                createTagErrorLabel.Text = LoggingManager.GetErrorMessageResource("RepositoryCommentRequired");
            else if (!SourceIntegrationManager.IsValidSubversionName(name))
                createTagErrorLabel.Text = LoggingManager.GetErrorMessageResource("InvalidRepositoryTagName");
            else
                svnOut.Text = SourceIntegrationManager.CreateTag(this.ProjectId, name, tagComment.Text, tagUserName.Text.Trim(), tagPassword.Text.Trim());
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
                return _projectId;
            }

            set { _projectId = value; }
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
           Project projectToUpdate = ProjectManager.GetProjectById(ProjectId);
            svnUrl.Text = projectToUpdate.SvnRepositoryUrl;

           bool svnAdminEnabled = bool.Parse(HostSettingManager.Get(HostSettingNames.EnableRepositoryCreation));

           if (svnAdminEnabled)
           {
               createErrorLbl.Text = "";
               createRepoBttn.Enabled = true;
               repoName.Enabled = true;
           }
           else
           {
               createErrorLbl.Text = GetLocalResourceObject("RepositoryCreationDisabled").ToString();
               createRepoBttn.Enabled = false;
               repoName.Enabled = false;
           }
			
		}

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
		{
			if (Page.IsValid) 
			{
                Project projectToUpdate = ProjectManager.GetProjectById(ProjectId);
                projectToUpdate.SvnRepositoryUrl = svnUrl.Text;

            
                if (ProjectManager.SaveProject(projectToUpdate)) 
				{
                    ProjectId = projectToUpdate.Id;
					return true;
				} 
				else
                    lblError.Text = LoggingManager.GetErrorMessageResource("RepositoryProjectSaveError");
			}
			return false;
		}
      

		#endregion
	}
}
