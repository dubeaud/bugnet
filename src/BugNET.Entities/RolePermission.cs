namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for Permission.
    /// </summary>
    public class RolePermission
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Permission"/> class.
        /// </summary>
        /// <param name="permissionId"></param>
        /// <param name="projectId"></param>
        /// <param name="roleName"></param>
        /// <param name="permissionName"></param>
        /// <param name="permissionKey"></param>
        public RolePermission(int permissionId, int projectId, string roleName, string permissionName, string permissionKey)
        {
            PermissionId = permissionId;
            PermissionName = permissionName;
            PermissionKey = permissionKey;
            RoleName = roleName;
            ProjectId = projectId;
        }

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int PermissionId { get; private set; }

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; private set; }

        /// <summary>
        /// Gets the name of the role.
        /// </summary>
        /// <value>The name of the role.</value>
        public string RoleName { get; private set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string PermissionName { get; private set; }

        /// <summary>
        /// Gets the key.
        /// </summary>
        /// <value>The key.</value>
        public string PermissionKey { get; private set; }

        #endregion

    }
}
