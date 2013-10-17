namespace BugNET.HttpModules
{
    /// <summary>
    /// A class to store the users properties fetched from an Active Directory
    /// </summary>
    public class UserProperties
    {
        private string _FirstName;
        private string _LastName;
        private string _Email;

        /// <summary>
        /// Gets or sets the name of the first.
        /// </summary>
        /// <value>The name of the first.</value>
        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }
        /// <summary>
        /// Gets or sets the name of the last.
        /// </summary>
        /// <value>The name of the last.</value>
        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }
        /// <summary>
        /// Gets or sets the email.
        /// </summary>
        /// <value>The email.</value>
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

		public string DisplayName { get; set; }
    }
}
