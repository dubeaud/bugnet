using System;
using System.Data;
using System.Collections.Generic;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// Summary description forCategoryTree.
	/// </summary>
	public class CategoryTree
	{
        /// <summary>
        /// Initializes a new instance of the <see cref="T:CategoryTree"/> class.
        /// </summary>
		public CategoryTree()
		{}

		private int _CompIndent = 1;
        private List<Category> _UnSortedCats;
		private List<Category> _SortedCats;


        /// <summary>
        /// Gets the component tree by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
		public List<Category> GetCategoryTreeByProjectId(int projectId) 
		{
  
            _SortedCats = new List<Category>();
			_UnSortedCats = Category.GetCategoriesByProjectId(projectId);
			foreach(Category parentCat in GetTopLevelCategories() ) 
			{
				_SortedCats.Add( parentCat );
				BindSubCategories(parentCat.Id);
			}
			return _SortedCats;
		}


        /// <summary>
        /// Binds the sub categories.
        /// </summary>
        /// <param name="parentId">The parent id.</param>
		void BindSubCategories(int parentId) 
		{
			foreach(Category childCat in GetChildCategories(parentId) ) 
			{
				_SortedCats.Add( new Category( DisplayIndent() + childCat.Name, childCat.Id ) );
				_CompIndent ++;
				BindSubCategories(childCat.Id);
				_CompIndent --;
			}
		}

        /// <summary>
        /// Gets the top level categories.
        /// </summary>
        /// <returns></returns>
		List<Category> GetTopLevelCategories() 
		{
            List<Category> colCats = new List<Category>();
			foreach (Category cat in _UnSortedCats)
				if (cat.ParentCategoryId == 0)
					colCats.Add(cat);
			return colCats;
		}

        /// <summary>
        /// Gets the child categories.
        /// </summary>
        /// <param name="parentId">The parent id.</param>
        /// <returns></returns>
        List<Category> GetChildCategories(int parentId) 
		{
            List<Category> colCats = new List<Category>();
			foreach (Category cat in _UnSortedCats)
				if (cat.ParentCategoryId == parentId)
					colCats.Add(cat);
			return colCats;
		}

        /// <summary>
        /// Displays the indent.
        /// </summary>
        /// <returns></returns>
		string DisplayIndent() 
		{     
		    return new String('-', _CompIndent) + " ";     
		}

	}
}
