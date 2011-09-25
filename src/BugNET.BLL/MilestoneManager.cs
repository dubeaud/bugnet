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

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="milestoneToSave">The milestone to save.</param>
        /// <returns></returns>
        public static bool SaveMilestone(Milestone milestoneToSave)
        {
            if (milestoneToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdateMilestone(milestoneToSave);
            }
            var tempId = DataProviderManager.Provider.CreateNewMilestone(milestoneToSave);
            if (tempId <= 0)
                return false;
            milestoneToSave.Id = tempId;
            return true;
        }

        #endregion

        #region Static Methods
        /// <summary>
        /// Deletes the Milestone.
        /// </summary>
        /// <param name="originalId">The original_id.</param>
        /// <returns></returns>
        public static bool DeleteMilestone(int originalId)
        {
            if (originalId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("originalId"));

            return DataProviderManager.Provider.DeleteMilestone(originalId);
        }


        /// <summary>
        /// Gets the Milestone by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneCompleted">if set to <c>true</c> [milestone completed].</param>
        /// <returns></returns>
        public static List<Milestone> GetMilestoneByProjectId(int projectId, bool milestoneCompleted = true)
        {
            return projectId <= Globals.NEW_ID ? new List<Milestone>() : 
                DataProviderManager.Provider.GetMilestonesByProjectId(projectId, milestoneCompleted);
        }

        /// <summary>
        /// Gets the Milestone by id.
        /// </summary>
        /// <param name="milestoneId">The Milestone id.</param>
        /// <returns></returns>
        public static Milestone GetMilestoneById(int milestoneId)
        {
            if (milestoneId < Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("milestoneId"));


            return DataProviderManager.Provider.GetMilestoneById(milestoneId);
        }



        /// <summary>
        /// Updates the Milestone.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <param name="originalId">The original id.</param>
        /// <returns></returns>
        public static bool UpdateMilestone(string name, int sortOrder, int originalId)
        {
            var v = GetMilestoneById(originalId);

            v.Name = name;
            v.SortOrder = sortOrder;

            return (DataProviderManager.Provider.UpdateMilestone(v));
        }

        #endregion
    }
}
