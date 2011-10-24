using System;
using System.Xml.Serialization;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// BugNET user class for working with the membership provider
    /// </summary>
    [XmlRootAttribute("User")]
    public class ITUser
    {
        private string _displayName;
        private string _firstName;
        private string _lastName;

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public Guid Id { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is approved.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is approved; otherwise, <c>false</c>.
        /// </value>
        public bool IsApproved { get; set; }

        /// <summary>
        /// Gets or sets the last login date.
        /// </summary>
        /// <value>The last login date.</value>
        public DateTime LastLoginDate { get; set; }

        /// <summary>
        /// Gets or sets the creation date.
        /// </summary>
        /// <value>The creation date.</value>
        public DateTime CreationDate { get; set; }

        /// <summary>
        /// Gets or sets the name of the user.
        /// </summary>
        /// <value>The name of the user.</value>
        public string UserName { get; set; }

        /// <summary>
        /// Gets or sets the email address of the user.
        /// </summary>
        /// <value>The name of the user.</value>
        public string Email { get; set; }

        /// <summary>
        /// Gets or sets the display name.
        /// </summary>
        /// <value>The display name.</value>
        public string DisplayName
        {
            get { return (_displayName == string.Empty) ? UserName : _displayName; }
            set { _displayName = value; }
        }


        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="ITUser"/> class.
        /// </summary>
        public ITUser() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="ITUser"/> class.
        /// </summary>
        /// <param name="userId">The user id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <param name="lastName"></param>
        /// <param name="displayName">The display name.</param>
        /// <param name="firstName"></param>
        /// <param name="creationDate"></param>
        /// <param name="lastLoginDate"></param>
        /// <param name="isApproved"></param>
        public ITUser(Guid userId, string userName, string firstName, string lastName, string displayName, DateTime creationDate, DateTime lastLoginDate, bool isApproved)
        {
            Id = userId;
            UserName = userName;
            _displayName = displayName;
            CreationDate = creationDate;
            _firstName = firstName;
            _lastName = lastName;
            IsApproved = isApproved;
            LastLoginDate = lastLoginDate;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ITUser"/> class.
        /// </summary>
        /// <param name="userId">The user id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <param name="displayName">The display name.</param>
        public ITUser(Guid userId, string userName, string displayName)
            : this(userId, userName, string.Empty, string.Empty, displayName, DateTime.MinValue, DateTime.MinValue, true)
        { }

        #endregion
    }
}
