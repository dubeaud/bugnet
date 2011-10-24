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

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveOrUpdate(Resolution entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save resolution, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The resolution name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateResolution(entity);

            var tempId = DataProviderManager.Provider.CreateNewResolution(entity);
            if (tempId <= 0) return false;
            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Gets the resolution by id.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public static Resolution GetById(int resolutionId)
        {
            if (resolutionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("resolutionId"));

            return DataProviderManager.Provider.GetResolutionById(resolutionId);
        }

        /// <summary>
        /// Deletes the resolution.
        /// </summary>
        /// <param name="resolutionId">The resolution id.</param>
        /// <returns></returns>
        public static bool Delete(int resolutionId)
        {
            if (resolutionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("resolutionId"));

            return DataProviderManager.Provider.DeleteResolution(resolutionId);
        }


        /// <summary>
        /// Gets the resolutions by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Resolution> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetResolutionsByProjectId(projectId);
        }
    }
}
