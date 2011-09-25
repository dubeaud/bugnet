using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class CustomFieldSelectionManager
    {
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="customFieldSelectionToSave">The custom field selection to save.</param>
        /// <returns></returns>
        public static bool SaveCustomFieldSelection(CustomFieldSelection customFieldSelectionToSave)
        {


            if (customFieldSelectionToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewCustomFieldSelection(customFieldSelectionToSave);
                if (TempId > 0)
                {
                    customFieldSelectionToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
                return (DataProviderManager.Provider.UpdateCustomFieldSelection(customFieldSelectionToSave));
        }


        #region Static Methods

        /// <summary>
        /// Deletes the custom field selection.
        /// </summary>
        /// <param name="customFieldSelectionId">The custom field selection id.</param>
        /// <returns></returns>
        public static bool DeleteCustomFieldSelection(int customFieldSelectionId)
        {
            if (customFieldSelectionId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldSelectionId"));


            return (DataProviderManager.Provider.DeleteCustomFieldSelection(customFieldSelectionId));
        }


        /// <summary>
        /// Gets the custom fields selections by custom field id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static List<CustomFieldSelection> GetCustomFieldsSelectionsByCustomFieldId(int customFieldId)
        {
            if (customFieldId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldId"));


            return (DataProviderManager.Provider.GetCustomFieldSelectionsByCustomFieldId(customFieldId));
        }

        /// <summary>
        /// Updates the custom field selection.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static bool UpdateCustomFieldSelection(int id, string name, string value, int sortOrder, int customFieldId)
        {


            CustomFieldSelection cfs = GetCustomFieldSelectionById(id);

            cfs.Name = name;
            cfs.Value = value;
            cfs.SortOrder = sortOrder;
            //cfs.CustomFieldId = customFieldId;

            return (DataProviderManager.Provider.UpdateCustomFieldSelection(cfs));
        }

        /// <summary>
        /// Creates the custom field selection.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        /// <param name="customFieldId">The custom field id.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <returns></returns>
        public static int CreateCustomFieldSelection(string name, string value,
             int customFieldId, int sortOrder)
        {


            CustomFieldSelection cfs = new CustomFieldSelection(Globals.NewId, customFieldId,
                name, value, sortOrder);

            return (DataProviderManager.Provider.CreateNewCustomFieldSelection(cfs));
        }

        /// <summary>
        /// Gets the custom field selection by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public static CustomFieldSelection GetCustomFieldSelectionById(int id)
        {
            return (DataProviderManager.Provider.GetCustomFieldSelectionById(id));
        }
        #endregion
    }
}
