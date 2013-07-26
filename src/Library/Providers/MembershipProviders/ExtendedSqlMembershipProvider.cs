using System;
using System.Web.Profile;
using System.Web.Providers;
using System.Web.Security;

namespace BugNET.Providers.MembershipProviders
{
    /// <summary>
    /// Extended membership provider
    /// </summary>
    public class ExtendedSqlMembershipProvider : DefaultMembershipProvider
    {
        /// <summary>
        /// Adds a new user to the SQL Server membership database.
        /// </summary>
        /// <param name="username">The user name for the new user.</param>
        /// <param name="password">The password for the new user.</param>
        /// <param name="email">The e-mail address for the new user.</param>
        /// <param name="passwordQuestion">The password question for the new user.</param>
        /// <param name="passwordAnswer">The password answer for the new user.</param>
        /// <param name="isApproved">Whether or not the new user is approved to be validated.</param>
        /// <param name="providerUserKey">A <see cref="T:System.Guid"></see> that uniquely identifies the membership user in the SQL Server database.</param>
        /// <param name="status">One of the <see cref="T:System.Web.Security.MembershipCreateStatus"></see> values, indicating whether the user was created successfully.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUser"></see> object for the newly created user. If no user was created, this method returns null.
        /// </returns>
        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            MembershipUser oldUser = base.CreateUser(username, password, email, passwordQuestion, passwordAnswer, isApproved, providerUserKey, out status);
            if (status == MembershipCreateStatus.Success)
            {
                ProfileBase profile = ProfileBase.Create(oldUser.UserName);
                string firstName = (string)profile.GetPropertyValue("FirstName");
                string lastName = (string)profile.GetPropertyValue("LastName");
                string displayName = (string)profile.GetPropertyValue("DisplayName");

                CustomMembershipUser newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                                        oldUser.UserName,
                                                                        oldUser.ProviderUserKey,
                                                                        oldUser.Email,
                                                                        oldUser.PasswordQuestion,
                                                                        oldUser.Comment,
                                                                        oldUser.IsApproved,
                                                                        oldUser.IsLockedOut,
                                                                        oldUser.CreationDate,
                                                                        oldUser.LastLoginDate,
                                                                        oldUser.LastActivityDate,
                                                                        oldUser.LastPasswordChangedDate,
                                                                        oldUser.LastLockoutDate,
                                                                        displayName,
                                                                        firstName,
                                                                        lastName);

