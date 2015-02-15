using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class StatusManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveOrUpdate(Status entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save status, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The status name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateStatus(entity);

            var tempId = DataProviderManager.Provider.CreateNewStatus(entity);

            if (tempId <= 0) return false;
            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Gets the status by id.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public static Status GetById(int statusId)
        {
            if (statusId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("statusId"));

            return DataProviderManager.Provider.GetStatusById(statusId);
        }


        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="id">The id for the item to be deleted.</param>
        /// <param name="cannotDeleteMessage">If</param>
        /// <returns></returns>
        public static bool Delete(int id, out string cannotDeleteMessage)
        {
            if (id <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("id"));

            var entity = GetById(id);

            cannotDeleteMessage = string.Empty;

            if (entity == null) return true;

            var canBeDeleted = DataProviderManager.Provider.CanDeleteStatus(entity.Id);

            if (canBeDeleted)
                return DataProviderManager.Provider.DeleteStatus(entity.Id);

            cannotDeleteMessage = ResourceStrings.GetGlobalResource(GlobalResources.Exceptions, "DeleteItemAssignedToIssueError");
            cannotDeleteMessage = string.Format(cannotDeleteMessage, entity.Name, ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Status", "status").ToLower());

            return false;
        }


        /// <summary>
        /// Gets the status by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Status> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetStatusByProjectId(projectId));
        }
    }
}
