using System;
using BugNET.Common;

namespace BugNET.Entities
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
                : this(CategoryId, Globals.NEW_ID, Globals.NEW_ID, name, childCount)
            { }
            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="name">The name.</param>
            /// <param name="CategoryId">The Category id.</param>
			public Category( string name, int CategoryId)
                : this(CategoryId, Globals.NEW_ID, Globals.NEW_ID, name, Globals.NEW_ID)
			{}

            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
			public Category( int projectId, string name )
				: this( Globals.NEW_ID, projectId,Globals.NEW_ID,   name,Globals.NEW_ID)
			{}

            /// <summary>
            /// Initializes a new instance of the <see cref="T:Category"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="parentCategoryId">The parent Category id.</param>
            /// <param name="name">The name.</param>
            /// <param name="childCount">The child count.</param>
			public Category( int projectId, int parentCategoryId, string name, int childCount)
				: this( Globals.NEW_ID, projectId,parentCategoryId,  name, childCount)
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
                set { _Id = value; }
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

		

	}
}
