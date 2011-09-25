


namespace BugNET.Entities
{
	/// <summary>
	/// A role definition for a user in the issue tracker.
	/// </summary>
	public class Role
	{
		#region Private Variables
			private int _Id;
			private string _Name;
			private int _ProjectId;
            private string _Description;
            private bool _AutoAssign;
		#endregion

		#region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="T:Role"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="description">The description.</param>
            /// <param name="autoAssign">if set to <c>true</c> [auto assign].</param>
		    public Role(int id,int projectId,string name,string description, bool autoAssign)
		    {
			    _Id = id;
			    _Name = name;
			    _ProjectId = projectId;
                _Description = description;
                _AutoAssign = autoAssign;
		    }

            /// <summary>
            /// Initializes a new instance of the <see cref="Role"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="description">The description.</param>
            /// <param name="autoAssign">if set to <c>true</c> [auto assign].</param>
            public Role(int projectId, string name, string description, bool autoAssign) 
            {

                _Name = name;
                _ProjectId = projectId;
                _Description = description;
                _AutoAssign = autoAssign;
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
                set { _Id = value; }
			}
            /// <summary>
            /// Gets or sets the name.
            /// </summary>
            /// <value>The name.</value>
			public string Name
			{
				get{return _Name;}
				set{_Name = value;}
			}
            /// <summary>
            /// Gets the project id.
            /// </summary>
            /// <value>The project id.</value>
			public int ProjectId
			{
				get{return _ProjectId;}
			}

            /// <summary>
            /// Gets the description.
            /// </summary>
            /// <value>The description.</value>
            public string Description
            {
                get { return _Description; }
                set { _Description = value; }
            }

            /// <summary>
            /// Gets a value indicating whether [auto assign].
            /// </summary>
            /// <value><c>true</c> if [auto assign]; otherwise, <c>false</c>.</value>
            public bool AutoAssign
            {
                get { return _AutoAssign; }
                set { _AutoAssign = value; }
            }
		#endregion

      
	}
}
