using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class MilestoneManager
    {

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="milestoneToSave">The milestone to save.</param>
        /// <returns></returns>
        public static bool SaveMilestone(Milestone milestoneToSave)
        {

            if (milestoneToSave.Id <= Globals.NewId)
            {

                int TempId = DataProviderManager.Provider.CreateNewMilestone(milestoneToSave);
                if (TempId > 0)
                {
                    milestoneToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateMilestone(milestoneToSave);
            }

        }
        #endregion

        #region Static Methods
        /// <summary>
        /// Deletes the Milestone.
        /// </summary>
        /// <param name="original_id">The original_id.</param>
        /// <returns></returns>
        public static bool DeleteMilestone(int original_id)
        {
            if (original_id <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("original_id"));



            return DataProviderManager.Provider.DeleteMilestone(original_id);
        }


        /// <summary>
        /// Gets the Milestone by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="milestoneCompleted">if set to <c>true</c> [milestone completed].</param>
        /// <returns></returns>
        public static List<Milestone> GetMilestoneByProjectId(int projectId, bool milestoneCompleted)
        {
            if (projectId <= Globals.NewId)
                return new List<Milestone>();

            return DataProviderManager.Provider.GetMilestonesByProjectId(projectId, milestoneCompleted);
        }

        /// <summary>
        /// Gets the milestone by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Milestone> GetMilestoneByProjectId(int projectId)
        {
            return MilestoneManager.GetMilestoneByProjectId(projectId, true);
        }

        /// <summary>
        /// Gets the Milestone by id.
        /// </summary>
        /// <param name="MilestoneId">The Milestone id.</param>
        /// <returns></returns>
        public static Milestone GetMilestoneById(int MilestoneId)
        {
            if (MilestoneId < Globals.NewId)
                throw (new ArgumentOutOfRangeException("MilestoneId"));


            return DataProviderManager.Provider.GetMilestoneById(MilestoneId);
        }



        /// <summary>
        /// Updates the Milestone.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <param name="original_id">The original_id.</param>
        /// <returns></returns>
        public static bool UpdateMilestone(int projectId, string name, int sortOrder, int original_id)
        {

            Milestone v = MilestoneManager.GetMilestoneById(original_id);

            v.Name = name;
            v.SortOrder = sortOrder;

            return (DataProviderManager.Provider.UpdateMilestone(v));
        }

        #endregion
    }
}
