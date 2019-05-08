// -----------------------------------------------------------------------
// <copyright file="WikiManager.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace BugNET.BLL
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using BugNET.DAL;
    using BugNET.Entities;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class WikiManager
    {

        /// <summary>
        /// Gets the content of the wiki.
        /// </summary>
        /// <param name="slug">The slug.</param>
        /// <param name="title">The title.</param>
        /// <returns></returns>
        public static WikiContent Get(int projectId, string slug, string title)
        {
            return DataProviderManager.Provider.GetWikiContent(projectId, slug, title);
        }

        /// <summary>
        /// Gets the wiki content by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public static WikiContent Get(int id)
        {
           return DataProviderManager.Provider.GetWikiContent(id);
        }

        /// <summary>
        /// Gets the wiki content by version.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="version">The version.</param>
        /// <returns></returns>
        public static WikiContent GetByVersion(int id, int version)
        {
            return DataProviderManager.Provider.GetWikiContentByVersion(id, version);
        }

        /// <summary>
        /// Gets the wiki content history.
        /// </summary>
        /// <param name="titleId">The title id.</param>
        /// <returns></returns>
        public static List<WikiContent> GetHistory(int titleId)
        {
            return DataProviderManager.Provider.GetWikiContentHistory(titleId);
        }

        /// <summary>
        /// Saves the content of the wiki.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="id">The id.</param>
        /// <param name="slug">The slug.</param>
        /// <param name="title">The title.</param>
        /// <param name="source">The source.</param>
        /// <returns></returns>
        public static int Save(int projectId, int id, string slug, string title, string source, string createdByUserName)
        {
            return DataProviderManager.Provider.SaveWikiContent(projectId, id, slug, title, source, createdByUserName);
        }

        /// <summary>
        /// Deletes the specified id.
        /// </summary>
        /// <param name="id">The id.</param>
        public static void Delete(int id)
        {
            if (id <= 0)
                throw new ArgumentOutOfRangeException("id");

            DataProviderManager.Provider.DeleteWikiContent(id);
        }
    }
}
