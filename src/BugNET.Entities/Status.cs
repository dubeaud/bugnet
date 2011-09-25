using System;
using BugNET.Common;


namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Status.
    /// </summary>
	public class Status
	{
		#region Private Variables
			private int _Id;
            private int _ProjectId;
			private string _Name;
            private string _ImageUrl;
            private int _SortOrder;
            private bool _IsClosedState;
		#endregion

		#region Constructors
           
            /// <summary>
            /// Initializes a new instance of the <see cref="Status"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="imageUrl">The image URL.</param>
            public Status(int projectId, string name, string imageUrl, bool isClosedState)
                : this(Globals.NewId, projectId, name, -1, imageUrl, isClosedState)
            { }

            /// <summary>
            /// Initializes a new instance of the <see cref="Status"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="imageUrl">The image URL.</param>
            public Status(int id, int projectId, string name,int sortOrder, string imageUrl, bool isClosedState)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));

                if (name == null || name.Length == 0)
                    throw (new ArgumentOutOfRangeException("statusName"));

                _Id = id;
                _ProjectId = projectId;
                _Name = name;
                _SortOrder = sortOrder;
                _ImageUrl = imageUrl;
                _IsClosedState = isClosedState;
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
            /// Gets or sets a value indicating whether this instance is closed state.
            /// </summary>
            /// <value>
            /// 	<c>true</c> if this instance is closed state; otherwise, <c>false</c>.
            /// </value>
            public bool IsClosedState
            {
                get { return _IsClosedState; }
                set { _IsClosedState = value; }
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
            /// Gets the name.
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
                get
                {
                    if (_ImageUrl == null || _ImageUrl.Length == 0)
                        return string.Empty;
                    else
                        return _ImageUrl;
                }
                set { _ImageUrl = value; }
            }

            /// <summary>
            /// Gets or sets the sort order.
            /// </summary>
            /// <value>The sort order.</value>
            public int SortOrder
            {
                get
                {
                    return _SortOrder;
                }
                set
                {
                    _SortOrder = value;
                }
            }
		#endregion	
	}
}
