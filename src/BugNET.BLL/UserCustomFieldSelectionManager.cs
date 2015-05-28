using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class UserCustomFieldSelectionManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="entity">The custom field selection to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(UserCustomFieldSelection entity)
        {
            if (entity.Id > Globals.NEW_ID)
                return (DataProviderManager.Provider.UpdateUserCustomFieldSelection(entity));

            var tempId = DataProviderManager.Provider.CreateNewUserCustomFieldSelection(entity);

            if (tempId <= 0)
                return false;

            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Deletes the custom field selection.
        /// </summary>
        /// <param name="customFieldSelectionId">The custom field selection id.</param>
        /// <returns></returns>
        public static bool Delete(int customFieldSelectionId)
        {
            if (customFieldSelectionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldSelectionId"));

            return (DataProviderManager.Provider.DeleteUserCustomFieldSelection(customFieldSelectionId));
        }


        /// <summary>
        /// Gets the custom fields selections by custom field id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static List<UserCustomFieldSelection> GetByCustomFieldId(int customFieldId)
        {
            if (customFieldId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("customFieldId"));

            return (DataProviderManager.Provider.GetUserCustomFieldSelectionsByCustomFieldId(customFieldId));
        }

        /// <summary>
        /// Gets the custom field selection by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public static UserCustomFieldSelection GetById(int id)
        {
            return (DataProviderManager.Provider.GetUserCustomFieldSelectionById(id));
        }
    }
}
