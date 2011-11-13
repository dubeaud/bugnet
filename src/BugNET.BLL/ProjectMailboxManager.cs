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
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The project mailbox to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(ProjectMailbox entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save milestone, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Mailbox)) throw (new ArgumentException("The mailbox cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateProjectMailbox(entity);

            var tempId = DataProviderManager.Provider.CreateProjectMailbox(entity);

            if (tempId <= 0) return false;

            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="projectMailboxId">The mailbox id.</param>
        /// <returns></returns>
        public static ProjectMailbox GetById(int projectMailboxId)
        {
            if (projectMailboxId <= 0) throw new ArgumentOutOfRangeException("projectMailboxId");

            return DataProviderManager.Provider.GetProjectMailboxByMailboxId(projectMailboxId);
        }

        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="mailbox">The mailbox.</param>
        /// <returns></returns>
        public static ProjectMailbox GetByMailbox(string mailbox)
        {
            if (string.IsNullOrEmpty(mailbox)) throw (new ArgumentOutOfRangeException("mailbox"));

            return DataProviderManager.Provider.GetProjectByMailbox(mailbox);
        }

        /// <summary>
        /// Gets the mailboxes by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<ProjectMailbox> GetByProjectId(int projectId)
        {
            if (projectId <= 0) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetMailboxsByProjectId(projectId);
        }

        /// <summary>
        /// Deletes the project mailbox by id.
        /// </summary>
        /// <param name="projectMailboxId">The project mailbox id.</param>
        /// <returns></returns>
        public static bool Delete(int projectMailboxId)
        {
            if (projectMailboxId <= 0) throw new ArgumentOutOfRangeException("projectMailboxId");

            return DataProviderManager.Provider.DeleteProjectMailbox(projectMailboxId);
        }


        #endregion
    }
}
