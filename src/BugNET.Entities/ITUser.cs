using System;
using System.Xml.Serialization;
using BugNET.Common;

namespace BugNET.Entities
{
    /// <summary>
    /// BugNET user class for working with the membership provider
    /// </summary>
    [XmlRootAttribute("User")]
    public class ITUser  : IToXml
    {
        private Guid _Id;
        private string _UserName;
        private string _Email;
        private string _DisplayName;
        private string _FirstName;
        private string _LastName;
        private DateTime _CreationDate;
        private DateTime _LastLoginDate;
        private bool _IsApproved;

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public Guid Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is approved.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is approved; otherwise, <c>false</c>.
        /// </value>
        public bool IsApproved
        {
            get { return _IsApproved; }
            set { _IsApproved = value; }
        }
        /// <summary>
        /// Gets or sets the last login date.
        /// </summary>
        /// <value>The last login date.</value>
        public DateTime LastLoginDate
        {
            get { return _LastLoginDate; }
            set { _LastLoginDate = value; }
        }

        /// <summary>
        /// Gets or sets the creation date.
        /// </summary>
        /// <value>The creation date.</value>
        public DateTime CreationDate
        {
            get { return _CreationDate; }
            set { _CreationDate = value; }
        }

        /// <summary>
        /// Gets or sets the name of the user.
        /// </summary>
        /// <value>The name of the user.</value>
        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        /// <summary>
        /// Gets or sets the email address of the user.
        /// </summary>
        /// <value>The name of the user.</value>
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

        /// <summary>
        /// Gets or sets the display name.
        /// </summary>
        /// <value>The display name.</value>
        public string DisplayName
        {
            get { return (_DisplayName == string.Empty) ? _UserName : _DisplayName; }
            set { _DisplayName = value; }
        }


        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="T:ITUser"/> class.
        /// </summary>
        public ITUser() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="ITUser"/> class.
        /// </summary>
        /// <param name="userId">The user id.</param>
        /// <param name="userName">Name of the user.</param>
        /// <param name="displayName">The display name.</param>
        public ITUser(Guid userId, string userName, string firstName, string lastName, string displayName, DateTime creationDate, DateTime lastLoginDate, bool isApproved)
        {
            _Id = userId;
            _UserName = userName;
            _DisplayName = displayName;
            _CreationDate = creationDate;
            _FirstName = firstName;
            _LastName = lastName;
            _IsApproved = isApproved;
            _LastLoginDate = lastLoginDate;
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

        #region IToXml Members

        /// <summary>
        /// Toes the XML.
        /// </summary>
        /// <returns></returns>
        public string ToXml()
        {
            XmlSerializeService<ITUser> service = new XmlSerializeService<ITUser>();
            return service.ToXml(this);
        }

        #endregion
    }
}
