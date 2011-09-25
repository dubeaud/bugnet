using System;
using System.Data;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using BugNET.DataAccessLayer;
using BugNET.UserInterfaceLayer;
using System.IO;
using System.Web;
using System.Xml.Serialization;
using log4net;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Class for project images
    /// </summary>
    public class ProjectImage
    {
        public int  ProjectId{get;set;}
        public byte[] ImageContent{get; set;}
        public string ImageFileName{get; set;}
        public long ImageFileLength { get; set; }
        public string ImageContentType { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectImage"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="imageContent">Content of the image.</param>
        /// <param name="imageFileName">Name of the image file.</param>
        /// <param name="imageFileLength">Length of the image file.</param>
        /// <param name="imageContentType">Type of the image content.</param>
        public ProjectImage(int projectId,byte[] imageContent, string imageFileName, long imageFileLength, string imageContentType)
        {
            ImageContent = imageContent;
            ImageFileName = imageFileName;
            ImageFileLength = imageFileLength;
            ImageContentType = imageContentType;
        }
    }

	/// <summary>
	/// Summary description for Project.
	/// </summary>
	public class Project
	{
		private string				        _Description;
		private int					        _Id;
		private string				        _Name;
		private string				        _Code;
        private Guid                        _ManagerId;
		private string				        _ManagerUserName;
        private string                      _ManagerDisplayName;
		private DateTime			        _DateCreated;
        private string                      _CreatorUserName;
        private string                      _CreatorDisplayName;
		private string				        _UploadPath;
		private bool				        _Disabled;
		private Globals.ProjectAccessType   _AccessType;
        private bool                        _AllowAttachments;
        private IssueAttachmentStorageType  _AttachmentStorageType;
        private string                      _SvnRepositoryUrl;
        private bool                        _AllowIssueVoting;
        private ProjectImage                _ProjectImage;
        private bool                        _UploadPathChanged;
       

        private static readonly ILog Log = LogManager.GetLogger(typeof(Project));

		#region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="imageContent">Content of the image.</param>
        /// <param name="imageFileName">Name of the image file.</param>
        /// <param name="imageFileLength">Length of the image file.</param>
        /// <param name="imageContentType">Type of the image content.</param>
        //public Project(int projectId,byte[] imageContent, string imageFileName, long imageFileLength, string imageContentType)
        //{
        //    _ImageContent = imageContent;
        //    _ImageFileName = imageFileName;
        //    _ImageFileLength = imageFileLength;
        //    _ImageContentType = imageContentType;
        //}

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="managerDisplayName">Display name of the manager.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="disabled">if set to <c>true</c> [disabled].</param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
        /// <param name="attachmentStorageType">Type of the attachment storage.</param>
        /// <param name="svnRepositoryUrl">The SVN repository URL.</param>
        /// <param name="allowIssueVoting">if set to <c>true</c> [allow issue voting].</param>
        /// <param name="imageContent">Content of the image.</param>
        /// <param name="imageFileName">Name of the image file.</param>
        /// <param name="imageFileLength">Length of the image file.</param>
        /// <param name="imageContentType">Type of the image content.</param>
        public Project(int projectId, string name, string code, string description, string managerUserName, string managerDisplayName, string creatorUserName, string creatorDisplayName, string uploadPath, Globals.ProjectAccessType accessType, bool disabled, bool allowAttachments,
            IssueAttachmentStorageType attachmentStorageType, string svnRepositoryUrl, bool allowIssueVoting, ProjectImage projectImage)
            : this(projectId, name, code, description, managerUserName, managerDisplayName, creatorUserName, creatorDisplayName, uploadPath, DateTime.Now, accessType, disabled, allowAttachments, Guid.Empty, attachmentStorageType, svnRepositoryUrl, allowIssueVoting, projectImage)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="active">The active.</param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
        public Project(int projectId, string name, string code, string description, string managerUserName,string managerDisplayName, string creatorUserName,string creatorDisplayName, string uploadPath, Globals.ProjectAccessType accessType, bool disabled, bool allowAttachments, IssueAttachmentStorageType attachmentStorageType, string svnRepositoryUrl, bool allowIssueVoting)
            : this(projectId, name, code, description, managerUserName, managerDisplayName, creatorUserName, creatorDisplayName, uploadPath, DateTime.Now, accessType, disabled, allowAttachments, Guid.Empty, attachmentStorageType, svnRepositoryUrl, allowIssueVoting, null)
    		{}

        /// <summary>
        /// Initializes a new instance of the <see cref="Project"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="code">The code.</param>
        /// <param name="description">The description.</param>
        /// <param name="managerUserName">Name of the manager user.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="uploadPath">The upload path.</param>
        /// <param name="dateCreated">The date created.</param>
        /// <param name="accessType">Type of the access.</param>
        /// <param name="active">The active.</param>
        /// <param name="allowAttachments">if set to <c>true</c> [allow attachments].</param>
		public Project(int projectId,string name,string code, string description,string managerUserName,string managerDisplayName,
                string creatorUserName,string creatorDisplayName, string uploadPath, DateTime dateCreated, Globals.ProjectAccessType accessType,
                bool disabled, bool allowAttachments, Guid managerId, IssueAttachmentStorageType attachmentStorageType, string svnRepositoryUrl, bool allowIssueVoting, 
                ProjectImage projectImage)
			{
				// Validate Mandatory Fields//
				if (name == null ||name.Length==0 )
					throw (new ArgumentOutOfRangeException("name"));

				_Id                     = projectId;
				_Description            = description;
				_Name                   = name;
				_Code					= code;
				_ManagerUserName        = managerUserName;
                _ManagerDisplayName     = managerDisplayName;
                _ManagerId              = managerId;
				_CreatorUserName		= creatorUserName;
                _CreatorDisplayName     = creatorDisplayName;
				_DateCreated            = dateCreated;
				_UploadPath				= uploadPath;
				_Disabled				= disabled;
				_AccessType				= accessType;
                _AllowAttachments       = allowAttachments;
                _AttachmentStorageType  = attachmentStorageType;
                _SvnRepositoryUrl       = svnRepositoryUrl;
                _AllowIssueVoting       = allowIssueVoting;
                _ProjectImage           = projectImage;
			}
            /// <summary>
            /// Initializes a new instance of the <see cref="Project"/> class.
            /// </summary>
			public Project(){}
		#endregion

		#region Properties
            /// <summary>
            /// Gets or sets the id.
            /// </summary>
            /// <value>The id.</value>
			public int Id
			{
				get {return _Id;}
				set {throw new Exception("Cannot set read only property Id");}
			}

            /// <summary>
            /// Gets or sets the image.
            /// </summary>
            /// <value>The image.</value>
            public ProjectImage Image
            {
                get { return _ProjectImage; }
                set { _ProjectImage = value; }
            }
           
            /// <summary>
            /// Gets or sets a value indicating whether [allow issue voting].
            /// </summary>
            /// <value><c>true</c> if [allow issue voting]; otherwise, <c>false</c>.</value>
            public bool AllowIssueVoting
            {
                get { return _AllowIssueVoting; }
                set { _AllowIssueVoting = value; }
            }


            /// <summary>
            /// Gets or sets the type of the attachment storage.
            /// </summary>
            /// <value>The type of the attachment storage.</value>
            public IssueAttachmentStorageType AttachmentStorageType 
            {
                get { return _AttachmentStorageType; }
                set { _AttachmentStorageType = value; } 
            }
            /// <summary>
            /// Gets or sets the code.
            /// </summary>
            /// <value>The code.</value>
			public string Code
			{
				get{return _Code;}
				set{_Code = value;}
			}

            /// <summary>
            /// Gets or sets the manager id.
            /// </summary>
            /// <value>The manager id.</value>
            public Guid ManagerId
            {
                get { return _ManagerId; }
                set { _ManagerId = value; }
            }

            /// <summary>
            /// Gets or sets the name of the creator user.
            /// </summary>
            /// <value>The name of the creator user.</value>
			public string CreatorUserName
			{
				get {return _CreatorUserName;}
                set { _CreatorUserName = value; }
			}

            /// <summary>
            /// Gets or sets the display name of the creator.
            /// </summary>
            /// <value>The display name of the creator.</value>
            public string CreatorDisplayName
            {
                get { return _CreatorDisplayName; }
                set { _CreatorDisplayName = value; }
            }

            /// <summary>
            /// Gets or sets a value indicating whether this <see cref="Project"/> is disabled.
            /// </summary>
            /// <value><c>true</c> if disabled; otherwise, <c>false</c>.</value>
			public bool Disabled 
			{
				get {return _Disabled;}
                set { _Disabled = value; }
			}

            /// <summary>
            /// Gets or sets the name.
            /// </summary>
            /// <value>The name.</value>
			public string Name 
			{
				get
				{
					if (_Name == null ||_Name.Length==0)
						return string.Empty;
					else
						return _Name;
				}
				set {_Name = value;}
			}

            /// <summary>
            /// Gets or sets the description.
            /// </summary>
            /// <value>The description.</value>
			public string Description 
			{
				get 
				{
					if (_Description == null ||_Description.Length==0)
						return string.Empty;
					else
						return _Description;
				}
				set
				{ _Description = value;}
			}

            /// <summary>
            /// Gets or sets the date created.
            /// </summary>
            /// <value>The date created.</value>
			public DateTime DateCreated 
			{
				get {return  _DateCreated;}
				set{throw new Exception("Cannot set readonly property DateCreated");}
			}

            /// <summary>
            /// Gets or sets the name of the manager user.
            /// </summary>
            /// <value>The name of the manager user.</value>
			public string ManagerUserName 
			{
				get {return  _ManagerUserName;}
                set { _ManagerUserName = value; }
			}

            /// <summary>
            /// Gets or sets the display name of the manager.
            /// </summary>
            /// <value>The display name of the manager.</value>
            public string ManagerDisplayName
            {
                get { return _ManagerDisplayName; }
                set { _ManagerDisplayName = value; }
            }

            /// <summary>
            /// Gets or sets the upload path.
            /// </summary>
            /// <value>The upload path.</value>
			public string UploadPath
			{
				get 
				{
					if (_UploadPath == null || _UploadPath.Length==0)
						return string.Empty;
					else
						return _UploadPath;
				}
				set {_UploadPath = value;}
			}

            /// <summary>
            /// Gets or sets the type of the access.
            /// </summary>
            /// <value>The type of the access.</value>
			public Globals.ProjectAccessType AccessType
			{
				get
				{
					return _AccessType;

				}
				set
				{
					_AccessType = value;
				}
			}

            /// <summary>
            /// Gets or sets a value indicating whether [allow attachments].
            /// </summary>
            /// <value><c>true</c> if [allow attachments]; otherwise, <c>false</c>.</value>
            public bool AllowAttachments
            {
                get
                {
                    return _AllowAttachments;

                }
                set
                {
                    _AllowAttachments = value;
                }
            }

            /// <summary>
            /// Gets or sets the SVN repository URL.
            /// </summary>
            /// <value>The SVN repository URL.</value>
            public string SvnRepositoryUrl
            {
                get { return _SvnRepositoryUrl; }
                set { _SvnRepositoryUrl = value; }
            }
		#endregion

		#region Public Methods
            /// <summary>
            /// Saves this instance.
            /// </summary>
            /// <returns></returns>
			public bool Save () 
			{
				if (_Id <= 0) 
				{
					    
					int TempId = DataProviderManager.Provider.CreateNewProject(this);
					if (TempId>Globals.NewId) 
					{
						_Id = TempId;
						try
						{	
                            //create default roles for new project.
                            Role.CreateDefaultProjectRoles(_Id);
							//create attachment directory
                        }
                        catch(Exception ex)
                        {
                            if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("CouldNotCreateDefaultProjectRoles"), string.Format("ProjectID= {0}", _Id)), ex);
                            return false;
                        }

                        if (this.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
                        {
                            try
                            {
                                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(@"~\Uploads\" + _UploadPath));
                            }
                            catch (Exception ex)
                            {
                                if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("CouldNotCreateUploadDirectory"), HttpContext.Current.Server.MapPath(@"~\Uploads\" + _UploadPath)), ex);
                                return false;
                            }
                        }
						
						return true;
					}  
					else
						return false;
				}
				else
					return (UpdateProject());
			}		
		#endregion

		#region Private Methods


            /// <summary>
            /// Updates the project.
            /// </summary>
            /// <returns></returns>
			private bool UpdateProject()
			{
                Project p = Project.GetProjectById(_Id);
                if (this.AttachmentStorageType == IssueAttachmentStorageType.FileSystem && p.UploadPath != UploadPath)
                {
                    try
                    {

                        Directory.Move(HttpContext.Current.Server.MapPath(@"~\Uploads\" + p.UploadPath), HttpContext.Current.Server.MapPath(@"~\Uploads\" + _UploadPath));
                    }
                    catch (Exception ex)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("CouldNotCreateUploadDirectory"), HttpContext.Current.Server.MapPath(@"~\Uploads\" + _UploadPath)), ex);
                        return false;
                    }
                }
				return DataProviderManager.Provider.UpdateProject(this);
			
			}
		#endregion

		#region Static Methods
            /// <summary>
            /// Gets the project by id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
			public static Project GetProjectById(int  projectId) 
			{
				// validate input
				if (projectId <= 0)
					throw (new ArgumentOutOfRangeException("projectId"));

				return DataProviderManager.Provider.GetProjectById(projectId);
			}

            /// <summary>
            /// Gets the project image.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static ProjectImage GetProjectImage(int projectId)
            {
                // validate input
                if (projectId <= 0)
                    throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.GetProjectImageById(projectId);
            }

            /// <summary>
            /// Deletes the project image.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static bool DeleteProjectImage(int projectId)
            {
                // validate input
                if (projectId <= 0)
                    throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.DeleteProjectImage(projectId);
            }

            /// <summary>
            /// Gets the project by code.
            /// </summary>
            /// <param name="projectCode">The project code.</param>
            /// <returns></returns>
			public static Project GetProjectByCode(string  projectCode) 
			{
				// validate input
				if (string.IsNullOrEmpty(projectCode))
					throw (new ArgumentOutOfRangeException("projectCode"));

				
				return DataProviderManager.Provider.GetProjectByCode(projectCode);
			}

            /// <summary>
            /// Gets all projects.
            /// </summary>
            /// <returns></returns>
			public static List<Project> GetAllProjects()
			{				
				return DataProviderManager.Provider.GetAllProjects();
			}

            /// <summary>
            /// Gets the public projects.
            /// </summary>
            /// <returns></returns>
			public static List<Project> GetPublicProjects()
			{
						
				return DataProviderManager.Provider.GetPublicProjects();
			}

            /// <summary>
            /// Gets the name of the projects by user.
            /// </summary>
            /// <param name="userName">Name of the user.</param>
            /// <returns></returns>
			public static List<Project> GetProjectsByMemberUserName(string userName) 
			{
				if (String.IsNullOrEmpty(userName))
					throw (new ArgumentOutOfRangeException("userName"));
				
				return GetProjectsByMemberUserName(userName,  true);
			}

            /// <summary>
            /// Gets the name of the projects by user.
            /// </summary>
            /// <param name="userName">Name of the user.</param>
            /// <param name="activeOnly">if set to <c>true</c> [active only].</param>
            /// <returns></returns>
            public static List<Project> GetProjectsByMemberUserName(string userName, bool activeOnly) 
			{
                if (String.IsNullOrEmpty(userName))
                    throw (new ArgumentOutOfRangeException("userName"));

						
				return DataProviderManager.Provider.GetProjectsByMemberUserName(userName,activeOnly);
				
			}

            /// <summary>
            /// Adds the user to project.
            /// </summary>
            /// <param name="userName">Name of the user.</param>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
			public static bool AddUserToProject(string userName, int projectId) 
			{
                if (String.IsNullOrEmpty(userName))
                    throw new ArgumentOutOfRangeException("userName");
                if (projectId <= Globals.NewId)
                    throw new ArgumentOutOfRangeException("projectId");
				
						
				return DataProviderManager.Provider.AddUserToProject(userName,projectId);
			}

            /// <summary>
            /// Removes the user from project.
            /// </summary>
            /// <param name="userName">Name of the user.</param>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
			public static bool RemoveUserFromProject(string userName, int projectId) 
			{
                if (String.IsNullOrEmpty(userName))
                    throw new ArgumentOutOfRangeException("userName");
                if (projectId <= Globals.NewId)
                    throw new ArgumentOutOfRangeException("projectId");		    
              
                if (DataProviderManager.Provider.RemoveUserFromProject(userName, projectId))
                {
                    //Remove the user from any project notifications.
                    List<ProjectNotification> notifications = ProjectNotification.GetProjectNotificationsByUsername(userName);
                    if (notifications.Count > 0)
                    {
                        foreach (ProjectNotification notify in notifications)
                            ProjectNotification.DeleteProjectNotification(notify.ProjectId, userName);
                    }
                }
                return true;
			}

            /// <summary>
            /// Determines whether [is project member] [the specified user id].
            /// </summary>
            /// <param name="userName">Name of the user.</param>
            /// <param name="projectId">The project id.</param>
            /// <returns>
            /// 	<c>true</c> if [is project member] [the specified user id]; otherwise, <c>false</c>.
            /// </returns>
            public static bool IsUserProjectMember(string userName, int projectId)
            {
                if (String.IsNullOrEmpty(userName))
                    throw new ArgumentOutOfRangeException("userName");
                if (projectId <= Globals.NewId)
                    throw new ArgumentOutOfRangeException("projectId");
                
                return DataProviderManager.Provider.IsUserProjectMember(userName, projectId);
            }

            /// <summary>
            /// Deletes the project.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
			public static bool DeleteProject (int projectId) 
			{
				if (projectId <= Globals.NewId )
					throw (new ArgumentOutOfRangeException("projectId"));
				
                string uploadpath = GetProjectById(projectId).UploadPath;

                if (DataProviderManager.Provider.DeleteProject(projectId))
                {
                    try
                    {
                        System.IO.Directory.Delete(HttpContext.Current.Server.MapPath("~" +  Globals.UploadFolder + uploadpath), true);
                    }
                    catch { }
                  
                    return true;
                }
                return false;
			}

          

            /// <summary>
            /// Clones the project.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="projectName">Name of the project.</param>
            /// <returns></returns>
            public static bool CloneProject(int projectId, string projectName)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));
                if(string.IsNullOrEmpty(projectName))
                    throw new ArgumentNullException("projectName");

                int NewProjectId = DataProviderManager.Provider.CloneProject(projectId, projectName);
                if (NewProjectId != 0)
                {
                    Project NewProject = Project.GetProjectById(NewProjectId);
                    try 
                    {   
                        if (NewProject.AllowAttachments && NewProject.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
                        {
                            System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~" + Globals.UploadFolder + NewProject.UploadPath));
                        }     
                    }
                    catch(Exception ex)
                    {
                        if (Log.IsErrorEnabled)
                            Log.Error(string.Format("Could not create new upload folder {0} for project {1}",NewProject.UploadPath, NewProject.Name), ex);

                    }                    
                    HttpContext.Current.Cache.Remove("RolePermission");
                    return true;
                }

                return false;
            }

            /// <summary>
            /// Gets the road map.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<RoadMapIssue> GetRoadMap(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));
       
                return DataProviderManager.Provider.GetProjectRoadmap(projectId);
            }

            /// <summary>
            /// Gets the road map progress.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="milestoneId">The milestone id.</param>
            /// <returns>total number of issues and total number of close issues</returns>
            public static int[] GetRoadMapProgress(int projectId, int milestoneId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));
                if (milestoneId < -1)
                    throw new ArgumentNullException("milestoneId");

                return DataProviderManager.Provider.GetProjectRoadmapProgress(projectId,milestoneId);
            }

            /// <summary>
            /// Gets the change log.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<Issue> GetChangeLog(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.GetProjectChangeLog(projectId);
            }

            ///Iman Mayes
            /// <summary>
            /// Gets the users and roles by project id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<MemberRoles> GetProjectMembersRoles(int projectId)
            {
                return DataProviderManager.Provider.GetProjectMembersRoles(projectId);
            }

		#endregion

        /// <summary>
        /// Returns a <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        /// </returns>
		public override string ToString()
		{
			return _Name;
		}

	
	}
}
