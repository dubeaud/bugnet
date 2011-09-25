namespace BugNET.Entities
{
	/// <summary>
	/// Summary description for Permission.
	/// </summary>
	public class Permission
	{
		private int _Id;
		private string _Name;
		private string _Key;

       

        /// <summary>
        /// Initializes a new instance of the <see cref="Permission"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="key">The key.</param>
		public Permission(int id,string name, string key)
		{
			_Id = id;
			_Name = name;
			_Key = key;
		}

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
            /// Gets the name.
            /// </summary>
            /// <value>The name.</value>
			public string Name
			{
				get{return _Name;}
			}
            /// <summary>
            /// Gets the key.
            /// </summary>
            /// <value>The key.</value>
			public string Key
			{
				get{return _Key;}
			}
		#endregion

		
	}
}
