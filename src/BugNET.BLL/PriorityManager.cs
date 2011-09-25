using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class PriorityManager
    {
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="milestoneToSave">The milestone to save.</param>
        /// <returns></returns>
        public static bool SavePriority(Priority priorityToSave)
        {
            if (priorityToSave.Id <= Globals.NewId)
            {

                int TempId = DataProviderManager.Provider.CreateNewPriority(priorityToSave);
                if (TempId > 0)
                {
                    priorityToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdatePriority(priorityToSave);
            }
        }


        #region Static Methods
        /// <summary>
        /// Gets the priority by id.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public static Priority GetPriorityById(int priorityId)
        {
            if (priorityId <= Globals.NewId)
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
            return (PriorityManager.CreateNewPriority(projectId, priorityName, string.Empty));
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
            Priority newPriority = new Priority(projectId, priorityName, imageUrl);
            if (PriorityManager.SavePriority(newPriority) == true)
                return newPriority;
            else
                return null;
        }


        /// <summary>
        /// Deletes the priority.
        /// </summary>
        /// <param name="priorityId">The priority id.</param>
        /// <returns></returns>
        public static bool DeletePriority(int priorityId)
        {
            if (priorityId <= Globals.NewId)
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
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("priorityId"));

            return (DataProviderManager.Provider.GetPrioritiesByProjectId(projectId));
        }
        #endregion
    }
}
