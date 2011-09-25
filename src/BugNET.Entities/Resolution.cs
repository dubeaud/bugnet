using System;
using BugNET.Common;

namespace BugNET.Entities
{
	/// <summary>
	/// Summary description for Resolution.
	/// </summary>
	public class Resolution
	{
        #region Private Variables
        private int _Id;
        private string _Name;
        private int _SortOrder;
        private int _ProjectId;
        private string _ImageUrl;
        #endregion


        /// <summary>
        /// Initializes a new instance of the <see cref="Resolution"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="imageUrl">The image URL.</param>
        public Resolution(int projectId, string name,string imageUrl)
                : this(Globals.NewId, projectId, name, -1, imageUrl)
				{}


            /// <summary>
            /// Initializes a new instance of the <see cref="Resolution"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="sortOrder">The sort order.</param>
            /// <param name="imageUrl">The image URL.</param>
			public Resolution(int id,int projectId,string name,int sortOrder,string imageUrl)
			{
				_Id = id;
                _ProjectId = projectId;
				_Name = name;
                _SortOrder = sortOrder;
				_ImageUrl = imageUrl;
			}

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
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder
        {
            get { return _SortOrder; }
            set { _SortOrder = value; }
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
                    throw (new ArgumentOutOfRangeException("value"));
                _ProjectId = value;
            }
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
            set
            {
                _ImageUrl = value;
            }
        }

	}
}
