using System;
using System.Collections.Generic;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class ApplicationLogComparer : IComparer<ApplicationLog>
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
        public ApplicationLogComparer(string sortEx,bool ascending) {
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
        public bool Equals(ApplicationLog x, ApplicationLog y)
        {
          if (x.Id == y.Id) {
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
        public int Compare(ApplicationLog x, ApplicationLog y)
        {
          int retVal = 0;
          switch (_sortColumn) 
          {
            case "Id":
                retVal = (x.Id - y.Id);
                break;
            case "Logger":
                retVal = String.Compare(x.Logger, y.Logger, StringComparison.InvariantCultureIgnoreCase);
                break;
            case "Message":
              retVal = String.Compare(x.Message, y.Message, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "User":
              retVal = String.Compare(x.User, y.User, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Level":
              retVal = String.Compare(x.Level, y.Level , StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Date":
              retVal = DateTime.Compare(x.Date, y.Date);
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
