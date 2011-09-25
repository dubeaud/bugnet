using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using BugNET.DAL;
using BugNET.Entities;
using log4net;
using BugNET.Common;

namespace BugNET.BLL
{
    public class ProjectManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Public Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveProject(Project projectToSave)
        {
            if (projectToSave.Id > 0)
                return (UpdateProject(projectToSave));

            var tempId = DataProviderManager.Provider.CreateNewProject(projectToSave);
            if (tempId <= Globals.NEW_ID)
                return false;

            projectToSave.Id = tempId;

            try
            {
                //create default roles for new project.
                RoleManager.CreateDefaultProjectRoles(projectToSave.Id);
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                    Log.Error(
                        string.Format(
                            LoggingManager.GetErrorMessageResource("CouldNotCreateDefaultProjectRoles"),
                            string.Format("ProjectID= {0}", projectToSave.Id)), ex);
                return false;
            }

            //create attachment directory
            if (projectToSave.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
            {
                try
                {
                    // BGN-1909
                    // Better santization of Upload Paths
                    if (!CheckUploadPath("~" + Globals.UPLOAD_FOLDER + projectToSave.UploadPath))
                        throw new InvalidDataException("Upload path is invalid .");

                    Directory.CreateDirectory(
                        HttpContext.Current.Server.MapPath("~" + Globals.UPLOAD_FOLDER +
                                                           projectToSave.UploadPath));
                }
                catch (Exception ex)
                {
                    if (Log.IsErrorEnabled)
                        Log.Error(
                            string.Format(
                                LoggingManager.GetErrorMessageResource("CouldNotCreateUploadDirectory"),
                                HttpContext.Current.Server.MapPath("~" + Globals.UPLOAD_FOLDER +
                                                                   projectToSave.UploadPath)), ex);
                    return false;
                }
            }

            return true;
        }

        #endregion

        #region Private Methods


        /// <summary>
        /// Updates the project.
        /// </summary>
        /// <returns></returns>
        private static bool UpdateProject(Project projectToUpdate)
        {
            var p = GetProjectById(projectToUpdate.Id);
            if (projectToUpdate.AttachmentStorageType == IssueAttachmentStorageType.FileSystem && p.UploadPath != projectToUpdate.UploadPath)
            {
                // BGN-1909
                // Better santization of Upload Paths
                string oldPath = "~" + Globals.UPLOAD_FOLDER + p.UploadPath.Trim();
                string newPath = @"~" + Globals.UPLOAD_FOLDER + projectToUpdate.UploadPath.Trim();
                
                // WARNING: When editing an invalid path, and trying to make it valid, 
                // you will still get an error. This is because the Directory.Move() call 
                // can traverse directories! Maybe we should allow the database to change, 
                // but not change the file system?
                bool isPathNorty = !CheckUploadPath(oldPath);

                if (!CheckUploadPath(newPath))
                    isPathNorty = true;

                if (isPathNorty)
                {
                    // something bad is going on. DONT even File.Exist()!!
                    if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("CouldNotCreateUploadDirectory"), HttpContext.Current.Server.MapPath(@"~" + Globals.UPLOAD_FOLDER + projectToUpdate.UploadPath)));
                    return false;
                }

