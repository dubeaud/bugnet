using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class MilestoneManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The milestone to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(Milestone entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save milestone, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The milestone name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateMilestone(entity);

            var tempId = DataProviderManager.Provider.CreateNewMilestone(entity);
            if (tempId <= 0) return false;

            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Deletes the Milestone.
        /// </summary>
        /// <param name="id">The id for the item to be deleted.</param>
        /// <returns></returns>
        public static bool Delete(int id)
        {
            if (id <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("id"));

            return DataProviderManager.Provider.DeleteMilestone(id);
        }

        /// <summary>
        /// Gets the Milestone by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneCompleted">if set to <c>true</c> [milestone completed].</param>
        /// <returns></returns>
        public static List<Milestone> GetByProjectId(int projectId, bool milestoneCompleted = true)
        {
            return projectId <= Globals.NEW_ID ? new List<Milestone>() : 
                DataProviderManager.Provider.GetMilestonesByProjectId(projectId, milestoneCompleted);
        }

        /// <summary>
        /// Gets the Milestone by id.
        /// </summary>
        /// <param name="milestoneId">The Milestone id.</param>
        /// <returns></returns>
        public static Milestone GetById(int milestoneId)
        {
            if (milestoneId < Globals.NEW_ID) throw (new ArgumentOutOfRangeException("milestoneId"));

            return DataProviderManager.Provider.GetMilestoneById(milestoneId);
        }
    }
}
