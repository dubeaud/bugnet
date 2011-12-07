using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using BugNET.BLL.Notifications;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using BugNET.Providers.MembershipProviders;
using log4net;

namespace BugNET.BLL
{
    public static class UserManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Static Methods

        /// <summary>
        /// Creates a new user.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <param name="email"></param>
        public static void CreateUser(string userName, string password, string email)
        {
            Membership.CreateUser(userName, password, email);
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
            if (userProviderKey == null) throw (new ArgumentOutOfRangeException("userProviderKey"));
            return Membership.GetUser(userProviderKey);
        }

        /// <summary>
        /// Gets the user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static MembershipUser GetUser(string userName)
        {
            if (String.IsNullOrEmpty(userName)) throw (new ArgumentOutOfRangeException("userName"));
            return Membership.GetUser(userName);
        }

        /// <summary>
        /// Gets all users in the application
        /// </summary>
        /// <returns>Collection of membership users</returns>
        public static List<CustomMembershipUser> GetAllUsers()
        {
            return Membership.GetAllUsers().Cast<CustomMembershipUser>().ToList();
        }

        /// <summary>
        /// Gets all users.
        /// </summary>
        /// <returns>Authorized Users Only</returns>
        public static List<CustomMembershipUser> GetAllAuthorizedUsers()
        {
            var users = GetAllUsers();
            var authenticatedUsers = users.Where(user => user.IsApproved).ToList();
            users = authenticatedUsers;
            return users;
        }

        /// <summary>
        /// Finds users by name
        /// </summary>
        /// <param name="userNameToMatch">The user name to match.</param>
        /// <returns></returns>
        public static List<CustomMembershipUser> FindUsersByName(string userNameToMatch)
        {
            var userList = new Dictionary<string, CustomMembershipUser>();

            // find standard usernames
            foreach (CustomMembershipUser u in Membership.FindUsersByName(userNameToMatch))
                userList[u.UserName] = u;

            // find windows user names [domain\username] pattern
            foreach (CustomMembershipUser u in Membership.FindUsersByName(string.Concat("%\\", userNameToMatch)))
                userList[u.UserName] = u;

            // find open id user names [http://username] pattern
            foreach (CustomMembershipUser u in Membership.FindUsersByName(string.Concat("%//", userNameToMatch)))
                userList[u.UserName] = u;

            // wrhighfield
            // removed 2011-11-26 due to the aggressive removing of the usernames, the patterns above will return some
            // false matches when it dealing with openid and windows user names, however it does seem to work a bit better
            // than the code below...

            //var sb = new StringBuilder();
            //foreach (var c in userNameToMatch)
            //{
            //    switch (c)
            //    {
            //        case '_':
            //            sb.Append("?");
            //            break;
            //        case '%':
            //            sb.Append(".*");
            //            break;
            //        case '[':
            //        case '{':
            //        case '\\':
            //        case '|':
            //        case '>':
            //        case '^':
            //        case '$':
            //        case '(':
            //        case ')':
            //        case '<':
            //        case '.':
            //        case '*':
            //        case '+':
            //        case '?':
            //            sb.Append('\\');
            //            sb.Append(c);
            //            break;
            //        default:
            //            sb.Append(c);
            //            break;
            //    }
            //}

            //var regex = new Regex(sb.ToString());
            //var invalidUsernames = new List<string>();
            //foreach (var u in userList.Values)
            //{
            //    var username = u.UserName;
            //    var pos = username.IndexOf('\\');
            //    if ((pos >= 0) && (username.Length > pos))
            //    {
            //        username = username.Substring(pos + 1);
            //    }
            //    if (!regex.IsMatch(username))
            //    {
            //        invalidUsernames.Add(username);
            //    }
            //}

            //foreach (var invalidUsername in invalidUsernames)
            //{
            //    userList.Remove(invalidUsername);
            //}

            return new List<CustomMembershipUser>(userList.Values);
        }

        /// <summary>
        /// Finds the users by email.
        /// </summary>
        /// <param name="emailToMatch">The email to match.</param>
        /// <returns></returns>
        public static List<CustomMembershipUser> FindUsersByEmail(string emailToMatch)
        {
            return Membership.FindUsersByEmail(emailToMatch).Cast<CustomMembershipUser>().ToList();
        }

