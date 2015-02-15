using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class PriorityManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves or updates the instance.
        /// </summary>
        /// <param name="entity">The Priority to save or update</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(Priority entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save priority, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The priority name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdatePriority(entity);

            var tempId = DataProviderManager.Provider.CreateNewPriority(entity);
            if (tempId <= 0) return false;

            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Gets the priority by id.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public static Priority GetById(int priorityId)
        {
            if (priorityId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("priorityId"));

            return DataProviderManager.Provider.GetPriorityById(priorityId);
        }

        /// <summary>
        /// Deletes the priority.
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

            var canBeDeleted = DataProviderManager.Provider.CanDeletePriority(entity.Id);

            if (canBeDeleted)
                return DataProviderManager.Provider.DeletePriority(entity.Id);

            cannotDeleteMessage = ResourceStrings.GetGlobalResource(GlobalResources.Exceptions, "DeleteItemAssignedToIssueError");
            cannotDeleteMessage = string.Format(cannotDeleteMessage, entity.Name, ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Priority", "priority").ToLower());

            return false;
        }

        /// <summary>
        /// Gets the priorities by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Priority> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetPrioritiesByProjectId(projectId));
        }
    }
}
