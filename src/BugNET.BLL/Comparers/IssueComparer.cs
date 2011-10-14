using System;
using System.Collections.Generic;
using BugNET.Entities;

namespace BugNET.BLL
{
    /// <summary>
    /// Comparers for Issues.
    /// </summary>
    public class IssueComparer : IComparer<Issue> 
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
        public IssueComparer(string sortEx,bool ascending) {
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
        public bool Equals(Issue x, Issue y) {
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
        public int Compare(Issue x, Issue y) {
          int retVal = 0;
          switch (_sortColumn) {

            case "Created":
              retVal = DateTime.Compare(x.DateCreated, y.DateCreated);
              break;
            case "LastUpdate":
              retVal = DateTime.Compare(x.LastUpdate, y.LastUpdate);
              break;
            case "DueDate":
              retVal = DateTime.Compare(x.DueDate, y.DueDate);
              break;
            case "Category":
              retVal = (x.CategoryId - y.CategoryId);
              break;
            case "Description":
              retVal = String.Compare(x.Description, y.Description, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Creator":
              retVal = String.Compare(x.CreatorDisplayName, y.CreatorDisplayName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Owner":
              retVal = String.Compare(x.OwnerDisplayName, y.OwnerDisplayName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Assigned":
              retVal = String.Compare(x.AssignedDisplayName, y.AssignedDisplayName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "LastUpdateUser":
              retVal = String.Compare(x.LastUpdateDisplayName, y.LastUpdateDisplayName, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "IssueType":
              retVal = (x.IssueTypeId - y.IssueTypeId);
              break;
            case "Milestone":
              retVal = (x.MilestoneId - y.MilestoneId);
              break;
            case "AffectedMilestone":
                retVal = (x.AffectedMilestoneId - y.AffectedMilestoneId);
                break;
            case "Status":
              retVal = (x.StatusId- y.StatusId);
              break;
            case "Priority":
              // retVal = (x.PriorityId - y.PriorityId);
              retVal = (PriorityManager.GetPriorityById(x.PriorityId).SortOrder - PriorityManager.GetPriorityById(y.PriorityId).SortOrder);
              break;
            case "TimeLogged":
              retVal = (int)(x.TimeLogged - y.TimeLogged);
              break;
            case "Votes":
              retVal = (x.Votes - y.Votes);
              break;
            case "Title":
              retVal = String.Compare(x.Title, y.Title, StringComparison.InvariantCultureIgnoreCase);
              break;
            case "Estimation":
              retVal = (int)(x.Estimation - y.Estimation);
              break;
            case "Id":
              retVal = (x.Id - y.Id);
              break;
            case "Progress":
              retVal = (x.Progress - y.Progress);
              break;
            case "Resolution":
              retVal = (x.ResolutionId - y.ResolutionId);
              break;
            case "Project":
              retVal = (x.ProjectId - y.ProjectId);
              break;
          }
          return (retVal * (_reverse ? -1 : 1));
        }

        /// <summary>
        /// Gets the hash code.
        /// </summary>
        /// <param name="obj">The obj.</param>
        /// <returns></returns>
        public int GetHashCode(Issue obj) {
          return 0;
        }
    }
}
