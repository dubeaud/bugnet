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
                    var vote = new IssueVote(issueToSave.Id, issueToSave.CreatorUserName);
                    IssueVoteManager.SaveIssueVote(vote);


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
                        var issueNotification = new IssueNotification(issueToSave.Id, issueToSave.AssignedUserName);

                        IssueNotificationManager.SaveIssueNotification(issueNotification);
                        IssueNotificationManager.SendNewAssigneeNotification(issueToSave.Id, issueToSave.AssignedDisplayName);
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
                IssueHistoryManager.SaveIssueHistory(issueHistory);
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
                var createdUserName = issueToCompare.CreatorUserName;

                if (originalIssue.Title.ToLower() != issueToCompare.Title.ToLower())
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Title", originalIssue.Title, issueToCompare.Title));
                if (originalIssue.Description.ToLower() != issueToCompare.Description.ToLower())
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Description", originalIssue.Description, issueToCompare.Description));
                if (originalIssue.CategoryId != issueToCompare.CategoryId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Category", originalIssue.CategoryName, issueToCompare.CategoryName));
                if (originalIssue.PriorityId != issueToCompare.PriorityId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Priority", originalIssue.PriorityName, issueToCompare.PriorityName));
                if (originalIssue.StatusId != issueToCompare.StatusId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Status", originalIssue.StatusName, issueToCompare.StatusName));
                if (originalIssue.MilestoneId != issueToCompare.MilestoneId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Milestone", originalIssue.MilestoneName, issueToCompare.MilestoneName));
                if (originalIssue.AffectedMilestoneId != issueToCompare.AffectedMilestoneId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Affected Milestone", originalIssue.AffectedMilestoneName, issueToCompare.AffectedMilestoneName));
                if (originalIssue.IssueTypeId != issueToCompare.IssueTypeId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Issue Type", originalIssue.IssueTypeName, issueToCompare.IssueTypeName));
                if (originalIssue.ResolutionId != issueToCompare.ResolutionId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Resolution", originalIssue.ResolutionName, issueToCompare.ResolutionName));

                var newAssignedUserName = String.IsNullOrEmpty(originalIssue.AssignedUserName) ? Globals.UNASSIGNED_DISPLAY_TEXT : issueToCompare.AssignedUserName;

                if ((originalIssue.AssignedUserName != newAssignedUserName))
                {
                    // if the new assigned user is the unassigned user then don't trigger the new assignee notification
                    originalIssue.SendNewAssigneeNotification = (newAssignedUserName != Globals.UNASSIGNED_DISPLAY_TEXT);
                    originalIssue.NewAssignee = true;

                    var newAssignedDisplayName = (newAssignedUserName == Globals.UNASSIGNED_DISPLAY_TEXT) ? newAssignedUserName :
                        UserManager.GetUserDisplayName(newAssignedUserName);
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Assigned to", originalIssue.AssignedDisplayName, newAssignedDisplayName));
                }
                if (originalIssue.OwnerUserName != issueToCompare.OwnerUserName)
                {
                    var newOwnerDisplayName = UserManager.GetUserDisplayName(issueToCompare.OwnerUserName);
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Owner", originalIssue.OwnerDisplayName, newOwnerDisplayName));
                }
                if (originalIssue.Estimation != issueToCompare.Estimation)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Estimation", EstimationToString(originalIssue.Estimation), EstimationToString(issueToCompare.Estimation)));
                if (originalIssue.Visibility != issueToCompare.Visibility)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Visibility", originalIssue.Visibility == 0 ? Boolean.FalseString : Boolean.TrueString, issueToCompare.Visibility == 0 ? Boolean.FalseString : Boolean.TrueString));
                if (originalIssue.DueDate != issueToCompare.DueDate)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Due Date", originalIssue.DueDate == DateTime.MinValue ? string.Empty : originalIssue.DueDate.ToShortDateString(), issueToCompare.DueDate.ToShortDateString()));
                if (originalIssue.Progress != issueToCompare.Progress)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Percent complete", string.Format("{0}%", originalIssue.Progress), string.Format("{0}%", issueToCompare.Progress)));
            }
            else
            {
                throw new Exception("Unable to retrieve original issue data");
            }

            return issueChanges;
        }

        /// <summary>
        /// Estimations to string.
        /// </summary>
        /// <param name="estimation">The estimation.</param>
        /// <returns></returns>
        public static string EstimationToString(decimal estimation)
        {
            return estimation >= 0 ? estimation.ToString() : "empty";
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
            if (issueId <= DefaultValues.GetIssueIdMinValue())
                throw (new ArgumentOutOfRangeException("issueId"));

            return (DataProviderManager.Provider.GetIssueById(issueId));
        }

        /// <summary>
        /// Gets the bugs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByProjectId(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetIssuesByProjectId(projectId));
        }

        /// <summary>
        /// Gets the issue status count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueStatusCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueStatusCountByProject(projectId));
        }

        /// <summary>
        /// Gets the issue version count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueMilestoneCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueMilestoneCountByProject(projectId));
        }
        /// <summary>
        /// Gets the issue priority count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssuePriorityCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssuePriorityCountByProject(projectId);
        }
        /// <summary>
        /// Gets the issue user count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueUserCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUserCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unassigned count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnassignedCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnassignedCountByProject(projectId);
        }


        /// <summary>
        /// Gets the issue unscheduled milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnscheduledMilestoneCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnscheduledMilestoneCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue type count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueTypeCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueTypeCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue count by project and category.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public static int GetIssueCountByProjectAndCategory(int projectId, int categoryId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

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
            if (issueId <= DefaultValues.GetIssueIdMinValue())
                throw (new ArgumentOutOfRangeException("issueId"));

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
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

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
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

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
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

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
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByRelevancy(projectId, username));
        }

        /// <summary>
        /// Gets the name of the monitored issues by user.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="excludeClosedStatus">if set to <c>true</c> [exclude closed status].</param>
        /// <returns></returns>
        public static List<Issue> GetMonitoredIssuesByUserName(string username, bool excludeClosedStatus)
        {
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

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
            if (projectId < DefaultValues.GetProjectIdMinValue())
                throw new ArgumentOutOfRangeException(string.Format("ProjectID must be {0} or larger.", DefaultValues.GetProjectIdMinValue()));

            var curProject = ProjectManager.GetProjectById(projectId);

            if (curProject == null)
                throw new ArgumentException("Project not found for ProjectID.");

            var cats = CategoryManager.GetCategoriesByProjectId(projectId);
            var statuses = StatusManager.GetStatusByProjectId(projectId);
            var priorities = PriorityManager.GetPrioritiesByProjectId(projectId);
            var issueTypes = IssueTypeManager.GetIssueTypesByProjectId(projectId);
            var resolutions = ResolutionManager.GetResolutionsByProjectId(projectId);
            var affectedMilestones = MilestoneManager.GetMilestoneByProjectId(projectId);
            var milestones = MilestoneManager.GetMilestoneByProjectId(projectId);

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
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetOpenIssues(projectId));
        }


        /// <summary>
        /// Performs the query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public static List<Issue> PerformQuery(int projectId, List<QueryClause> queryClauses)
        {
            if (queryClauses.Count == 0)
                throw new ArgumentOutOfRangeException("queryClauses");

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
            if (queryId <= DefaultValues.GetQueryIdMinValue())
                throw (new ArgumentOutOfRangeException("queryId"));

            return DataProviderManager.Provider.PerformSavedQuery(projectId, queryId);
        }

        //public static bool IsValidId(int issueId)
        //{
        //    bool isValid = false;
        //    Issue requestedIssue = null;

        //    requestedIssue = DataProviderManager.Provider.GetIssueById(issueId);

        //    isValid = requestedIssue != null;

        //    return isValid;
        //}
        #endregion
    }
}
