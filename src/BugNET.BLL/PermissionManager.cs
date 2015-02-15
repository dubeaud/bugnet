using System.Collections.Generic;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class PermissionManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods

        /// <summary>
        /// Gets all permissions.
        /// </summary>
        /// <returns></returns>
        public static List<Permission> GetAll()
        {
            return DataProviderManager.Provider.GetAllPermissions();
        }

        #endregion
    }
}