        /// <summary>
        /// Updates the user.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void UpdateUser(MembershipUser user)
        {
            if (user == null) throw new ArgumentNullException("user");

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
            if (projectId <= Globals.NEW_ID) throw new ArgumentOutOfRangeException("projectId");
            if (String.IsNullOrEmpty(roleName)) throw new ArgumentNullException("roleName");

            return IsInRole(HttpContext.Current.User.Identity.Name, projectId, roleName);
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
            if (String.IsNullOrEmpty(roleName)) throw new ArgumentNullException("roleName");
            if (HttpContext.Current.User.Identity.Name.Length == 0) return false;

            var roles = RoleManager.GetForUser(HttpContext.Current.User.Identity.Name);
            return roles.Exists(r => r.Name == roleName);
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
            if (String.IsNullOrEmpty(roleName)) throw new ArgumentNullException("roleName");
            if (String.IsNullOrEmpty(userName)) throw new ArgumentNullException("userName");
            //if (projectId <= Globals.NEW_ID) throw new ArgumentNullException("projectId");

            var roles = RoleManager.GetForUser(userName, projectId);

            var role = roles.Find(r => r.Name == roleName);
            return role != null;
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
            if (string.IsNullOrEmpty(permissionKey)) throw new ArgumentNullException("permissionKey");

            return HasPermission(Security.GetUserName(), projectId, permissionKey);
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
            if (string.IsNullOrEmpty(userName)) return false;
            if (string.IsNullOrEmpty(permissionKey)) throw new ArgumentNullException("permissionKey");
            //if (projectId <= Globals.NEW_ID) throw new ArgumentNullException("projectId");

            //return true for all permission checks if the user is in the super users role.
            if (IsInRole(Globals.SUPER_USER_ROLE)) return true;

            var roles = RoleManager.GetForUser(userName, projectId);

            return roles.Any(r => RoleManager.HasPermission(projectId, r.Name, permissionKey));
        }

        /// <summary>
        /// Gets the display name of the user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <returns></returns>
        public static string GetUserDisplayName(string userName)
        {
            if (string.IsNullOrEmpty(userName)) throw new ArgumentNullException("userName");

            var displayName = new WebProfile().GetProfile(userName).DisplayName;
            return !string.IsNullOrEmpty(displayName) ? displayName : userName;
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
        /// <param name="user"></param>
        /// <param name="passwordAnswer"></param>
        /// <returns></returns>
        public static void SendUserPasswordReminderNotification(MembershipUser user, string passwordAnswer)
        {
            if (user == null) throw new ArgumentNullException("user");

            //TODO: Move this to xslt notification
            //load template and replace the tokens
            var template = NotificationManager.Instance.LoadNotificationTemplate("PasswordReminder");
            var subject = NotificationManager.Instance.LoadNotificationTemplate("PasswordReminderSubject");
            var displayname = GetUserDisplayName(user.UserName);

            var context = new NotificationContext
                              {
                                  BodyText = String.Format(template, HostSettingManager.Get(HostSettingNames.ApplicationTitle),user.GetPassword()),
                                  EmailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text), 
                                  Subject = subject, 
                                  UserDisplayName = displayname, 
                                  Username = user.UserName
                              };

            NotificationManager.Instance.SendNotification(context);
        }

        /// <summary>
        /// Sends the user verification notification.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void SendUserVerificationNotification(MembershipUser user)
        {
            if (user == null) throw new ArgumentNullException("user");

            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template and replace the tokens
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("UserVerification", emailFormatType);
            var subject = NotificationManager.Instance.LoadNotificationTemplate("UserVerification");

            var data = new Dictionary<string, object>();

            if (user.ProviderUserKey != null)
            {
                var u = new ITUser
                            {
                        Id = (Guid)user.ProviderUserKey,
                        CreationDate = user.CreationDate,
                        Email = user.Email,
                        UserName = user.UserName,
                        DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                        IsApproved = user.IsApproved
                    };

                data.Add("User", u);
            }
            template = NotificationManager.GenerateNotificationContent(template, data);

            var context = new NotificationContext
            {
                BodyText = template,
                EmailFormatType = emailFormatType,
                Subject = subject,
                UserDisplayName = GetUserDisplayName(user.UserName),
                Username = user.UserName
            };

            NotificationManager.Instance.SendNotification(context);
        }

