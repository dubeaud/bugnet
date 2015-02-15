using System;
using System.Web.Security;

namespace BugNET.Providers.MembershipProviders
{
    /// <summary>
    /// 
    /// </summary>
    public class CustomMembershipUser : MembershipUser
    {
        private string _displayName;

        /// <summary>
        /// Gets or sets the first name.
        /// </summary>
        /// <value>The first name.</value>
        public string FirstName { get; set; }

        /// <summary>
        /// Gets or sets the last name.
        /// </summary>
        /// <value>The last name.</value>
        public string LastName { get; set; }

        /// <summary>
        /// Gets or sets the display name.
        /// </summary>
        /// <value>The display name.</value>
        public string DisplayName
        {
            get {
                return string.IsNullOrEmpty(_displayName) ? base.UserName : _displayName;
            }
            set { _displayName = value; }
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="CustomMembershipUser"/> class.
        /// </summary>
        /// <param name="providername">The provider name.</param>
        /// <param name="username">The username.</param>
        /// <param name="providerUserKey">The provider user key.</param>
        /// <param name="email">The email.</param>
        /// <param name="passwordQuestion">The password question.</param>
        /// <param name="comment">The comment.</param>
        /// <param name="isApproved">if set to <c>true</c> [is approved].</param>
        /// <param name="isLockedOut">if set to <c>true</c> [is locked out].</param>
        /// <param name="creationDate">The creation date.</param>
        /// <param name="lastLoginDate">The last login date.</param>
        /// <param name="lastActivityDate">The last activity date.</param>
        /// <param name="lastPasswordChangedDate">The last password changed date.</param>
        /// <param name="lastLockedOutDate">The last locked out date.</param>
        /// <param name="displayName">The display name.</param>
        /// <param name="firstName">The first name.</param>
        /// <param name="lastName">The last name.</param>
        public CustomMembershipUser(string providername,
                                  string username,
                                  object providerUserKey,
                                  string email,
                                  string passwordQuestion,
                                  string comment,
                                  bool isApproved,
                                  bool isLockedOut,
                                  DateTime creationDate,
                                  DateTime lastLoginDate,
                                  DateTime lastActivityDate,
                                  DateTime lastPasswordChangedDate,
                                  DateTime lastLockedOutDate,
                                  string displayName,
                                  string firstName,
                                  string lastName) :
                                  base(providername,
                                       username,
                                       providerUserKey,
                                       email,
                                       passwordQuestion,
                                       comment,
                                       isApproved,
                                       isLockedOut,
                                       creationDate,
                                       lastLoginDate,
                                       lastActivityDate,
                                       lastPasswordChangedDate,
                                       lastLockedOutDate)
        {
            FirstName = firstName;
            LastName = lastName;
            DisplayName = displayName;
        }
    }
}
