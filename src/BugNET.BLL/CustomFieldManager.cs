using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class CustomFieldManager
    {
        #region Static Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="customFieldToSave">The custom field to save.</param>
        /// <returns></returns>
        public static bool SaveCustomField(CustomField customFieldToSave)
        {


            if (customFieldToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewCustomField(customFieldToSave);
                if (TempId > 0)
                {
                    customFieldToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
                return (DataProviderManager.Provider.UpdateCustomField(customFieldToSave));
        }

       
        /// <summary>
        /// Deletes the custom field.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static bool DeleteCustomField(int customFieldId)
        {
            if (customFieldId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldId"));


            return (DataProviderManager.Provider.DeleteCustomField(customFieldId));
        }

        /// <summary>
        /// Saves the custom field values.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="fields">The fields.</param>
        /// <returns></returns>
        public static bool SaveCustomFieldValues(int issueId, List<CustomField> fields)
        {
            if (issueId <= Globals.NewId)
                throw new ArgumentNullException("issueId");

            if (fields == null)
                throw (new ArgumentOutOfRangeException("fields"));


            return (DataProviderManager.Provider.SaveCustomFieldValues(issueId, fields));
        }

        /// <summary>
        /// Gets the custom fields by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<CustomField> GetCustomFieldsByProjectId(int projectId)
        {
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("projectId"));


            return (DataProviderManager.Provider.GetCustomFieldsByProjectId(projectId));
        }

        /// <summary>
        /// Gets the custom field by id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static CustomField GetCustomFieldById(int customFieldId)
        {
            if (customFieldId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldId"));

            return DataProviderManager.Provider.GetCustomFieldById(customFieldId);
        }

        /// <summary>
        /// Gets the custom fields by bug id.
        /// </summary>
        /// <param name="bugId">The bug id.</param>
        /// <returns></returns>
        public static List<CustomField> GetCustomFieldsByIssueId(int bugId)
        {
            if (bugId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("bugId"));


            return (DataProviderManager.Provider.GetCustomFieldsByIssueId(bugId));
        }
        #endregion
    }
}
