using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class ProjectNotificationManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveOrUpdate(ProjectNotification entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save notification, the project id is invalid"));

            var tempId = DataProviderManager.Provider.CreateNewProjectNotification(entity);

            if (tempId <= 0) return false;
            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Deletes the project notification.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static bool Delete(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.DeleteProjectNotification(projectId, username);
        }


        /// <summary>
        /// Gets the project notifications by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static IEnumerable<ProjectNotification> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetProjectNotificationsByProjectId(projectId);
        }

        /// <summary>
        /// Gets the project notifications by username.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<ProjectNotification> GetByUsername(string username)
        {
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetProjectNotificationsByUsername(username);
        }
    }
}
