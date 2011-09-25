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
        /// Saves this instance.
        /// </summary>
        /// <param name="priorityToSave"></param>
        /// <returns></returns>
        public static bool SavePriority(Priority priorityToSave)
        {
            if (priorityToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdatePriority(priorityToSave);
            }
            var tempId = DataProviderManager.Provider.CreateNewPriority(priorityToSave);
            if (tempId <= 0)
                return false;
            priorityToSave.Id = tempId;
            return true;
        }

        #region Static Methods
        /// <summary>
        /// Gets the priority by id.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public static Priority GetPriorityById(int priorityId)
        {
            if (priorityId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("priorityId"));

            return DataProviderManager.Provider.GetPriorityById(priorityId);
        }

        /// <summary>
        /// Creates the new priority.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="priorityName">Name of the priority.</param>
        /// <returns></returns>
        public static Priority CreateNewPriority(int projectId, string priorityName)
        {
            return (CreateNewPriority(projectId, priorityName, string.Empty));
        }


        /// <summary>
        /// Creates the new priority.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="priorityName">Name of the priority.</param>
        /// <param name="imageUrl">The image URL.</param>
        /// <returns></returns>
        public static Priority CreateNewPriority(int projectId, string priorityName, string imageUrl)
        {
            var newPriority = new Priority(projectId, priorityName, imageUrl);
            return SavePriority(newPriority) ? newPriority : null;
        }


        /// <summary>
        /// Deletes the priority.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public static bool DeletePriority(int priorityId)
        {
            if (priorityId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("priorityId"));

            return (DataProviderManager.Provider.DeletePriority(priorityId));
        }


        /// <summary>
        /// Gets the priorities by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Priority> GetPrioritiesByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetPrioritiesByProjectId(projectId));
        }
        #endregion
    }
}
