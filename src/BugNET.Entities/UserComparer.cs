using System;
using System.Collections.Generic;
using System.Web;
using BugNET.Providers.MembershipProviders;

namespace BugNET.Entities
{
    public class UserComparer : IComparer<CustomMembershipUser>
    {
        /// <summary>
        /// Sorting column
        /// </summary>
        private string _sortColumn;
        /// <summary>
        /// Reverse sorting
        /// </summary>
        private bool _reverse;

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueComparer"/> class.
        /// </summary>
        /// <param name="sortEx">The sort ex.</param>
        /// <param name="ascending">The ascending.</param>
        public UserComparer(string sortEx,bool ascending) {
          if (!String.IsNullOrEmpty(sortEx))
          {
              _reverse = ascending;      
              _sortColumn = sortEx;
          }
        }

        /// <summary>
        /// Equalses the specified x.
        /// </summary>
        /// <param name="x">The x.</param>
        /// <param name="y">The y.</param>
        /// <returns></returns>
        public bool Equals(CustomMembershipUser x, CustomMembershipUser y)
        {
          if (x.ProviderUserKey == y.ProviderUserKey) {
            return true;
          }
          else {
            return false;
          }
        }

        /// <summary>
        /// Compares two objects and returns a value indicating whether one is less than, equal to, or greater than the other.
        /// </summary>
        /// <param name="x">The first object to compare.</param>
        /// <param name="y">The second object to compare.</param>
        /// <returns>
        /// Value Condition Less than zero<paramref name="x"/> is less than <paramref name="y"/>.Zero<paramref name="x"/> equals <paramref name="y"/>.Greater than zero<paramref name="x"/> is greater than <paramref name="y"/>.
        /// </returns>
        public int Compare(CustomMembershipUser x, CustomMembershipUser y)
        {
          int retVal = 0;
          switch (_sortColumn) 
          {
            case "UserName":
                retVal = String.Compare(x.UserName, y.UserName, StringComparison.InvariantCultureIgnoreCase);
                break;
            case "FirstName":
              retVal = String.Compare(x.FirstName, y.FirstName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "LastName":
              retVal = String.Compare(x.LastName, y.LastName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "DisplayName":
              retVal = String.Compare(x.DisplayName, y.DisplayName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Email":
              retVal = String.Compare(x.Email, y.Email , StringComparison.InvariantCultureIgnoreCase);
              break;
            case "CreationDate":
              retVal = DateTime.Compare(x.CreationDate, y.CreationDate);
              break;
            case "IsApproved":
              retVal = (x.IsApproved.CompareTo(y.IsApproved));
              break;
          }
          return (retVal * (_reverse ? -1 : 1));
        }

        /// <summary>
        /// Gets the hash code.
        /// </summary>
        /// <param name="obj">The obj.</param>
        /// <returns></returns>
        public int GetHashCode(Project obj) {
          return 0;
        }
    }
}
