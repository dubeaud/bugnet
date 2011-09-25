using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using BugNET.BLL.Notifications;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using BugNET.Providers.MembershipProviders;

namespace BugNET.BLL
{
    public class UserManager
    {

        #region Static Methods

        /// <summary>
        /// Creates a new user.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <param name="email"></param>
        public static void CreateUser(string userName, string password, string email)
        {
            MembershipUser user = Membership.CreateUser(userName, password, email);
        }

        /// <summary>
        /// Provides a BugNET way of checking if the user's credentials are
        /// correct.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public static bool ValidateUser(string userName, string password)
        {
            return Membership.ValidateUser(userName, password);
        }

        /// <summary>
        /// Gets the user.
        /// </summary>
        /// <param name="userProviderKey">The user provider key.</param>
        /// <returns></returns>
        public static MembershipUser GetUser(object userProviderKey)
        {
            if (userProviderKey == null)
                throw (new ArgumentOutOfRangeException("userProviderKey"));
            return Membership.GetUser(userProviderKey);
        }

        /// <summary>
        /// Gets the user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static MembershipUser GetUser(string userName)
        {
            if (String.IsNullOrEmpty(userName))
                throw (new ArgumentOutOfRangeException("userName"));


            return Membership.GetUser(userName);
        }

        /// <summary>
        /// Gets all users in the application
        /// </summary>
        /// <returns>Collection of membership users</returns>
        public static List<CustomMembershipUser> GetAllUsers()
        {
            //return Membership.GetAllUsers();

            List<CustomMembershipUser> userList = new List<CustomMembershipUser>();
            foreach (CustomMembershipUser u in Membership.GetAllUsers())
            {
                userList.Add(u);
            }
            return userList;
        }

        /// <summary>
        /// Gets all users.
        /// </summary>
        /// <returns>Authorized Users Only</returns>
        public static List<CustomMembershipUser> GetAllAuthorizedUsers()
        {
            List<CustomMembershipUser> users = UserManager.GetAllUsers();
            List<CustomMembershipUser> AuthenticatedUsers = new List<CustomMembershipUser>();
            foreach (CustomMembershipUser user in users)
            {
                if (user.IsApproved)
                    AuthenticatedUsers.Add(user);
            }
            users = AuthenticatedUsers;
            return users;
        }

        /// <summary>
        /// Finds users by name
        /// </summary>
        /// <param name="userNameToMatch">The user name to match.</param>
        /// <returns></returns>
        public static List<CustomMembershipUser> FindUsersByName(string userNameToMatch)
        {
            Dictionary<string, CustomMembershipUser> userList = new Dictionary<string, CustomMembershipUser>();
            foreach (CustomMembershipUser u in Membership.FindUsersByName(userNameToMatch))
            {
                userList[u.UserName] = u;
            }

            foreach (CustomMembershipUser u in Membership.FindUsersByName("%\\" + userNameToMatch))
            {
                userList[u.UserName] = u;
            }

            StringBuilder sb = new StringBuilder();
            foreach (var c in userNameToMatch)
            {
                switch (c)
                {
                    case '_':
                        sb.Append("?");
                        break;
                    case '%':
                        sb.Append(".*");
                        break;
                    case '[':
                    case '{':
                    case '\\':
                    case '|':
                    case '>':
                    case '^':
                    case '$':
                    case '(':
                    case ')':
                    case '<':
                    case '.':
                    case '*':
                    case '+':
                    case '?':
                        sb.Append('\\');
                        sb.Append(c);
                        break;
                    default:
                        sb.Append(c);
                        break;
                }
            }

            Regex regex = new Regex(sb.ToString());
            List<string> invalidUsernames = new List<string>();
            foreach (var u in userList.Values)
            {
                string username = u.UserName;
                int pos = username.IndexOf('\\');
                if ((pos >= 0) && (username.Length > pos))
                {
                    username = username.Substring(pos + 1);
                }
                if (!regex.IsMatch(username))
                {
                    invalidUsernames.Add(username);
                }
            }

            foreach (var invalidUsername in invalidUsernames)
            {
                userList.Remove(invalidUsername);
            }

            return new List<CustomMembershipUser>(userList.Values);
        }

