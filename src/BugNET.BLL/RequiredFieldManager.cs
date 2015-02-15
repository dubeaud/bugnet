using System.Collections.Generic;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class RequiredFieldManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Gets the required fields.
        /// </summary>
        /// <returns></returns>
        public static List<RequiredField> GetRequiredFields()
        {
            return DataProviderManager.Provider.GetRequiredFieldsForIssues();
        }
    }
}
