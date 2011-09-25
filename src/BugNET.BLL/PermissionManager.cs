using System.Collections.Generic;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class PermissionManager
    {
        #region Static Methods


        /// <summary>
        /// Gets all permissions.
        /// </summary>
        /// <returns></returns>
        public static List<Permission> GetAllPermissions()
        {
            return DataProviderManager.Provider.GetAllPermissions();
        }
        #endregion
    }
}
