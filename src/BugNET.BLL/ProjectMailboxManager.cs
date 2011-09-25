using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class ProjectMailboxManager
    {
        #region Static Methods
        /// <summary>
        /// Gets the project by mailbox.
        /// </summary>
        /// <param name="mailbox">The mailbox.</param>
        /// <returns></returns>
        public static ProjectMailbox GetProjectByMailbox(string mailbox)
        {
            if (mailbox == null || mailbox.Length == 0)
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

            if (projectMailboxToSave.Id <= Globals.NewId)
            {

                int TempId = DataProviderManager.Provider.CreateProjectMailbox(projectMailboxToSave);
                if (TempId > 0)
                {
                    projectMailboxToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateProjectMailbox(projectMailboxToSave);
            }

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
