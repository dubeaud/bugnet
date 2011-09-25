using System;
using System.Collections.Generic;
using System.Web;
using BugNET.DAL;
using BugNET.Entities;
using BugNET.Common;

namespace BugNET.BLL
{
    public class RoleManager
    {
        #region Instance Methods
        /// <summary>
        /// Saves the role object
        /// </summary>
        /// <returns><c>true</c> if successful</returns>
        public static bool SaveRole(Role roleToSave)
        {
            if (roleToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewRole(roleToSave);
                if (TempId > 0)
                {
                    roleToSave.Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return DataProviderManager.Provider.UpdateRole(roleToSave);
            }
        }

        #endregion

        #region Static Methods
        /// <summary>
        /// Associates the default roles created at installation to a project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        public static void CreateDefaultProjectRoles(int projectId)
        {
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("projectId"));

            foreach (string role in Globals.DefaultRoles)
            {
                Role r = new Role(projectId, role, role, false);
                int NewRoleId = DataProviderManager.Provider.CreateNewRole(r);

                int[] Permissions = null;
                //add permissions to roles
                switch (role)
                {
                    case "Project Administrators":
                        Permissions = Globals.AdministratorPermissions;
                        break;
                    case "Read Only":
                        Permissions = Globals.ReadOnlyPermissions;
                        break;
                    case "Reporter":
                        Permissions = Globals.ReporterPermissions;
                        break;
                    case "Developer":
                        Permissions = Globals.DeveloperPermissions;
                        break;
                    case "Quality Assurance":
                        Permissions = Globals.QualityAssurancePermissions;
                        break;
                }

                foreach (int i in Permissions)
                {
                    RoleManager.AddRolePermission(NewRoleId, i);
                }
            }
        }

