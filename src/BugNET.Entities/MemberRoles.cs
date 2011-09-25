using System.Collections;

namespace BugNET.Entities
{
    public class MemberRoles
    {
        private string _Member;
        private  ArrayList _Roles;

        /// <summary>
        /// Initializes a new instance of the <see cref="MemberRoles"/> class.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="role">The role.</param>
        public MemberRoles(string member, string role)
        {
            _Member = member;
            _Roles = new ArrayList();
            _Roles.Add(role);
            _Roles.TrimToSize();
        }

        /// <summary>
        /// Adds the role.
        /// </summary>
        /// <param name="role">The role.</param>
        public void AddRole(string role) 
        {
            if (!_Roles.Contains(role))
            {
                _Roles.Add(role);
            }
        }

        /// <summary>
        /// Determines whether the specified role has role.
        /// </summary>
        /// <param name="role">The role.</param>
        /// <returns>
        /// 	<c>true</c> if the specified role has role; otherwise, <c>false</c>.
        /// </returns>
        public bool HasRole(string role)
        {
            return _Roles.Contains(role);
        }

        /// <summary>
        /// Gets the username.
        /// </summary>
        /// <value>The username.</value>
        public string Username
        {
            get {return _Member;}
        }

        /// <summary>
        /// Gets the role string.
        /// </summary>
        /// <value>The role string.</value>
        public string RoleString
        {
            get
            {
                string tmpstr= "";
                foreach (string rs in _Roles)
                {
                    tmpstr += rs + ", ";
                }
                return tmpstr.Remove(tmpstr.Length - 2, 2);
            }
        }

        /// <summary>
        /// Gets the roles.
        /// </summary>
        /// <value>The roles.</value>
        public IList Roles
        {
            get { return _Roles; }
        }
    }
}
