using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class StatusManager
    {
        #region Static Methods
        /// <summary>
        /// Gets the status by id.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public static Status GetStatusById(int statusId)
        {
            if (statusId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("statusId"));

            return DataProviderManager.Provider.GetStatusById(statusId);
        }

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveStatus(Status statusToSave)
        {
            if (statusToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewStatus(statusToSave);
                if (TempId > 0)
                {
                    statusToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateStatus(statusToSave);
            }
        }


        /*** STATIC METHODS ***/

        /// <summary>
        /// Creates the new status.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="statusName">Name of the status.</param>
        /// <returns></returns>
        public static Status CreateNewStatus(int projectId, string statusName)
        {
            return (StatusManager.CreateNewStatus(projectId, statusName, string.Empty));
        }

        /// <summary>
        /// Creates the new status.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="statusName">Name of the status.</param>
        /// <param name="imageUrl">The image URL.</param>
        /// <returns></returns>
        public static Status CreateNewStatus(int projectId, string statusName, string imageUrl)
        {
            Status newStatus = new Status(projectId, statusName, imageUrl, false);
            if (StatusManager.SaveStatus(newStatus) == true)
                return newStatus;
            else
                return null;
        }

        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public static bool DeleteStatus(int statusId)
        {
            if (statusId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("statusId"));

            return (DataProviderManager.Provider.DeleteStatus(statusId));
        }


        /// <summary>
        /// Gets the status by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Status> GetStatusByProjectId(int projectId)
        {
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("statusName"));

            return (DataProviderManager.Provider.GetStatusByProjectId(projectId));
        }

        #endregion
    }
}
