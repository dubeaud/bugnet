using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class ProjectNotificationManager
    {

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveProjectNotification(ProjectNotification projectNotificationToSave)
        {
            int TempId = DataProviderManager.Provider.CreateNewProjectNotification(projectNotificationToSave);
            if (TempId > 0)
            {
                projectNotificationToSave.Id = TempId;
                return true;
            }
            else
                return false;
        }

        /// <summary>
        /// Deletes the project notification.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static bool DeleteProjectNotification(int projectId, string username)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.DeleteProjectNotification(projectId, username);
        }


        /// <summary>
        /// Gets the project notifications by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<ProjectNotification> GetProjectNotificationsByProjectId(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetProjectNotificationsByProjectId(projectId);
        }

        /// <summary>
        /// Gets the project notifications by username.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<ProjectNotification> GetProjectNotificationsByUsername(string username)
        {
            if (string.IsNullOrEmpty(username))
                throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetProjectNotificationsByUsername(username);
        }
    }
}
