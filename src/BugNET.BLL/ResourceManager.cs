using System.Collections.Generic;
using BugNET.DAL;
using log4net;

namespace BugNET.BLL
{
    public static class ResourceManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Gets the installed language resources.
        /// </summary>
        /// <returns></returns>
        public static IEnumerable<string> GetInstalledLanguageResources()
        {
            return DataProviderManager.Provider.GetInstalledLanguageResources();
        }
    }
}