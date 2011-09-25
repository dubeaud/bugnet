using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class IssueRevisionManager
    {
        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveIssueRevision(IssueRevision issueRevisionToSave)
        {
            if (issueRevisionToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewIssueRevision(issueRevisionToSave);
                if (TempId > Globals.NewId)
                {
                    issueRevisionToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            return true;
        }

        /// <summary>
        /// Gets the issue revisions by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<IssueRevision> GetIssueRevisionsByIssueId(int issueId)
        {
            return DataProviderManager.Provider.GetIssueRevisionsByIssueId(issueId);
        }

        /// <summary>
        /// Deletes the issue revision by id.
        /// </summary>
        /// <param name="issueRevisionId">The issue revision id.</param>
        /// <returns></returns>
        public static bool DeleteIssueRevisionById(int issueRevisionId)
        {
            return DataProviderManager.Provider.DeleteIssueRevision(issueRevisionId);
        }
        #endregion
    }
}
