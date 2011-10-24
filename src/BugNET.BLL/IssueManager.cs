using System;
using System.Collections.Generic;
using System.Linq;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    /// <summary>
    /// Manager class for issues
    /// </summary>
    public static class IssueManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Instance Methods
        /// <summary>
        /// Saves the issue
        /// </summary>
        /// <param name="issueToSave">The issue to save.</param>
        /// <returns></returns>
        public static bool SaveIssue(Issue issueToSave)
        {
            if (issueToSave.Id <= Globals.NEW_ID)
            {
                var tempId = DataProviderManager.Provider.CreateNewIssue(issueToSave);

                if (tempId > 0)
                {
                    issueToSave.Id = tempId;

                    //add vote
                    var vote = new IssueVote { IssueId = issueToSave.Id, VoteUsername = issueToSave.CreatorUserName};
                    IssueVoteManager.SaveOrUpdate(vote);

                    //TOOD: handle adding an attachment for new issue.

                    //send notifications for add issue
                    IssueNotificationManager.SendIssueAddNotifications(issueToSave.Id);

                    return true;
                }
                return false;
            }

            var issueChanges = GetIssueChanges(GetIssueById(issueToSave.Id), issueToSave);

            if (issueChanges.Count > 0)
            {
                var result = DataProviderManager.Provider.UpdateIssue(issueToSave);
                if (result)
                {
                    UpdateIssueHistory(issueChanges);

                    IssueNotificationManager.SendIssueNotifications(issueToSave.Id, issueChanges);
                    if (issueToSave.SendNewAssigneeNotification)
                    {
                        //add this user to notifications and send them a notification
                        var notification = new IssueNotification() { IssueId = issueToSave.Id, NotificationUsername = issueToSave.AssignedUserName };

                        IssueNotificationManager.SaveOrUpdate(notification);
                        IssueNotificationManager.SendNewAssigneeNotification(notification);
                    }
                }
                return result;
            }

            return true;
        }

        /// <summary>
        /// Updates the IssueHistory objects in the changes array list
        /// </summary>
        /// <param name="issueChanges">The issue changes.</param>
        private static void UpdateIssueHistory(IEnumerable<IssueHistory> issueChanges)
        {
            foreach (var issueHistory in issueChanges)
                IssueHistoryManager.SaveOrUpdate(issueHistory);
        }

        /// <summary>
        /// Gets the issue changes.
        /// </summary>
        /// <param name="originalIssue">The original issue.</param>
        /// <param name="issueToCompare">The issue to compare.</param>
        /// <returns></returns>
        public static List<IssueHistory> GetIssueChanges(Issue originalIssue, Issue issueToCompare)
        {
            var issueChanges = new List<IssueHistory>();

            if (originalIssue != null && issueToCompare != null)
            {
                var history = new IssueHistory { CreatedUserName = issueToCompare.CreatorUserName, IssueId = originalIssue.Id, DateChanged = DateTime.Now };

                if (originalIssue.Title.ToLower() != issueToCompare.Title.ToLower())
                    issueChanges.Add(GetNewIssueHistory(history, "Title", originalIssue.Title, issueToCompare.Title));

                if (originalIssue.Description.ToLower() != issueToCompare.Description.ToLower())
                    issueChanges.Add(GetNewIssueHistory(history, "Description", originalIssue.Description, issueToCompare.Description));

                if (originalIssue.CategoryId != issueToCompare.CategoryId)
                    issueChanges.Add(GetNewIssueHistory(history, "Category", originalIssue.CategoryName, issueToCompare.CategoryName));

                if (originalIssue.PriorityId != issueToCompare.PriorityId)
                    issueChanges.Add(GetNewIssueHistory(history, "Priority", originalIssue.PriorityName, issueToCompare.PriorityName));

                if (originalIssue.StatusId != issueToCompare.StatusId)
                    issueChanges.Add(GetNewIssueHistory(history, "Status", originalIssue.StatusName, issueToCompare.StatusName));

                if (originalIssue.MilestoneId != issueToCompare.MilestoneId)
                    issueChanges.Add(GetNewIssueHistory(history, "Milestone", originalIssue.MilestoneName, issueToCompare.MilestoneName));

                if (originalIssue.AffectedMilestoneId != issueToCompare.AffectedMilestoneId)
                    issueChanges.Add(GetNewIssueHistory(history, "Affected Milestone", originalIssue.AffectedMilestoneName, issueToCompare.AffectedMilestoneName));

                if (originalIssue.IssueTypeId != issueToCompare.IssueTypeId)
                    issueChanges.Add(GetNewIssueHistory(history, "Issue Type", originalIssue.IssueTypeName, issueToCompare.IssueTypeName));

                if (originalIssue.ResolutionId != issueToCompare.ResolutionId)
                    issueChanges.Add(GetNewIssueHistory(history, "Resolution", originalIssue.ResolutionName, issueToCompare.ResolutionName));

                var newAssignedUserName = String.IsNullOrEmpty(originalIssue.AssignedUserName) ? Globals.UNASSIGNED_DISPLAY_TEXT : issueToCompare.AssignedUserName;

                if ((originalIssue.AssignedUserName != newAssignedUserName))
                {
                    // if the new assigned user is the unassigned user then don't trigger the new assignee notification
                    originalIssue.SendNewAssigneeNotification = (newAssignedUserName != Globals.UNASSIGNED_DISPLAY_TEXT);
                    originalIssue.NewAssignee = true;

                    var newAssignedDisplayName = (newAssignedUserName == Globals.UNASSIGNED_DISPLAY_TEXT) ? newAssignedUserName : UserManager.GetUserDisplayName(newAssignedUserName);
                    issueChanges.Add(GetNewIssueHistory(history, "Assigned to", originalIssue.AssignedDisplayName, newAssignedDisplayName));
                }

                if (originalIssue.OwnerUserName != issueToCompare.OwnerUserName)
                {
                    var newOwnerDisplayName = UserManager.GetUserDisplayName(issueToCompare.OwnerUserName);
                    issueChanges.Add(GetNewIssueHistory(history, "Owner", originalIssue.OwnerDisplayName, newOwnerDisplayName));
                }

                if (originalIssue.Estimation != issueToCompare.Estimation)
                    issueChanges.Add(GetNewIssueHistory(history, "Estimation", Utilities.EstimationToString(originalIssue.Estimation), Utilities.EstimationToString(issueToCompare.Estimation)));

                if (originalIssue.Visibility != issueToCompare.Visibility)
                    issueChanges.Add(GetNewIssueHistory(history, "Visibility", Utilities.GetBooleanAsString(originalIssue.Visibility.ToBool()), Utilities.GetBooleanAsString(issueToCompare.Visibility.ToBool())));

                if (originalIssue.DueDate != issueToCompare.DueDate)
                {
                    var originalDate = originalIssue.DueDate == DateTime.MinValue ? string.Empty : originalIssue.DueDate.ToShortDateString();
                    var newDate = issueToCompare.DueDate == DateTime.MinValue ? string.Empty : issueToCompare.DueDate.ToShortDateString();

                    issueChanges.Add(GetNewIssueHistory(history, "Due Date", originalDate, newDate));
                }
                    
                if (originalIssue.Progress != issueToCompare.Progress)
                    issueChanges.Add(GetNewIssueHistory(history, "Progress", originalIssue.Progress.ToString("p"), issueToCompare.Progress.ToString("p")));
            }
            else
            {
                throw new Exception("Unable to retrieve original issue data");
            }

            return issueChanges;
        }

        private static IssueHistory GetNewIssueHistory(IssueHistory history, string fieldChanged, string oldValue, string newValue)
        {
            return new IssueHistory
                       {
                           CreatedUserName = history.CreatedUserName,
                           CreatorDisplayName = string.Empty,
                           DateChanged = history.DateChanged,
                           FieldChanged = fieldChanged,
                           IssueId = history.IssueId,
                           NewValue = newValue,
                           OldValue = oldValue
                       };
        }



        /// <summary>
        /// Calculate issue's percentage of issue list.
        /// </summary>
        /// <param name="issueCountList">The issue count list.</param>
        private static List<IssueCount> CalculateIssueCountListPercentage(List<IssueCount> issueCountList)
        {
            // calculate the total issues count
            var issueSum = issueCountList.Sum(issueCount => issueCount.Count);

            // update each issue percentage
            foreach (var issueCount in issueCountList)
            {
                issueCount.Percentage = issueSum != 0 ? Math.Round((decimal)((issueCount.Count * 100) / issueSum)) : 0;
            }

            return issueCountList;
        }

        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static Issue GetIssueById(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return (DataProviderManager.Provider.GetIssueById(issueId));
        }

        /// <summary>
        /// Gets the bugs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetIssuesByProjectId(projectId));
        }

        /// <summary>
        /// Gets the issue status count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueStatusCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueStatusCountByProject(projectId));
        }

        /// <summary>
        /// Gets the issue version count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueMilestoneCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueMilestoneCountByProject(projectId));
        }
        /// <summary>
        /// Gets the issue priority count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssuePriorityCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssuePriorityCountByProject(projectId);
        }
        /// <summary>
        /// Gets the issue user count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueUserCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUserCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unassigned count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnassignedCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnassignedCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unscheduled milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnscheduledMilestoneCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnscheduledMilestoneCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue type count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueTypeCountByProject(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueTypeCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue count by project and category.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public static int GetIssueCountByProjectAndCategory(int projectId, int categoryId = 0)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueCountByProjectAndCategory(projectId, categoryId);
        }

        /// <summary>
        /// Gets the bugs by criteria.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="componentId">The component id.</param>
        /// <param name="versionId">The version id.</param>
        /// <param name="issueTypeId">The type id.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="assignedToUserName">Name of the assigned to user.</param>
        /// <param name="resolutionId">The resolution id.</param>
        /// <param name="keywords">The keywords.</param>
        /// <param name="excludeClosed">if set to <c>true</c> [exclude closed].</param>
        /// <param name="reporterUserName">Name of the reporter user.</param>
        /// <param name="fixedInVersionId">The fixed in version id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCriteria(int projectId, int componentId, int versionId, int issueTypeId,
                int priorityId, int statusId, string assignedToUserName,
                int resolutionId, string keywords, bool excludeClosed, string reporterUserName, int fixedInVersionId)
        {


            throw new NotImplementedException();
            //return DataProviderManager.Provider.GetIssuesByCriteria(projectId, componentId, versionId, IssueTypeId,
            //    priorityId, statusId, AssignedToUserName, resolutionId, keywords, excludeClosed,reporterUserName,fixedInVersionId);
        }


        /// <summary>
        /// Deletes the issue
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static bool DeleteIssue(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.DeleteIssue(issueId);
        }

        /// <summary>
        /// Gets the issues by assigned username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByAssignedUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByAssignedUserName(projectId, username));
        }

        /// <summary>
        /// Gets the issues by creator username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCreatorUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByCreatorUserName(projectId, username));
        }

        /// <summary>
        /// Gets the issues by owner username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByOwnerUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetIssuesByOwnerUserName(projectId, username);
        }

        /// <summary>
        /// Gets the issues by relevancy.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByRelevancy(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByRelevancy(projectId, username));
        }

        /// <summary>
        /// Gets the name of the monitored issues by user.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="excludeClosedStatus">if set to <c>true</c> [exclude closed status].</param>
        /// <returns></returns>
        public static List<Issue> GetMonitoredIssuesByUserName(string username, bool excludeClosedStatus = true)
        {
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetMonitoredIssuesByUserName(username, excludeClosedStatus);
        }

        /// <summary>
        /// Returns an Issue object, pre-populated with defaults settings.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="assignedName"></param>
        /// <param name="ownerName"></param>
        /// <returns></returns>
        public static Issue GetDefaultIssueByProjectId(int projectId, string title, string description, string assignedName, string ownerName)
        {
            if (projectId < Globals.NEW_ID) throw new ArgumentOutOfRangeException(string.Format("ProjectID must be {0} or larger.", Globals.NEW_ID));

            var curProject = ProjectManager.GetProjectById(projectId);

            if (curProject == null) throw new ArgumentException("Project not found for ProjectID.");

            var cats = CategoryManager.GetByProjectId(projectId);
            var statuses = StatusManager.GetByProjectId(projectId);
            var priorities = PriorityManager.GetByProjectId(projectId);
            var issueTypes = IssueTypeManager.GetByProjectId(projectId);
            var resolutions = ResolutionManager.GetByProjectId(projectId);
            var affectedMilestones = MilestoneManager.GetByProjectId(projectId);
            var milestones = MilestoneManager.GetByProjectId(projectId);

            // Select the first one in the list, not really the default intended.
            var defCat = cats[0];
            var defStatus = statuses[0];
            var defPriority = priorities[0];
            var defIssueType = issueTypes[0];
            var defResolution = resolutions[0];
            var defAffectedMilestone = affectedMilestones[0];
            var defMilestone = milestones[0];

            // Now create an issue                
            var iss = new Issue(0, projectId, title, description, defCat.Id, defPriority.Id, defStatus.Id,
                defIssueType.Id, defMilestone.Id, defAffectedMilestone.Id, defResolution.Id,
                ownerName, assignedName, ownerName, 0, 0, DateTime.MinValue);

            return iss;
        }

        /// <summary>
        /// Gets the open issues.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetOpenIssues(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetOpenIssues(projectId));
        }


        /// <summary>
        /// Performs the query.
        /// </summary>
        /// <param name="queryClauses">The query clauses.</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> PerformQuery(List<QueryClause> queryClauses, int projectId = 0)
        {
            if (queryClauses.Count == 0) throw new ArgumentOutOfRangeException("queryClauses");

            return DataProviderManager.Provider.PerformQuery(projectId, queryClauses);
        }

        /// <summary>
        /// Performs the saved query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static List<Issue> PerformSavedQuery(int projectId, int queryId)
        {
            if (queryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("queryId"));
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.PerformSavedQuery(projectId, queryId);
        }

        #endregion
    }
}
