using System;
using System.Collections.Generic;
using BugNET.Entities;

namespace BugNET.BLL
{
    public class ProjectComparer : IComparer<Project>
    {
        /// <summary>
        /// Sorting column
        /// </summary>
        private readonly string _sortColumn;
        /// <summary>
        /// Reverse sorting
        /// </summary>
        private readonly bool _reverse;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProjectComparer"/> class.
        /// </summary>
        /// <param name="sortEx">The sort ex.</param>
        /// <param name="ascending">The ascending.</param>
        public ProjectComparer(string sortEx,bool ascending) {
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
        public bool Equals(Project x, Project y)
        {
            return x.Id == y.Id;
        }

        /// <summary>
        /// Compares two objects and returns a value indicating whether one is less than, equal to, or greater than the other.
        /// </summary>
        /// <param name="x">The first object to compare.</param>
        /// <param name="y">The second object to compare.</param>
        /// <returns>
        /// Value Condition Less than zero<paramref name="x"/> is less than <paramref name="y"/>.Zero<paramref name="x"/> equals <paramref name="y"/>.Greater than zero<paramref name="x"/> is greater than <paramref name="y"/>.
        /// </returns>
        public int Compare(Project x, Project y) {
          var retVal = 0;
          switch (_sortColumn) {

            case "Created":
              retVal = DateTime.Compare(x.DateCreated, y.DateCreated);
              break;
            case "Description":
              retVal = String.Compare(x.Description, y.Description, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Creator":
              retVal = String.Compare(x.CreatorUserName, y.CreatorUserName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Name":
              retVal = String.Compare(x.Name, y.Name, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Manager":
              retVal = String.Compare(x.ManagerUserName, y.ManagerUserName , StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Id":
              retVal = (x.Id - y.Id);
              break;
            case "Active":
              retVal = (x.Disabled.CompareTo(y.Disabled));
              break;
          }
          return (retVal * (_reverse ? -1 : 1));
        }
    }
}
