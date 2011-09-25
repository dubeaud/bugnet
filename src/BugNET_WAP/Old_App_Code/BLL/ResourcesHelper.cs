using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
    public class ResourcesHelper
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
