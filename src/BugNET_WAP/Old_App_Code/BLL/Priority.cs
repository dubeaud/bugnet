using System;
using System.Collections;
using System.Collections.Generic;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// Summary description for Priority.
	/// </summary>
	public class Priority
	{
	
		#region Private Variables
			private int _Id;
            private int _ProjectId;
			private string _Name;
			private string _ImageUrl;
            private int _SortOrder;
		#endregion

		#region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="Priority"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            public Priority(int projectId, string name)
                : this(Globals.NewId, projectId, name,-1, string.Empty)
            { }

            /// <summary>
            /// Initializes a new instance of the <see cref="Priority"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="imageUrl">The image URL.</param>
            public Priority(int projectId, string name, string imageUrl)
                : this(Globals.NewId, projectId, name,-1, imageUrl)
            { }

            /// <summary>
            /// Initializes a new instance of the <see cref="Priority"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="imageUrl">The image URL.</param>
            public Priority(int id, int projectId, string name,int sortOrder, string imageUrl)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));

                if (name == null || name.Length == 0)
                    throw (new ArgumentOutOfRangeException("PriorityName"));

                _Id = id;
                _ProjectId = projectId;
                _Name = name;
                _ImageUrl = imageUrl;
                _SortOrder = sortOrder;
            }
		#endregion

		#region Properties
            /// <summary>
            /// Gets the id.
            /// </summary>
            /// <value>The id.</value>
			public int Id
			{
				get{return _Id;}
			}

            /// <summary>
            /// Gets or sets the project id.
            /// </summary>
            /// <value>The project id.</value>
            public int ProjectId
            {
                get { return _ProjectId; }
                set
                {
                    if (value <= Globals.NewId)
                        throw new ArgumentOutOfRangeException("value");

                    _ProjectId = value;
                }
            }

            /// <summary>
            /// Gets or sets the sort order.
            /// </summary>
            /// <value>The sort order.</value>
            public int SortOrder
            {
                get { return _SortOrder; }
                set { _SortOrder = value; }
            }


            /// <summary>
            /// Gets or sets the name.
            /// </summary>
            /// <value>The name.</value>
            public string Name
            {
                get
                {
                    if (_Name == null || _Name.Length == 0)
                        return string.Empty;
                    else
                        return _Name;
                }
                set { _Name = value; }
            }


            /// <summary>
            /// Gets the image URL.
            /// </summary>
            /// <value>The image URL.</value>
            public string ImageUrl
            {
                get { return _ImageUrl; }
                set { _ImageUrl = value; }
            }
		#endregion

            /*** INSTANCE METHODS  ***/

            /// <summary>
            /// Deletes this instance.
            /// </summary>
            /// <returns></returns>
            public bool Delete()
            {
                return DataProviderManager.Provider.DeletePriority(this.Id);
            }

            /// <summary>
            /// Saves this instance.
            /// </summary>
            /// <returns></returns>
            public bool Save()
            {
                if (Id <= Globals.NewId)
                {

                    int TempId = DataProviderManager.Provider.CreateNewPriority(this);
                    if (TempId > 0)
                    {
                        _Id = TempId;
                        return true;
                    }
                    else
                        return false;
                }
                else
                {
                   return DataProviderManager.Provider.UpdatePriority(this);
                }
            }


		#region Static Methods
            /// <summary>
            /// Gets the priority by id.
            /// </summary>
            /// <param name="priorityId">The priority id.</param>
            /// <returns></returns>
			public static Priority GetPriorityById(int priorityId)
			{
				if (priorityId <= Globals.NewId )
					throw (new ArgumentOutOfRangeException("priorityId"));
	
				return DataProviderManager.Provider.GetPriorityById(priorityId);
			}

            /// <summary>
            /// Gets all priorities.
            /// </summary>
            /// <returns></returns>
			public static IList GetAllPriorities()
			{
                throw new NotImplementedException();	
			}

            /// <summary>
            /// Creates the new priority.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="priorityName">Name of the priority.</param>
            /// <returns></returns>
            public static Priority CreateNewPriority(int projectId, string priorityName)
            {
                return (Priority.CreateNewPriority(projectId, priorityName, string.Empty));
            }


            /// <summary>
            /// Creates the new priority.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="priorityName">Name of the priority.</param>
            /// <param name="imageUrl">The image URL.</param>
            /// <returns></returns>
            public static Priority CreateNewPriority(int projectId, string priorityName, string imageUrl)
            {
                Priority newPriority = new Priority(projectId, priorityName, imageUrl);
                if (newPriority.Save() == true)
                    return newPriority;
                else
                    return null;
            }


            /// <summary>
            /// Deletes the priority.
            /// </summary>
            /// <param name="priorityId">The priority id.</param>
            /// <returns></returns>
            public static bool DeletePriority(int priorityId)
            {
                if (priorityId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("priorityId"));

                return (DataProviderManager.Provider.DeletePriority(priorityId));
            }


            /// <summary>
            /// Gets the priorities by project id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<Priority> GetPrioritiesByProjectId(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("priorityId"));

                return (DataProviderManager.Provider.GetPrioritiesByProjectId(projectId));
            }
		#endregion
	}
}