        /// <summary>
        /// Finds the users by email.
        /// </summary>
        /// <param name="emailToMatch">The email to match.</param>
        /// <returns></returns>
        public static List<CustomMembershipUser> FindUsersByEmail(string emailToMatch)
        {
            List<CustomMembershipUser> userList = new List<CustomMembershipUser>();
            foreach (CustomMembershipUser u in Membership.FindUsersByEmail(emailToMatch))
            {
                userList.Add(u);
            }
            return userList;
        }
        /// <summary>
        /// Updates the user.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void UpdateUser(MembershipUser user)
        {
            if (user == null)
                throw new ArgumentNullException("user");

            Membership.UpdateUser(user);
        }

        /// <summary>
        /// Determines whether [is in role] [the specified project id].
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="roleName">Name of the role.</param>
        /// <returns>
        /// 	<c>true</c> if [is in role] [the specified project id]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsInRole(int projectId, string roleName)
        {
            if (projectId <= Globals.NewId)
                throw new ArgumentOutOfRangeException("projectId");
            if (String.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("roleName");

            return UserManager.IsInRole(HttpContext.Current.User.Identity.Name, projectId, roleName);
        }

        /// <summary>
        /// Determines whether [is in role] [the specified role name].
        /// </summary>
        /// <param name="roleName">Name of the role.</param>
        /// <returns>
        /// 	<c>true</c> if [is in role] [the specified role name]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsInRole(string roleName)
        {
            if (String.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("roleName");
            if (HttpContext.Current.User.Identity.Name.Length == 0)
                return false;

            List<Role> roles = RoleManager.GetRolesForUser(HttpContext.Current.User.Identity.Name);
            return roles.Exists(delegate(Role r) { return r.Name == roleName; });
        }

        /// <summary>
        /// Determines whether [is in role] [the specified user name].
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="roleName">Name of the role.</param>
        /// <returns>
        /// 	<c>true</c> if [is in role] [the specified user name]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsInRole(string userName, int projectId, string roleName)
        {
            if (String.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("roleName");
            if (String.IsNullOrEmpty(userName))
                throw new ArgumentNullException("userName");

            List<Role> roles = RoleManager.GetRolesForUser(userName, projectId);

            Role role = roles.Find(delegate(Role r) { return r.Name == roleName; });
            if (role != null)
                return true;

            return false;
        }

        /// <summary>
        /// Determines whether the specified logged on user has permission.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="permissionKey">The permission key.</param>
        /// <returns>
        /// 	<c>true</c> if the specified project id has permission; otherwise, <c>false</c>.
        /// </returns>
        public static bool HasPermission(int projectId, string permissionKey)
        {
            if (string.IsNullOrEmpty(permissionKey))
                throw new ArgumentNullException("permissionKey");

            return UserManager.HasPermission(Security.GetUserName(), projectId, permissionKey);

        }

        /// <summary>
        /// Determines whether the specified user name has permission.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="permissionKey">The permission key.</param>
        /// <returns>
        /// 	<c>true</c> if the specified user name has permission; otherwise, <c>false</c>.
        /// </returns>
        public static bool HasPermission(string userName, int projectId, string permissionKey)
        {
            if (string.IsNullOrEmpty(userName))
                return false;
            if (string.IsNullOrEmpty(permissionKey))
                throw new ArgumentNullException("permissionKey");

            //return true for all permission checks if the user is in the super users role.
            if (UserManager.IsInRole(Globals.SuperUserRole))
                return true;

            List<Role> roles = RoleManager.GetRolesForUser(userName, projectId);

            foreach (Role r in roles)
            {
                if (RoleManager.RoleHasPermission(projectId, r.Name, permissionKey))
                    return true;
            }

            return false;
        }

        /// <summary>
        /// Gets the display name of the user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static string GetUserDisplayName(string userName)
        {
            if (string.IsNullOrEmpty(userName))
                throw new ArgumentNullException("userName");

            string DisplayName = new WebProfile().GetProfile(userName).DisplayName;
            if (!string.IsNullOrEmpty(DisplayName))
            {
                return DisplayName;
            }
            else
            {
                return userName;
            }
        }

        /// <summary>
        /// Gets the users by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<ITUser> GetUsersByProjectId(int projectId)
        {
            return DataProviderManager.Provider.GetUsersByProjectId(projectId);
        }

        /// <summary>
        /// Sends the user password reminder.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static void SendUserPasswordReminderNotification(MembershipUser user, string passwordAnswer)
        {
            if (user == null)
                throw new ArgumentNullException("user");

            //TODO: Move this to xslt notification
            //load template and replace the tokens
            string template = NotificationManager.Instance.LoadNotificationTemplate("PasswordReminder");
            string subject = NotificationManager.Instance.LoadNotificationTemplate("PasswordReminderSubject");
            string displayname = UserManager.GetUserDisplayName(user.UserName);

            NotificationManager.Instance.SendNotification(user.UserName, subject, String.Format(template, HostSettingManager.GetHostSetting("ApplicationTitle"), user.GetPassword(passwordAnswer)));

        }

        /// <summary>
        /// Sends the user verification notification.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void SendUserVerificationNotification(MembershipUser user)
        {
            if (user == null)
                throw new ArgumentNullException("user");

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);

            //load template and replace the tokens
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("UserVerification", type);
            string subject = NotificationManager.Instance.LoadNotificationTemplate("UserVerification");
            string displayname = UserManager.GetUserDisplayName(user.UserName);

            Dictionary<string, object> data = new Dictionary<string, object>();

            ITUser u = new ITUser()
            {
                Id = (Guid)user.ProviderUserKey,
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                IsApproved = user.IsApproved
            };

            data.Add("User", u);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);
            NotificationManager.Instance.SendNotification(user.UserName, subject, template);

        }

        /// <summary>
        /// Sends the user new password notification.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="newPassword">The new password.</param>
        public static void SendUserNewPasswordNotification(MembershipUser user, string newPassword)
        {
            if (user == null)
                throw new ArgumentNullException("user");

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);

            //load template and replace the tokens
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("PasswordReset", type);
            string subject = NotificationManager.Instance.LoadNotificationTemplate("PasswordResetSubject");
            string displayname = UserManager.GetUserDisplayName(user.UserName);
            Dictionary<string, object> data = new Dictionary<string, object>();

            ITUser u = new ITUser()
            {
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                IsApproved = user.IsApproved
            };

            data.Add("User", u);
            data.Add("Password", newPassword);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);
            NotificationManager.Instance.SendNotification(user.UserName, subject, template);

        }

