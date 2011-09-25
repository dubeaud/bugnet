using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class CategoryManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public static bool SaveCategory(Category categoryToSave)
        {
            if (categoryToSave.Id == 0)
            {

                var tempId = DataProviderManager.Provider.CreateNewCategory(categoryToSave);
                if (tempId > 0)
                {
                    categoryToSave.Id = tempId;
                    return true;
                }
                return false;
            }
            return DataProviderManager.Provider.UpdateCategory(categoryToSave);
        }

        #endregion

        #region Static Methods

        /// <summary>
        /// Deletes the Category.
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        public static bool DeleteCategory(int categoryId)
        {
            if (categoryId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("categoryId"));

            return DataProviderManager.Provider.DeleteCategory(categoryId);
        }

        /// <summary>
        /// Gets the Categories by project ID.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Category> GetCategoriesByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetCategoriesByProjectId(projectId);

        }

        /// <summary>
        /// Gets the root Categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Category> GetRootCategoriesByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetRootCategoriesByProjectId(projectId);
        }

        /// <summary>
        /// Gets the root Categories by project id.
        /// </summary>
        /// <param name="categoryId">The Category id.</param>
        /// <returns></returns>
        public static List<Category> GetChildCategoriesByCategoryId(int categoryId)
        {

            return DataProviderManager.Provider.GetChildCategoriesByCategoryId(categoryId);
        }

        /// <summary>
        /// Deletes the child categories by category id.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        public static void DeleteChildCategoriesByCategoryId(int categoryId)
        {
            if (categoryId <= 0)
                throw new ArgumentOutOfRangeException("categoryId");

            var c = GetCategoryById(categoryId);

            foreach (var childCategory in GetChildCategoriesByCategoryId(c.Id))
                DeleteCategory(childCategory.Id);

            if (c.ChildCount > 0)
                DeleteChildCategoriesByCategoryId(c.Id);

        }
        /// <summary>
        /// Gets the Category by id.
        /// </summary>
        /// <param name="categoryId">The Category id.</param>
        /// <returns></returns>
        public static Category GetCategoryById(int categoryId)
        {
            if (categoryId <= 0)
                throw (new ArgumentOutOfRangeException("categoryId"));

            return DataProviderManager.Provider.GetCategoryById(categoryId);
        }


        #endregion

    }
}
