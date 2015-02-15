using System.Collections;
using System.Linq;

namespace BugNET.Entities
{
    public class MemberRoles
    {
        private readonly ArrayList _roles;

        /// <summary>
        /// Initializes a new instance of the <see cref="MemberRoles"/> class.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <param name="role">The role.</param>
        public MemberRoles(string member, string role)
        {
            Username = member;
            _roles = new ArrayList { role };
            _roles.TrimToSize();
        }

        /// <summary>
        /// Adds the role.
        /// </summary>
        /// <param name="role">The role.</param>
        public void AddRole(string role)
        {
            if (!_roles.Contains(role))
            {
                _roles.Add(role);
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
            return _roles.Contains(role);
        }

        /// <summary>
        /// Gets the username.
        /// </summary>
        /// <value>The username.</value>
        public string Username { get; private set; }

        /// <summary>
        /// Gets the role string.
        /// </summary>
        /// <value>The role string.</value>
        public string RoleString
        {
            get
            {
                var tmpstr = _roles.Cast<string>().Aggregate("", (current, rs) => current + (rs + ", "));
                return tmpstr.Remove(tmpstr.Length - 2, 2);
            }
        }

        /// <summary>
        /// Gets the roles.
        /// </summary>
        /// <value>The roles.</value>
        public IList Roles
        {
            get { return _roles; }
        }
    }
}
