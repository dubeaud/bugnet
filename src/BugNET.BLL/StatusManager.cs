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

        #region Static Methods
        /// <summary>
        /// Gets the status by id.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public static Status GetStatusById(int statusId)
        {
            if (statusId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("statusId"));

            return DataProviderManager.Provider.GetStatusById(statusId);
        }

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveStatus(Status statusToSave)
        {
            if (statusToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdateStatus(statusToSave);
            }
            var tempId = DataProviderManager.Provider.CreateNewStatus(statusToSave);
            if (tempId <= 0)
                return false;
            statusToSave.Id = tempId;
            return true;
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
            return (CreateNewStatus(projectId, statusName, string.Empty));
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
            var newStatus = new Status(projectId, statusName, imageUrl, false);
            return SaveStatus(newStatus) ? newStatus : null;
        }

        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="statusId">The status id.</param>
        /// <returns></returns>
        public static bool DeleteStatus(int statusId)
        {
            if (statusId <= Globals.NEW_ID)
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
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetStatusByProjectId(projectId));
        }

        #endregion
    }
}