        /// <summary>
        /// Sends the user new password notification.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="newPassword">The new password.</param>
        public static void SendUserNewPasswordNotification(MembershipUser user, string newPassword)
        {
            if (user == null) throw new ArgumentNullException("user");
            if (string.IsNullOrEmpty(newPassword)) throw new ArgumentNullException("newPassword");

            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template and replace the tokens
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("PasswordReset", emailFormatType);
            var subject = NotificationManager.Instance.LoadNotificationTemplate("PasswordResetSubject");
            var data = new Dictionary<string, object>();

            var u = new ITUser
                {
                    CreationDate = user.CreationDate,
                    Email = user.Email,
                    UserName = user.UserName,
                    DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                    IsApproved = user.IsApproved
                };

            data.Add("User", u);
            data.Add("RawXml_Password", string.Format("<Password>{0}</Password>", newPassword));
            template = NotificationManager.GenerateNotificationContent(template, data);

            var context = new NotificationContext
            {
                BodyText = template,
                EmailFormatType = emailFormatType,
                Subject = subject,
                UserDisplayName = UserManager.GetUserDisplayName(user.UserName),
                Username = user.UserName
            };

            NotificationManager.Instance.SendNotification(context);
        }

        /// <summary>
        /// Sends the user registered notification.
        /// </summary>
        /// <param name="userName">The user.</param>
        public static void SendUserRegisteredNotification(string userName)
        {
            if (userName == "") throw new ArgumentNullException("userName");

            var user = GetUser(userName);
            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);

            //load template and replace the tokens
            var template = NotificationManager.Instance.LoadEmailNotificationTemplate("UserRegistered", emailFormatType);
            var subject = NotificationManager.Instance.LoadNotificationTemplate("UserRegisteredSubject");
            var data = new Dictionary<string, object>();

            var u = new ITUser
                {
                    CreationDate = user.CreationDate,
                    Email = user.Email,
                    UserName = user.UserName,
                    DisplayName = new WebProfile().GetProfile(user.UserName).DisplayName,
                    IsApproved = user.IsApproved
                };

            data.Add("User", u);
            template = NotificationManager.GenerateNotificationContent(template, data);

            //all admin notifications sent to admin user defined in host settings, 
            var adminNotificationUsername = HostSettingManager.Get(HostSettingNames.AdminNotificationUsername);

            var context = new NotificationContext
            {
                BodyText = template,
                EmailFormatType = emailFormatType,
                Subject = subject,
                UserDisplayName = GetUserDisplayName(adminNotificationUsername),
                Username = adminNotificationUsername
            };

            NotificationManager.Instance.SendNotification(context);
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
            if (string.IsNullOrEmpty(username)) throw new ArgumentNullException("username");
            if (string.IsNullOrEmpty(notificationType)) throw new ArgumentNullException("notificationType");

            var profile = new WebProfile().GetProfile(username);

            if (profile != null)
            {
                var notificationTypes = profile.NotificationTypes.Split(';');
                return notificationTypes.Any(s => s.Equals(notificationType));
            }
            return false;
        }

        /// <summary>
        /// Gets the name of the selected issue columns by user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static string GetSelectedIssueColumnsByUserName(string userName, int projectId)
        {
            if (userName == "") throw new ArgumentNullException("userName");

            return  DataProviderManager.Provider.GetSelectedIssueColumnsByUserName(userName, projectId);

        }

        /// <summary>
        /// Sets the name of the selected issue columns by user.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="columns">The columns.</param>
        public static void SetSelectedIssueColumnsByUserName(string userName,int projectId, string columns)
        {
            if (userName == "") throw new ArgumentNullException("userName");

            DataProviderManager.Provider.SetSelectedIssueColumnsByUserName(userName, projectId, columns);
        }
        #endregion
    }
}