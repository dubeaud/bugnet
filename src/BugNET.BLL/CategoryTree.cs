using System;
using System.Linq;
using BugNET.Entities;
using System.Collections.Generic;
using log4net;

namespace BugNET.BLL
{
	/// <summary>
	/// Summary description forCategoryTree.
	/// </summary>
	public class CategoryTree
	{
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

	    private int _compIndent = 1;
        private List<Category> _unSortedCats;
		private List<Category> _sortedCats;

        /// <summary>
        /// Gets the component tree by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
		public List<Category> GetCategoryTreeByProjectId(int projectId) 
		{
  
            _sortedCats = new List<Category>();
			_unSortedCats = CategoryManager.GetByProjectId(projectId);
			foreach(var parentCat in GetTopLevelCategories() ) 
			{
				_sortedCats.Add( parentCat );
				BindSubCategories(parentCat.Id);
			}
			return _sortedCats;
		}


        /// <summary>
        /// Binds the sub categories.
        /// </summary>
        /// <param name="parentId">The parent id.</param>
		void BindSubCategories(int parentId) 
		{
			foreach(var childCat in GetChildCategories(parentId) )
			{
			    var categoryName = string.Concat(DisplayIndent(), childCat.Name);
                _sortedCats.Add(new Category { Name = categoryName, Id = childCat.Id });
				_compIndent ++;
				BindSubCategories(childCat.Id);
				_compIndent --;
			}
		}

        /// <summary>
        /// Gets the top level categories.
        /// </summary>
        /// <returns></returns>
		IEnumerable<Category> GetTopLevelCategories()
        {
            return _unSortedCats.Where(cat => cat.ParentCategoryId == 0).ToList();
        }

	    /// <summary>
        /// Gets the child categories.
        /// </summary>
        /// <param name="parentId">The parent id.</param>
        /// <returns></returns>
        IEnumerable<Category> GetChildCategories(int parentId)
	    {
	        return _unSortedCats.Where(cat => cat.ParentCategoryId == parentId).ToList();
	    }

	    /// <summary>
        /// Displays the indent.
        /// </summary>
        /// <returns></returns>
		string DisplayIndent() 
		{     
		    return new String('-', _compIndent) + " ";     
		}

	}
}
