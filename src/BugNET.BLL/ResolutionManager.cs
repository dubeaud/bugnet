using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class ResolutionManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveResolution(Resolution resolutionToSave)
        {
            if (resolutionToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdateResolution(resolutionToSave);
            }
            var tempId = DataProviderManager.Provider.CreateNewResolution(resolutionToSave);
            if (tempId <= 0)
                return false;
            resolutionToSave.Id = tempId;
            return true;
        }

        /// <summary>
        /// Gets the resolution by id.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public static Resolution GetResolutionById(int resolutionId)
        {
            if (resolutionId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("resolutionId"));

            return DataProviderManager.Provider.GetResolutionById(resolutionId);
        }

        /// <summary>
        /// Deletes the resolution.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public static bool DeleteResolution(int resolutionId)
        {
            if (resolutionId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("resolutionId"));

            return DataProviderManager.Provider.DeleteResolution(resolutionId);
        }


        /// <summary>
        /// Gets the resolutions by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Resolution> GetResolutionsByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetResolutionsByProjectId(projectId);
        }
        #endregion
    }
}