                try
                {
                    // BGN-1878 Upload path not recreated when user fiddles with a project setting
                    if (File.Exists(HttpContext.Current.Server.MapPath(oldPath)))
                    {
                        Directory.Move(HttpContext.Current.Server.MapPath(oldPath), HttpContext.Current.Server.MapPath(newPath));
                    }
                    else
                    {
                        Directory.CreateDirectory(HttpContext.Current.Server.MapPath(newPath));
                    }
                }
                catch (Exception ex)
                {
                    if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("CouldNotCreateUploadDirectory"), HttpContext.Current.Server.MapPath("~" + Globals.UPLOAD_FOLDER + projectToUpdate.UploadPath)), ex);
                    return false;
                }
            }
            return DataProviderManager.Provider.UpdateProject(projectToUpdate);

        }
        #endregion

        #region Static Methods

        /// <summary>
        /// Gets the project by id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static Project GetProjectById(int projectId)
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
        public static Project GetProjectByCode(string projectCode)
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

            return GetProjectsByMemberUserName(userName, true);
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


            return DataProviderManager.Provider.GetProjectsByMemberUserName(userName, activeOnly);

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
            if (projectId <= Globals.NEW_ID)
                throw new ArgumentOutOfRangeException("projectId");


            return DataProviderManager.Provider.AddUserToProject(userName, projectId);
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
            if (projectId <= Globals.NEW_ID)
                throw new ArgumentOutOfRangeException("projectId");

            if (DataProviderManager.Provider.RemoveUserFromProject(userName, projectId))
            {
                //Remove the user from any project notifications.
                List<ProjectNotification> notifications = ProjectNotificationManager.GetProjectNotificationsByUsername(userName);
                if (notifications.Count > 0)
                {
                    foreach (ProjectNotification notify in notifications)
                        ProjectNotificationManager.DeleteProjectNotification(notify.ProjectId, userName);
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
            if (projectId <= Globals.NEW_ID)
                throw new ArgumentOutOfRangeException("projectId");

            return DataProviderManager.Provider.IsUserProjectMember(userName, projectId);
        }

        /// <summary>
        /// Deletes the project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static bool DeleteProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            var uploadpath = GetProjectById(projectId).UploadPath;

            if (DataProviderManager.Provider.DeleteProject(projectId))
            {
                try
                {
                    uploadpath = string.Concat("~", Globals.UPLOAD_FOLDER, uploadpath);
                    Directory.Delete(HttpContext.Current.Server.MapPath(uploadpath), true);
                }
                catch (Exception ex) {
                    Log.Error(string.Format("Could not delete upload folder {0} for project id {1}", uploadpath, projectId), ex);
                }

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
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(projectName)) throw new ArgumentNullException("projectName");

            var newProjectId = DataProviderManager.Provider.CloneProject(projectId, projectName);

            if (newProjectId != 0)
            {
                var newProject = GetProjectById(newProjectId);
                try
                {
                    if (newProject.AllowAttachments && newProject.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
                    {
                        // Old bugfix which wasn't carried forward.
                        newProject.UploadPath = Guid.NewGuid().ToString();
                        DataProviderManager.Provider.UpdateProject(newProject);

                        Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~" + Globals.UPLOAD_FOLDER + newProject.UploadPath));
                    }
                }
                catch (Exception ex)
                {
                    if (Log.IsErrorEnabled)
                        Log.Error(string.Format("Could not create new upload folder {0} for project {1}", newProject.UploadPath, newProject.Name), ex);

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
            if (projectId <= Globals.NEW_ID)
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
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));
            if (milestoneId < -1)
                throw new ArgumentNullException("milestoneId");

            return DataProviderManager.Provider.GetProjectRoadmapProgress(projectId, milestoneId);
        }

        /// <summary>
        /// Gets the change log.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetChangeLog(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
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

        /// <summary>
        /// This checks the Project upload path within the context of the 
        /// BugNET application.
        /// 
        /// Plugs numerous security holes.
        /// 
        /// BGN-1909
        /// BGN-1905
        /// BGN-1904
        /// </summary>
        /// <param name="sPath"></param>
        /// <returns></returns>
        public static bool CheckUploadPath(string sPath)
        {
            var isPathNorty = false;
            var tmpPath = sPath; // dont even trim it!

            // BGN-1904
            // Check the length of the upload path
            // 64 characters are allows            
            if ((tmpPath.Length > Globals.UPLOAD_FOLDER_LIMIT ))
            {
                isPathNorty = true;
            }

            // Now check for funny characters but there is a slight problem.

            // The string paths are "~\Uploads\Project1\"
            // The "\\" is seen as a UNC path and marked invalid
            // However our encoding defines a UNC path as "\\"
            // So we have to do some magic first

            // Reject any UNC paths
            if (tmpPath.Contains(@"\\"))
            {
                isPathNorty = true;
            }

            // Reject attempts to traverse directories
            if ((tmpPath.Contains(@"\..")) ||
                (tmpPath.Contains(@"..\")) || (tmpPath.Contains(@"\.\")))
            {
                isPathNorty = true;
            }

            // Now that there are just folders left, remove the "\" character
            tmpPath = tmpPath.Replace(@"\", " ");

            //check for illegal filename characters
            if (tmpPath.IndexOfAny(Path.GetInvalidFileNameChars()) != -1)
            {
                isPathNorty = true;
            }

            // Return the opposite of norty
            return !isPathNorty;
        }

        #endregion
    }
}
