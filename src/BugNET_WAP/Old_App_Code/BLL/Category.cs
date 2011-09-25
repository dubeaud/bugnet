using System;
using System.Data;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// Summary description for Category.
	/// </summary>
	public class Category
	{
		#region Private Variables
			private int     _Id;
			private string  _Name;
			private int     _ParentCategoryId;
			private int     _ProjectId;
            private int     _ChildCount;
		#endregion

		#region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="name">The name.</param>
            /// <param name="CategoryId">The Category id.</param>
            /// <param name="childCount">The child count.</param>
            public Category(string name, int CategoryId, int childCount)
                : this(CategoryId, Globals.NewId, Globals.NewId, name, childCount)
            { }
            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="name">The name.</param>
            /// <param name="CategoryId">The Category id.</param>
			public Category( string name, int CategoryId)
                : this(CategoryId, Globals.NewId, Globals.NewId, name, Globals.NewId)
			{}

            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
			public Category( int projectId, string name )
				: this( Globals.NewId, projectId,Globals.NewId,   name,Globals.NewId)
			{}

            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="parentCategoryId">The parent Category id.</param>
            /// <param name="name">The name.</param>
            /// <param name="childCount">The child count.</param>
			public Category( int projectId, int parentCategoryId, string name, int childCount)
				: this( Globals.NewId, projectId,parentCategoryId,  name, childCount)
			{}

            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="categoryId">The category id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="parentCategoryId">The parent Category id.</param>
            /// <param name="name">The name.</param>
            /// <param name="childCount">The child count.</param>
			public Category( int categoryId, int projectId, int parentCategoryId, string name, int childCount) 
			{
				if( parentCategoryId < 0 )
					throw new ArgumentOutOfRangeException("parentCategoryId");

				if( name == null || name.Length == 0 )
					throw new ArgumentException("name");

				_Id            = categoryId;
				_ProjectId        = projectId;
				_Name             = name;
				_ParentCategoryId = parentCategoryId;
                _ChildCount = childCount;
			}
		#endregion

		#region Properties

            /// <summary>
            /// Gets the id.
            /// </summary>
            /// <value>The id.</value>
			public int Id 
			{
				get { return _Id; }
			}

            /// <summary>
            /// Gets the name.
            /// </summary>
            /// <value>The name.</value>
			public string Name 
			{
				get 
				{
					if (_Name == null)
						return string.Empty;
					else
						return _Name;
				}
                set
                {
                    _Name = value;
                }
			}

            /// <summary>
            /// Gets the project id.
            /// </summary>
            /// <value>The project id.</value>
			public int ProjectId 
			{
				get {return _ProjectId;}
			}


            /// <summary>
            /// Gets the child Category count.
            /// </summary>
            /// <value>The child count.</value>
            public int ChildCount
            {
                get { return _ChildCount; }
            }

            /// <summary>
            /// Gets the parent Category id.
            /// </summary>
            /// <value>The parent Category id.</value>
			public int ParentCategoryId 
			{
				get { return _ParentCategoryId; }
                set { _ParentCategoryId = value; }
			}
		#endregion

		#region Instance Methods
            /// <summary>
            /// Saves this instance.
            /// </summary>
            /// <returns></returns>
			public bool Save() 
			{
                if (Id == 0)
                {

                    int TempId = DataProviderManager.Provider.CreateNewCategory(this);
                    if (TempId > 0)
                    {
                        _Id = TempId;
                        return true;
                    }
                    return false;
                }
                else
                {
                   return DataProviderManager.Provider.UpdateCategory(this);
                }
               
			}
		#endregion

		#region Static Methods
            /// <summary>
            /// Deletes the Category.
            /// </summary>
            /// <param name="CategoryId">The Category id.</param>
            /// <returns></returns>
			public static bool DeleteCategory (int categoryId) 
			{
				if (categoryId <= Globals.NewId)
					throw (new ArgumentOutOfRangeException("categoryId"));

                return DataProviderManager.Provider.DeleteCategory(categoryId);	
			}

            /// <summary>
            /// Gets the Categorys by project ID.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
			public static List<Category> GetCategoriesByProjectId(int projectId)
			{
				if (projectId <= Globals.NewId)
					throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.GetCategoriesByProjectId(projectId);

			}
 
            /// <summary>
            /// Gets the root Categorys by project id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<Category> GetRootCategoriesByProjectId(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.GetRootCategoriesByProjectId(projectId);
            }

            /// <summary>
            /// Gets the root Categorys by project id.
            /// </summary>
            /// <param name="CategoryId">The Category id.</param>
            /// <returns></returns>
            public static List<Category> GetChildCategoriesByCategoryId(int categoryId)
            {
                //if (CategoryId <= Globals.NewId)
                //    throw (new ArgumentOutOfRangeException("CategoryId"));

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

                Category c = Category.GetCategoryById(categoryId);

                foreach (Category childCategory in Category.GetChildCategoriesByCategoryId(c.Id))
                    Category.DeleteCategory(childCategory.Id);

                if (c.ChildCount > 0)
                    DeleteChildCategoriesByCategoryId(c.Id);

            }
            /// <summary>
            /// Gets the Category by id.
            /// </summary>
            /// <param name="CategoryId">The Category id.</param>
            /// <returns></returns>
			public static Category GetCategoryById(int categoryId)
			{
                if(categoryId <=0)
                    throw (new ArgumentOutOfRangeException("categoryId"));

                return DataProviderManager.Provider.GetCategoryById(categoryId);
			}


		#endregion

	}
}
