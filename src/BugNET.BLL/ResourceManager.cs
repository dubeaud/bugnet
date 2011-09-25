using System.Collections.Generic;
using BugNET.DAL;

namespace BugNET.BLL
{
    public class ResourceManager
    {
        /// <summary>
        /// Gets the installed language resources.
        /// </summary>
        /// <returns></returns>
        public static List<string> GetInstalledLanguageResources()
        {
            return DataProviderManager.Provider.GetInstalledLanguageResources();
        }
    }
}
