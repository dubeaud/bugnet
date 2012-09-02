using System;
using System.Collections.Generic;
using System.Web;
using BugNET.DAL;
using BugNET.Entities;
using BugNET.Common;
using log4net;

namespace BugNET.BLL
{
    public static class RoleManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Saves the role object
        /// </summary>
        /// <returns><c>true</c> if successful</returns>
        public static bool SaveOrUpdate(Role entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("Cannot save role, the project id is invalid"));
            if (string.IsNullOrEmpty(entity.Name)) throw (new ArgumentException("The role name cannot be empty or null"));

            if (entity.Id > Globals.NEW_ID)
                return DataProviderManager.Provider.UpdateRole(entity);

            var tempId = DataProviderManager.Provider.CreateNewRole(entity);
            if (tempId <= 0) return false;
            entity.Id = tempId;
            return true;
        }

        /// <summary>
        /// Associates the default roles created at installation to a project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        public static void CreateDefaultProjectRoles(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            foreach (var role in Globals.DefaultRoles)
            {
                var r = new Role { ProjectId = projectId, Name = role, Description = role, AutoAssign = false};
                var newRoleId = DataProviderManager.Provider.CreateNewRole(r);

                int[] permissions = null;
                //add permissions to roles
                switch (role)
                {
                    case "Project Administrators":
                        permissions = Globals.AdministratorPermissions;
                        break;
                    case "Read Only":
                        permissions = Globals.ReadOnlyPermissions;
                        break;
                    case "Reporter":
                        permissions = Globals.ReporterPermissions;
                        break;
                    case "Developer":
                        permissions = Globals.DeveloperPermissions;
                        break;
                    case "Quality Assurance":
                        permissions = Globals.QualityAssurancePermissions;
                        break;
                }

                if (permissions != null)
                    foreach (var i in permissions)
                    {
                        AddPermission(newRoleId, i);
                    }
            }
        }

        /// <summary>
        /// Get all roles by project
        /// </summary>
        /// <param name="projectId"></param>
        /// <returns>List of role objects</returns>
        public static List<Role> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetRolesByProject(projectId);
        }

        /// <summary>
        /// Gets the role by id.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public static Role GetById(int roleId)
        {
            if (roleId <= Globals.NEW_ID)
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
            if (!Exists(roleName, projectId))
            {
                var r = new Role {ProjectId = projectId, Name = roleName, Description = description, AutoAssign = autoAssign};
                SaveOrUpdate(r);
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
        public static bool Exists(string roleName, int projectId)
        {
            if (projectId <= 0) throw new ArgumentOutOfRangeException("projectId");
            if (String.IsNullOrEmpty(roleName)) throw new ArgumentOutOfRangeException("roleName");

            return DataProviderManager.Provider.RoleExists(roleName, projectId);
        }

        /// <summary>
        /// Gets the roles for user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Role> GetForUser(string userName, int projectId)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentOutOfRangeException("userName");

            if (!HttpContext.Current.User.Identity.IsAuthenticated)
                return DataProviderManager.Provider.GetRolesByUserName(userName, projectId);

            // performance enhancement
            // WRH 2012-04-06
            // use the current loaded user roles if we are looking at the same user
            return userName.ToLower().Equals(HttpContext.Current.User.Identity.Name.ToLower()) ?
                CurrentUserRoles.FindAll(p => p.ProjectId == projectId) :
                DataProviderManager.Provider.GetRolesByUserName(userName, projectId);
        }

        /// <summary>
        /// Gets the roles for user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static List<Role> GetForUser(string userName)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentOutOfRangeException("userName");

            if (!HttpContext.Current.User.Identity.IsAuthenticated)
                return DataProviderManager.Provider.GetRolesByUserName(userName);

            // performance enhancement
            // WRH 2012-04-06
            // use the current loaded user roles if we are looking at the same user
            return userName.ToLower().Equals(HttpContext.Current.User.Identity.Name.ToLower()) ? 
                CurrentUserRoles : 
                DataProviderManager.Provider.GetRolesByUserName(userName);
        }

        /// <summary>
        /// Gets all roles.
        /// </summary>
        /// <returns></returns>
        public static List<Role> GetAll()
        {
            return DataProviderManager.Provider.GetAllRoles();
        }

        /// <summary>
        /// Adds a user to a role
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        public static void AddUser(string userName, int roleId)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentOutOfRangeException("userName");
            if (roleId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("roleId");

            DataProviderManager.Provider.AddUserToRole(userName, roleId);
            HttpContext.Current.Cache.Remove("RolePermission");
        }

        /// <summary>
        /// Removes a user from a role
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="roleId">The role id.</param>
        public static void RemoveUser(string userName, int roleId)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentOutOfRangeException("userName");
            if (roleId <= 0) throw new ArgumentOutOfRangeException("roleId");

            DataProviderManager.Provider.RemoveUserFromRole(userName, roleId);
            HttpContext.Current.Cache.Remove("RolePermission");
        }

        /// <summary>
        /// Deletes the role.
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns></returns>
        public static bool Delete(int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("roleId");

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
        private static List<RolePermission> GetPermissions()
        {
            var permissions = (List<RolePermission>)HttpContext.Current.Cache["RolePermission"];

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
        public static bool HasPermission(int projectId, string role, string permissionKey)
        {
            //check if the role for a project has permission
            var permission = GetPermissions().Find(
                p => p.ProjectId == projectId && p.RoleName == role && p.PermissionKey == permissionKey);

            return permission != null;
        }

        /// <summary>
        /// Gets all permissions by role
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <returns>List of permission objects</returns>
        public static IEnumerable<BugNET.Entities.Permission> GetPermissionsById(int roleId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("roleId"));

            return DataProviderManager.Provider.GetPermissionsByRoleId(roleId);
        }

        /// <summary>
        /// Deletes a permission object from a role
        /// </summary>
        /// <param name="roleId">The role id.</param>
        /// <param name="permissionId">The permission id.</param>
        /// <returns>[true] if successful</returns>
        public static bool DeletePermission(int roleId, int permissionId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("roleId"));
            if (permissionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("permissionId"));

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
        public static bool AddPermission(int roleId, int permissionId)
        {
            if (roleId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("roleId"));
            if (permissionId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("permissionId"));

            if (DataProviderManager.Provider.AddPermission(roleId, permissionId))
            {
                HttpContext.Current.Cache.Remove("Permission");
                return true;
            }

            return false;
        }

        private const string CURRENT_USER_ROLES = "CURRENT_USER_ROLES";

        /// <summary>
        /// performance enhancement
        /// WRH 2012-04-06
        /// Singleton pattern for the current users roles
        /// We load them the first time and keep them around for the lenght of the request
        /// </summary>
        private static List<Role> CurrentUserRoles
        {
            get 
            { 
                var ctx = HttpContext.Current;
                if (ctx == null) return null;

                var items = ctx.Items[CURRENT_USER_ROLES] as List<Role>;

                if(items == null)
                {
                    var roles = DataProviderManager.Provider.GetRolesByUserName(ctx.User.Identity.Name);
                    CurrentUserRoles = roles;
                    return roles;
                }

                return items;
            }
            set
            {
                var ctx = HttpContext.Current;
                if (ctx == null) return;

                ctx.Items[CURRENT_USER_ROLES] = value;
            }
        }
    }
}
