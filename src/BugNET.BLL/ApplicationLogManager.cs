using System.Collections.Generic;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public static class ApplicationLogManager
    {
        /// <summary>
        /// Gets the log.
        /// </summary>
        /// <returns></returns>
        public static List<ApplicationLog> GetLog(string filterType)
        {
            return DataProviderManager.Provider.GetApplicationLog(filterType);
        }

        /// <summary>
        /// Clears the log.
        /// </summary>
        public static void ClearLog()
        {
            DataProviderManager.Provider.ClearApplicationLog();
        }
    }
}
