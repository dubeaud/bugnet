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
using System.Net.Mail;

namespace BugNET.BLL
{
    public static class UserManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

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
        /// Determines if the logged-in user is in the super user role
        /// </summary>
        /// <returns>
        /// <c>true</c> if is in role otherwise, <c>false</c>.
        /// </returns>
        public static bool IsSuperUser()
        {
            return IsSuperUser(HttpContext.Current.User.Identity.Name);
        }

        /// <summary>
        /// Determines if the supplied user is in the super user role
        /// </summary>
        /// <returns>
        /// <c>true</c> if is in role otherwise, <c>false</c>.
        /// </returns>
        public static bool IsSuperUser(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return false;
            }

            var roles = RoleManager.GetForUser(username);
            return roles.Exists(r => r.Name == Globals.SUPER_USER_ROLE);
        }

        /// <summary>
        /// Determines whether [is in role] [the specified role name].
        /// </summary>
        /// <param name="roleName">Name of the role.</param>
        /// <returns>
        /// 	<c>true</c> if [is in role] [the specified role name]; otherwise, <c>false</c>.
        /// </returns>
        [Obsolete("When testing for super user use IsSuperUser() method, otherwise use IsInRole() with project id overload")]
        public static bool IsInRole(string roleName)
        {
            throw new NotImplementedException();
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
            if (String.IsNullOrEmpty(userName)) return false;

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
            if (IsSuperUser(userName)) return true;

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
        /// Gets the size of the profile page.
        /// </summary>
        /// <returns></returns>
        public static int GetProfilePageSize()
        {
            return HttpContext.Current.User.Identity.IsAuthenticated ? 
                WebProfile.Current.IssuesPageSize : 
                10;
        }

        /// <summary>
        /// Gets the users by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<ITUser> GetUsersByProjectId(int projectId)
        {
            return DataProviderManager.Provider.GetUsersByProjectId(projectId, false);
        }

        /// <summary>
        /// Gets the users by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="excludeReadOnlyUsers">if set to <c>true</c> [exclude read only users].</param>
        /// <returns></returns>
        public static List<ITUser> GetUsersByProjectId(int projectId, bool excludeReadOnlyUsers = true)
        {
            return DataProviderManager.Provider.GetUsersByProjectId(projectId, excludeReadOnlyUsers);
        }

        /// <summary>
        /// Sends the user verification notification.
        /// </summary>
        /// <param name="user">The user.</param>
        public static void SendUserVerificationNotification(MembershipUser user)
        {
            if (user == null) throw new ArgumentNullException("user");
            if (user.ProviderUserKey == null) throw new ArgumentNullException("user");

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "UserVerificationSubject";
            var bodyKey = string.Concat("UserVerification", emailFormatKey);
            var profile = new WebProfile().GetProfile(user.UserName);

            var nc = new CultureNotificationContent().LoadContent(profile.PreferredLocale, subjectKey, bodyKey);

            var notificationUser = new NotificationUser
            {
                Id = (Guid)user.ProviderUserKey,
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = profile.DisplayName,
                FirstName = profile.FirstName,
                LastName = profile.LastName,
                IsApproved = user.IsApproved
            };

            var data = new Dictionary<string, object> { { "User", notificationUser } };

            var emailSubject = nc.CultureContents
                .First(p => p.ContentKey == subjectKey)
                .FormatContent();

            var bodyContent = nc.CultureContents
                .First(p => p.ContentKey == bodyKey)
                .TransformContent(data);

            var message = new MailMessage
            {
                Subject = emailSubject,
                Body = bodyContent,
                IsBodyHtml = true
            };

            mailService.Send(user.Email, message, null);
        }

        /// <summary>
        /// Sends the user registered notification.
        /// </summary>
        /// <param name="userName">The user.</param>
        public static void SendUserRegisteredNotification(string userName)
        {
            if (userName == "") throw new ArgumentNullException("userName");

            var user = GetUser(userName);
            if (user.ProviderUserKey == null) throw new ArgumentNullException("userName");

            // TODO - create this via dependency injection at some point.
            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "UserRegisteredSubject";
            var bodyKey = string.Concat("UserRegistered", emailFormatKey);
            var profile = new WebProfile().GetProfile(user.UserName);

            var nc = new CultureNotificationContent().LoadContent(profile.PreferredLocale, subjectKey, bodyKey);

            var notificationUser = new NotificationUser
            {
                Id = (Guid)user.ProviderUserKey,
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = profile.DisplayName,
                FirstName = profile.FirstName,
                LastName = profile.LastName,
                IsApproved = user.IsApproved
            };

            var data = new Dictionary<string, object> { { "User", notificationUser } };

            var emailSubject = nc.CultureContents
                .First(p => p.ContentKey == subjectKey)
                .FormatContent();

            var bodyContent = nc.CultureContents
                .First(p => p.ContentKey == bodyKey)
                .TransformContent(data);

            var message = new MailMessage
            {
                Subject = emailSubject,
                Body = bodyContent,
                IsBodyHtml = true
            };

            mailService.Send(user.Email, message, null);
        }

        /// <summary>
        /// Sends the forgot password email.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="token">The token.</param>
        /// <exception cref="System.ArgumentNullException">
        /// user
        /// or
        /// user
        /// </exception>
        public static void SendForgotPasswordEmail(MembershipUser user, string token)
        {
            if (user == null) throw new ArgumentNullException("user");
            if (user.ProviderUserKey == null) throw new ArgumentNullException("user");

            IMailDeliveryService mailService = new SmtpMailDeliveryService();

            var emailFormatType = HostSettingManager.Get(HostSettingNames.SMTPEMailFormat, EmailFormatType.Text);
            var emailFormatKey = (emailFormatType == EmailFormatType.Text) ? "" : "HTML";
            const string subjectKey = "ForgotPasswordSubject";
            var bodyKey = string.Concat("ForgotPassword", emailFormatKey);
            var profile = new WebProfile().GetProfile(user.UserName);

            var nc = new CultureNotificationContent().LoadContent(profile.PreferredLocale, subjectKey, bodyKey);

            var notificationUser = new NotificationUser
            {
                Id = (Guid)user.ProviderUserKey,
                CreationDate = user.CreationDate,
                Email = user.Email,
                UserName = user.UserName,
                DisplayName = profile.DisplayName,
                FirstName = profile.FirstName,
                LastName = profile.LastName,
                IsApproved = user.IsApproved
            };

            var data = new Dictionary<string, object>
                {
                    {"Token", token}
                };

            var emailSubject = nc.CultureContents
                .First(p => p.ContentKey == subjectKey)
                .FormatContent();

            var bodyContent = nc.CultureContents
                .First(p => p.ContentKey == bodyKey)
                .TransformContent(data);

            var message = new MailMessage
            {
                Subject = emailSubject,
                Body = bodyContent,
                IsBodyHtml = true
            };

            mailService.Send(user.Email, message, null);
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

        /// <summary>
        /// Gets the user  by password reset token.
        /// </summary>
        /// <param name="token">The token.</param>
        /// <returns></returns>
        public static MembershipUser GetUserByPasswordResetToken(string token)
        {
            var username = DataProviderManager.Provider.GetUserNameByPasswordResetToken(token);
            return string.IsNullOrWhiteSpace(username) ? null : Membership.GetUser(username);
        }
    }
}