        /// <summary>
        /// Get all roles by project
        /// </summary>
        /// <param name="projectId"></param>
        /// <returns>List of role objects</returns>
        public static List<Role> GetRolesByProject(int projectId)
        {
            if (projectId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetRolesByProject(projectId);
        }

        /// <summary>
        /// Gets the role by id.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public static Role GetRoleById(int roleId)
        {
            if (roleId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("roleId"));

            return DataProviderManager.Provider.GetRoleById(roleId);
        }

        /// <summary>
        /// Creates the role.
        /// </summary>
        /// <param name="roleName">Name of the role.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="description">The description.</param>
        /// <param name="autoAssign">if set to <c>true</c> [auto assign].</param>
        /// <returns></returns>
        public static int CreateRole(string roleName, int projectId, string description, bool autoAssign)
        {
            if (!RoleManager.RoleExists(roleName, projectId))
            {
                Role r = new Role(projectId, roleName, description, autoAssign);
                RoleManager.SaveRole(r);
                return r.Id;
            }

            return 0;
        }

        /// <summary>
        /// Roles the exists.
        /// </summary>
        /// <param name="roleName">Name of the role.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static bool RoleExists(string roleName, int projectId)
        {
            if (projectId <= 0)
                throw new ArgumentOutOfRangeException("projectId");
            if (String.IsNullOrEmpty(roleName))
                throw new ArgumentOutOfRangeException("roleName");

            return DataProviderManager.Provider.RoleExists(roleName, projectId);
        }

        /// <summary>
        /// Gets the roles for user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Role> GetRolesForUser(string userName, int projectId)
        {
            if (String.IsNullOrEmpty(userName))
                throw new ArgumentOutOfRangeException("userName");

            return DataProviderManager.Provider.GetRolesByUserName(userName, projectId);
        }

        /// <summary>
        /// Gets the roles for user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static List<Role> GetRolesForUser(string userName)
        {
            if (String.IsNullOrEmpty(userName))
                throw new ArgumentOutOfRangeException("userName");

            return DataProviderManager.Provider.GetRolesByUserName(userName);
        }


        /// <summary>
        /// Gets all roles.
        /// </summary>
        /// <returns></returns>
        public static List<Role> GetAllRoles()
        {
            return DataProviderManager.Provider.GetAllRoles();
        }

        /// <summary>
        /// Adds a user to a role
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        public static void AddUserToRole(string userName, int roleId)
        {
            if (String.IsNullOrEmpty(userName))
                throw new ArgumentOutOfRangeException("userName");
            if (roleId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("roleId");

            DataProviderManager.Provider.AddUserToRole(userName, roleId);
            HttpContext.Current.Cache.Remove("RolePermission");
        }

        /// <summary>
        /// Removes a user from a role
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        public static void RemoveUserFromRole(string userName, int roleId)
        {
            if (String.IsNullOrEmpty(userName))
                throw new ArgumentOutOfRangeException("userName");
            if (roleId <= 0)
                throw new ArgumentOutOfRangeException("roleId");

            DataProviderManager.Provider.RemoveUserFromRole(userName, roleId);
            HttpContext.Current.Cache.Remove("RolePermission");
        }

        /// <summary>
        /// Deletes the role.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public static bool DeleteRole(int roleId)
        {
            if (roleId <= 0)
                throw new ArgumentOutOfRangeException("roleId");

            if (DataProviderManager.Provider.DeleteRole(roleId))
            {
                HttpContext.Current.Cache.Remove("RolePermission");
                return true;
            }

            return false;
        }

        /// <summary>
        /// Retreives the Role Permissions DataView from the cache if exists, otherwise loads 
        /// it into the cache
        /// </summary>
        /// <returns>Role Permissions DataView</returns>
        public static List<RolePermission> GetRolePermissions()
        {
            List<RolePermission> permissions;
            permissions = (List<RolePermission>)HttpContext.Current.Cache["RolePermission"];
            if (permissions == null)
            {
                permissions = DataProviderManager.Provider.GetRolePermissions();
                HttpContext.Current.Cache.Insert("RolePermission", permissions);
            }
            return permissions;

        }

        /// <summary>
        /// Checks the Role Permission DataView if a permission row exists
        /// </summary>
        /// <param name="projectId"></param>
        /// <param name="role"></param>
        /// <param name="permissionKey"></param>
        /// <returns>[true] if row exists</returns>
        public static bool RoleHasPermission(int projectId, string role, string permissionKey)
        {
            //check if the role for a project has permission
            RolePermission permission = RoleManager.GetRolePermissions().Find(delegate(RolePermission p) { return p.ProjectId == projectId && p.RoleName == role && p.PermissionKey == permissionKey; });
            if (permission != null)
                return true;

            return false;
        }

        /// <summary>
        /// Gets all permissions by role
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns>List of permission objects</returns>
        public static List<Permission> GetPermissionsByRoleId(int roleId)
        {
            if (roleId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("roleId"));

            return DataProviderManager.Provider.GetPermissionsByRoleId(roleId);
        }

        /// <summary>
        /// Deletes a permission object from a role
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <param name="permissionId">The permission id.</param>
        /// <returns>[true] if successful</returns>
        public static bool DeleteRolePermission(int roleId, int permissionId)
        {
            if (roleId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("roleId"));
            if (permissionId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("permissionId"));

            if (DataProviderManager.Provider.DeletePermission(roleId, permissionId))
            {
                HttpContext.Current.Cache.Remove("Permission");
                return true;
            }
            return false;
        }

        /// <summary>
        /// Adds a permission object to a role
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <param name="permissionId">The permission id.</param>
        /// <returns>[true] if successful</returns>
        public static bool AddRolePermission(int roleId, int permissionId)
        {
            if (roleId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("roleId"));
            if (permissionId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("permissionId"));

            if (DataProviderManager.Provider.AddPermission(roleId, permissionId))
            {
                HttpContext.Current.Cache.Remove("Permission");
                return true;
            }

            return false;
        }
        #endregion
    }
}
