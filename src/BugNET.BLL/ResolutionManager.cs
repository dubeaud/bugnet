using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class ResolutionManager
    {

        #region Static Methods

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveResolution(Resolution resolutionToSave)
        {

            if (resolutionToSave.Id <= Globals.NewId)
            {

                int TempId = DataProviderManager.Provider.CreateNewResolution(resolutionToSave);
                if (TempId > 0)
                {
                    resolutionToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateResolution(resolutionToSave);
            }

        }

        /// <summary>
        /// Gets the resolution by id.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public static Resolution GetResolutionById(int resolutionId)
        {
            if (resolutionId <= Globals.NewId)
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
            if (resolutionId <= Globals.NewId)
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
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetResolutionsByProjectId(projectId);
        }
        #endregion
    }
}
