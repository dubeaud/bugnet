using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class ProjectMailboxManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods
        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="mailbox">The mailbox.</param>
        /// <returns></returns>
        public static ProjectMailbox GetProjectByMailbox(string mailbox)
        {
            if (string.IsNullOrEmpty(mailbox))
                throw (new ArgumentOutOfRangeException("mailbox"));

            return DataProviderManager.Provider.GetProjectByMailbox(mailbox);
        }

        /// <summary>
        /// Gets the mailboxes by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<ProjectMailbox> GetMailboxsByProjectId(int projectId)
        {
            if (projectId <= 0)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetMailboxsByProjectId(projectId);
        }


        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="projectMailboxToSave">The project mailbox to save.</param>
        /// <returns></returns>
        public static bool SaveProjectMailbox(ProjectMailbox projectMailboxToSave)
        {
            if (projectMailboxToSave.Id > Globals.NEW_ID)
            {
                return DataProviderManager.Provider.UpdateProjectMailbox(projectMailboxToSave);
            }
            var tempId = DataProviderManager.Provider.CreateProjectMailbox(projectMailboxToSave);
            if (tempId <= 0)
                return false;
            projectMailboxToSave.Id = tempId;
            return true;
        }

        /// <summary>
        /// Deletes the project mailbox by id.
        /// </summary>
        /// <param name="projectMailboxId">The project mailbox id.</param>
        /// <returns></returns>
        public static bool DeleteProjectMailboxById(int projectMailboxId)
        {
            if (projectMailboxId <= 0)
                throw new ArgumentOutOfRangeException("projectMailboxId");

            return DataProviderManager.Provider.DeleteProjectMailbox(projectMailboxId);
        }


        #endregion
    }
}
