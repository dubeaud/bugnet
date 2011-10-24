using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueRevisionManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveOrUpdate(IssueRevision entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.IssueId <= Globals.NEW_ID) throw (new ArgumentException("The issue id for the revision is not valid"));

            var tempId = DataProviderManager.Provider.CreateNewIssueRevision(entity);

            if (tempId > Globals.NEW_ID)
            {
                entity.Id = tempId;
                return true;
            }

            return false;
        }

        /// <summary>
        /// Gets the issue revisions by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<IssueRevision> GetByIssueId(int issueId)
        {
            return DataProviderManager.Provider.GetIssueRevisionsByIssueId(issueId);
        }

        /// <summary>
        /// Deletes the issue revision by id.
        /// </summary>
        /// <param name="issueRevisionId">The issue revision id.</param>
        /// <returns></returns>
        public static bool Delete(int issueRevisionId)
        {
            return DataProviderManager.Provider.DeleteIssueRevision(issueRevisionId);
        }
        #endregion
    }
}