                return newUser;
            }
            return null;
        }
       

        /// <summary>
        /// Returns information from the SQL Server membership database for a user and provides an option to update the last activity date/time stamp for the user.
        /// </summary>
        /// <param name="username">The name of the user to get information for.</param>
        /// <param name="userIsOnline">true to update the last activity date/time stamp for the user; false to return user information without updating the last activity date/time stamp for the user.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUser"></see> object representing the specified user. If no user is found in the database for the specified username value, null is returned.
        /// </returns>
        /// <exception cref="T:System.ArgumentException">username exceeds 256 characters.- or -username contains a comma.</exception>
        /// <exception cref="T:System.ArgumentNullException">username is null.</exception>
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            MembershipUser oldUser = base.GetUser(username, userIsOnline);
            ProfileBase profile = ProfileBase.Create(username);
            string firstName = (string)profile.GetPropertyValue("FirstName");
            string lastName = (string)profile.GetPropertyValue("LastName");
            string displayName = (string)profile.GetPropertyValue("DisplayName");

            if (oldUser == null)
                return null;

            CustomMembershipUser newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                                    oldUser.UserName,
                                                                    oldUser.ProviderUserKey,
                                                                    oldUser.Email,
                                                                    oldUser.PasswordQuestion,
                                                                    oldUser.Comment,
                                                                    oldUser.IsApproved,
                                                                    oldUser.IsLockedOut,
                                                                    oldUser.CreationDate,
                                                                    oldUser.LastLoginDate,
                                                                    oldUser.LastActivityDate,
                                                                    oldUser.LastPasswordChangedDate,
                                                                    oldUser.LastLockoutDate,
                                                                    displayName,
                                                                    firstName,
                                                                    lastName);

            return newUser;


        }

        /// <summary>
        /// Gets a collection of all the users in the SQL Server membership database.
        /// </summary>
        /// <param name="pageIndex">The index of the page of results to return. pageIndex is zero-based.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">The total number of users.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUserCollection"></see> of <see cref="T:System.Web.Security.MembershipUser"></see> objects representing all the users in the database for the configured <see cref="P:System.Web.Security.SqlMembershipProvider.ApplicationName"></see>.
        /// </returns>
        /// <exception cref="T:System.ArgumentException">pageIndex is less than zero.- or -pageSize is less than one.- or -pageIndex multiplied by pageSize plus pageSize minus one exceeds <see cref="F:System.Int32.MaxValue"></see>.</exception>
        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            MembershipUserCollection collection = new MembershipUserCollection();
            CustomMembershipUser newUser;
            foreach (MembershipUser oldUser in base.GetAllUsers(pageIndex, pageSize, out totalRecords))
            {
                ProfileBase profile = ProfileBase.Create(oldUser.UserName);
                string firstName = (string)profile.GetPropertyValue("FirstName");
                string lastName = (string)profile.GetPropertyValue("LastName");
                string displayName = (string)profile.GetPropertyValue("DisplayName");

                newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                   oldUser.UserName,
                                                   oldUser.ProviderUserKey,
                                                   oldUser.Email,
                                                   oldUser.PasswordQuestion,
                                                   oldUser.Comment,
                                                   oldUser.IsApproved,
                                                   oldUser.IsLockedOut,
                                                   oldUser.CreationDate,
                                                   oldUser.LastLoginDate,
                                                   oldUser.LastActivityDate,
                                                   oldUser.LastPasswordChangedDate,
                                                   oldUser.LastLockoutDate,
                                                   displayName,
                                                   firstName,
                                                   lastName);
                collection.Add(newUser);
            }
            return collection;
        }

        /// <summary>
        /// Gets a collection of membership users where the user name contains the specified user name to match.
        /// </summary>
        /// <param name="usernameToMatch">The user name to search for.</param>
        /// <param name="pageIndex">The index of the page of results to return. pageIndex is zero-based.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">When this method returns, contains the total number of matched users.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUserCollection"></see> that contains a page of pageSize<see cref="T:System.Web.Security.MembershipUser"></see> objects beginning at the page specified by pageIndex.
        /// </returns>
        /// <exception cref="T:System.ArgumentException">usernameToMatch is an empty string ("") or is longer than 256 characters.- or -pageIndex is less than zero.- or -pageSize is less than 1.- or -pageIndex multiplied by pageSize plus pageSize minus one exceeds <see cref="F:System.Int32.MaxValue"></see>.</exception>
        /// <exception cref="T:System.ArgumentNullException">usernameToMatch is null.</exception>
        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            MembershipUserCollection collection = new MembershipUserCollection();
            CustomMembershipUser newUser;
            foreach (MembershipUser oldUser in base.FindUsersByName(usernameToMatch, pageIndex, pageSize, out totalRecords))
            {
                ProfileBase profile = ProfileBase.Create(oldUser.UserName);
                string firstName = (string)profile.GetPropertyValue("FirstName");
                string lastName = (string)profile.GetPropertyValue("LastName");
                string displayName = (string)profile.GetPropertyValue("DisplayName");

                newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                   oldUser.UserName,
                                                   oldUser.ProviderUserKey,
                                                   oldUser.Email,
                                                   oldUser.PasswordQuestion,
                                                   oldUser.Comment,
                                                   oldUser.IsApproved,
                                                   oldUser.IsLockedOut,
                                                   oldUser.CreationDate,
                                                   oldUser.LastLoginDate,
                                                   oldUser.LastActivityDate,
                                                   oldUser.LastPasswordChangedDate,
                                                   oldUser.LastLockoutDate,
                                                   displayName,
                                                   firstName,
                                                   lastName);
                collection.Add(newUser);
            }
            return collection;

        }

        /// <summary>
        /// Returns a collection of membership users for which the e-mail address field contains the specified e-mail address.
        /// </summary>
        /// <param name="emailToMatch">The e-mail address to search for.</param>
        /// <param name="pageIndex">The index of the page of results to return. pageIndex is zero-based.</param>
        /// <param name="pageSize">The size of the page of results to return.</param>
        /// <param name="totalRecords">The total number of matched users.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUserCollection"></see> that contains a page of pageSize<see cref="T:System.Web.Security.MembershipUser"></see> objects beginning at the page specified by pageIndex.
        /// </returns>
        /// <exception cref="T:System.ArgumentException">emailToMatch is longer than 256 characters.- or -pageIndex is less than zero.- or -pageSize is less than one.- or -pageIndex multiplied by pageSize plus pageSize minus one exceeds <see cref="F:System.Int32.MaxValue"></see>.</exception>
        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            MembershipUserCollection collection = new MembershipUserCollection();
            CustomMembershipUser newUser;
            foreach (MembershipUser oldUser in base.FindUsersByEmail(emailToMatch, pageIndex, pageSize, out totalRecords))
            {
                ProfileBase profile = ProfileBase.Create(oldUser.UserName);
                string firstName = (string)profile.GetPropertyValue("FirstName");
                string lastName = (string)profile.GetPropertyValue("LastName");
                string displayName = (string)profile.GetPropertyValue("DisplayName");

                newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                   oldUser.UserName,
                                                   oldUser.ProviderUserKey,
                                                   oldUser.Email,
                                                   oldUser.PasswordQuestion,
                                                   oldUser.Comment,
                                                   oldUser.IsApproved,
                                                   oldUser.IsLockedOut,
                                                   oldUser.CreationDate,
                                                   oldUser.LastLoginDate,
                                                   oldUser.LastActivityDate,
                                                   oldUser.LastPasswordChangedDate,
                                                   oldUser.LastLockoutDate,
                                                   displayName,
                                                   firstName,
                                                   lastName);
                collection.Add(newUser);
            }
            return collection;
        }

        /// <summary>
        /// Updates information about a user in the SQL Server membership database.
        /// </summary>
        /// <param name="user">A <see cref="T:System.Web.Security.MembershipUser"></see> object that represents the user to update and the updated information for the user.</param>
        /// <exception cref="T:System.ArgumentException">The <see cref="P:System.Web.Security.MembershipUser.UserName"></see> property of user is an empty string (""), contains a comma, or is longer than 256 characters.- or -The <see cref="P:System.Web.Security.MembershipUser.Email"></see> property of user is longer than 256 characters.- or -The <see cref="P:System.Web.Security.MembershipUser.Email"></see> property of user is an empty string and <see cref="P:System.Web.Security.SqlMembershipProvider.RequiresUniqueEmail"></see> is set to true.</exception>
        /// <exception cref="T:System.Configuration.Provider.ProviderException">The <see cref="P:System.Web.Security.MembershipUser.UserName"></see> property of user was not found in the database.- or -The <see cref="P:System.Web.Security.MembershipUser.Email"></see> property of user was equal to an existing e-mail address in the database and <see cref="P:System.Web.Security.SqlMembershipProvider.RequiresUniqueEmail"></see> is set to true.- or -The user update failed.</exception>
        /// <exception cref="T:System.ArgumentNullException">user is null. - or -The <see cref="P:System.Web.Security.MembershipUser.UserName"></see> property of user is null.- or -The <see cref="P:System.Web.Security.MembershipUser.Email"></see> property of user is null and <see cref="P:System.Web.Security.SqlMembershipProvider.RequiresUniqueEmail"></see> is set to true.</exception>
        public override void UpdateUser(MembershipUser user)
        {  
            base.UpdateUser(user);
            CustomMembershipUser newUser = (CustomMembershipUser)user;

            ProfileBase profile = ProfileBase.Create(user.UserName);
            profile.SetPropertyValue("DisplayName", newUser.DisplayName);
            profile.SetPropertyValue("LastName", newUser.LastName);
            profile.SetPropertyValue("FirstName", newUser.FirstName);
            DateTime date = (DateTime)profile.GetPropertyValue("PasswordVerificationTokenExpirationDate");

            if (date != null && date == DateTime.MinValue)
            {
                profile.SetPropertyValue("PasswordVerificationTokenExpirationDate", null);
            }

            profile.Save();

        }

        /// <summary>
        /// Gets the information from the data source for the membership user associated with the specified unique identifier and updates the last activity date/time stamp for the user, if specified.
        /// </summary>
        /// <param name="providerUserKey">The unique identifier for the user.</param>
        /// <param name="userIsOnline">true to update the last-activity date/time stamp for the specified user; otherwise, false.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Security.MembershipUser"></see> object representing the user associated with the specified unique identifier. If no user is found in the database for the specified providerUserKey value, null is returned.
        /// </returns>
        /// <exception cref="T:System.ArgumentNullException">providerUserKey is null. </exception>
        /// <exception cref="T:System.ArgumentException">providerUserKey is not of type <see cref="T:System.Guid"></see>.</exception>
        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            MembershipUser oldUser = base.GetUser(providerUserKey, userIsOnline);
            if (oldUser != null)
            {
                ProfileBase profile = ProfileBase.Create(oldUser.UserName);
                string firstName = (string)profile.GetPropertyValue("FirstName");
                string lastName = (string)profile.GetPropertyValue("LastName");
                string displayName = (string)profile.GetPropertyValue("DisplayName");

                CustomMembershipUser newUser = new CustomMembershipUser(oldUser.ProviderName,
                                                                        oldUser.UserName,
                                                                        oldUser.ProviderUserKey,
                                                                        oldUser.Email,
                                                                        oldUser.PasswordQuestion,
                                                                        oldUser.Comment,
                                                                        oldUser.IsApproved,
                                                                        oldUser.IsLockedOut,
                                                                        oldUser.CreationDate,
                                                                        oldUser.LastLoginDate,
                                                                        oldUser.LastActivityDate,
                                                                        oldUser.LastPasswordChangedDate,
                                                                        oldUser.LastLockoutDate,
                                                                        displayName,
                                                                        firstName,
                                                                        lastName);

                return newUser;
            }
            else
                return oldUser;
        }

       
    }
}
