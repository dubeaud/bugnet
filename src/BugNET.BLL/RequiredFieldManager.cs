using System.Collections.Generic;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class RequiredFieldManager
    {
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
