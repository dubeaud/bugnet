using System;
using System.Collections;
using System.Collections.Generic;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// Summary description for Permission.
	/// </summary>
	public class RolePermission
	{
		private int _PermissionId;
		private string _PermissionName;
		private string _PermissionKey;
        private string _RoleName;
        private int _ProjectId;

        /// <summary>
        /// Initializes a new instance of the <see cref="Permission"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="key">The key.</param>
		public RolePermission(int permissionId,int projectId, string roleName, string permissionName, string permissionKey)
		{
			_PermissionId = permissionId;
			_PermissionName = permissionName;
            _PermissionKey = permissionKey;
            _RoleName = roleName;
            _ProjectId = projectId;
		}

		#region Properties
            /// <summary>
            /// Gets the id.
            /// </summary>
            /// <value>The id.</value>
			public int PermissionId
			{
				get{return _PermissionId;}
			}

            /// <summary>
            /// Gets the project id.
            /// </summary>
            /// <value>The project id.</value>
            public int ProjectId
            {
                get { return _ProjectId; }
            }

            /// <summary>
            /// Gets the name of the role.
            /// </summary>
            /// <value>The name of the role.</value>
            public string RoleName
            {
                get { return _RoleName; }
            }
            /// <summary>
            /// Gets the name.
            /// </summary>
            /// <value>The name.</value>
			public string PermissionName
			{
				get{return _PermissionName;}
			}
            /// <summary>
            /// Gets the key.
            /// </summary>
            /// <value>The key.</value>
			public string PermissionKey
			{
				get{return _PermissionKey;}
			}
		#endregion

	}
}