        /// <summary>
        /// Sends the user registered notification.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void SendUserRegisteredNotification(string userName)
        {
            if (userName == "")
                throw new ArgumentNullException("user");

            EmailFormatType type = (EmailFormatType)HostSettingManager.GetHostSetting("SMTPEMailFormat", (int)EmailFormatType.Text);
            MembershipUser user = UserManager.GetUser(userName);
            WebProfile profile = new WebProfile().GetProfile(user.UserName);


            //load template and replace the tokens
            string template = NotificationManager.Instance.LoadEmailNotificationTemplate("UserRegistered", type);
            string subject = NotificationManager.Instance.LoadNotificationTemplate("UserRegisteredSubject");
            Dictionary<string, object> data = new Dictionary<string, object>();

            ITUser u = new ITUser()
            {
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                IsApproved = user.IsApproved
            };

            data.Add("User", u);
            template = NotificationManager.Instance.GenerateNotificationContent(template, data);

            //all admin notifications sent to admin user defined in host settings, 
            string AdminNotificationUsername = HostSettingManager.GetHostSetting("AdminNotificationUsername");

            NotificationManager.Instance.SendNotification(AdminNotificationUsername, subject, template);
        }

        /// <summary>
        /// Determines whether [is notification type enabled] [the specified username].
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="notificationType">Type of the notification.</param>
        /// <returns>
        /// 	<c>true</c> if [is notification type enabled] [the specified username]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsNotificationTypeEnabled(string username, string notificationType)
        {
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException("username");
            if (string.IsNullOrEmpty(notificationType))
                throw new ArgumentNullException("notificationType");

            WebProfile profile = new WebProfile().GetProfile(username);

            if (profile != null)
            {
                string[] notificationTypes = profile.NotificationTypes.Split(';');
                foreach (string s in notificationTypes)
                {
                    if (s.Equals(notificationType))
                        return true;
                }
            }
            return false;
        }
        #endregion

    }
}
