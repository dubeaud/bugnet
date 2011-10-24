using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class CustomFieldManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The custom field to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(CustomField entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save custom field, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The custom field name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return (DataProviderManager.Provider.UpdateCustomField(entity));

            var tempId = DataProviderManager.Provider.CreateNewCustomField(entity);

            if (tempId <= 0)
                return false;

            entity.Id = tempId;
            return true;
        }


        /// <summary>
        /// Deletes the custom field.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static bool Delete(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

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
            if (issueId <= Globals.NEW_ID) throw new ArgumentNullException("issueId");
            if (fields == null) throw (new ArgumentOutOfRangeException("fields"));

            return (DataProviderManager.Provider.SaveCustomFieldValues(issueId, fields));
        }

        /// <summary>
        /// Gets the custom fields by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<CustomField> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetCustomFieldsByProjectId(projectId));
        }

        /// <summary>
        /// Gets the custom field by id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static CustomField GetById(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            return DataProviderManager.Provider.GetCustomFieldById(customFieldId);
        }

        /// <summary>
        /// Gets the custom fields by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<CustomField> GetByIssueId(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return (DataProviderManager.Provider.GetCustomFieldsByIssueId(issueId));
        }
    }
}
