using System;
using System.Collections.Generic;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;

namespace BugNET.BLL
{
    /// <summary>
    /// Manager class for issues
    /// </summary>
    public class IssueManager
    {
        #region Instance Methods
        /// <summary>
        /// Saves the bug
        /// </summary>
        /// <param name="issueToSave">The issue to save.</param>
        /// <returns></returns>
        public static bool SaveIssue(Issue issueToSave)
        {
            if (issueToSave.Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewIssue(issueToSave);

                if (TempId > 0)
                {
                    issueToSave.Id = TempId;
                    //add vote
                    IssueVote vote = new IssueVote(issueToSave.Id, issueToSave.CreatorUserName);
                    IssueVoteManager.SaveIssueVote(vote);


                    //TOOD: handle adding an attachment for new issue.

                    //send notifications for add issue
                    IssueNotificationManager.SendIssueAddNotifications(issueToSave.Id);

                    return true;
                }
                else
                    return false;
            }
            else
            {
                List<IssueHistory> issueChanges = GetIssueChanges(IssueManager.GetIssueById(issueToSave.Id), issueToSave);
                
                if (issueChanges.Count > 0)
                {
                    bool result = DataProviderManager.Provider.UpdateIssue(issueToSave);
                    if (result)
                    {
                        IssueManager.UpdateIssueHistory(issueChanges);

                        IssueNotificationManager.SendIssueNotifications(issueToSave.Id, issueChanges);
                        if (issueToSave.SendNewAssigneeNotification)
                        {
                            //add this user to notifications and send them a notification
                            IssueNotification issueNotification = new IssueNotification(issueToSave.Id, issueToSave.AssignedUserName);
                            
                            IssueNotificationManager.SaveIssueNotification(issueNotification);
                            IssueNotificationManager.SendNewAssigneeNotification(issueToSave.Id, issueToSave.AssignedDisplayName);
                        }
                    }
                    return result;
                }

                return true;
            }
        }

        /// <summary>
        /// Updates the IssueHistory objects in the changes array list
        /// </summary>
        /// <param name="issueChanges">The issue changes.</param>
        private static void UpdateIssueHistory(List<IssueHistory> issueChanges)
        {
            foreach (IssueHistory issueHistory in issueChanges)
               IssueHistoryManager.SaveIssueHistory(issueHistory);
        }

        /// <summary>
        /// Gets the issue changes.
        /// </summary>
        /// <param name="originalIssue">The original issue.</param>
        /// <param name="issueToCompare">The issue to compare.</param>
        /// <param name="creatorUsername">The creator username.</param>
        /// <returns></returns>
        public static List<IssueHistory> GetIssueChanges(Issue originalIssue, Issue issueToCompare)
        {
            List<IssueHistory> issueChanges = new List<IssueHistory>();

            if (originalIssue != null && issueToCompare != null)
            {
                string createdUserName = issueToCompare.CreatorUserName;

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
                if (originalIssue.MilestoneId !=issueToCompare. MilestoneId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Milestone", originalIssue.MilestoneName, issueToCompare.MilestoneName));
                if (originalIssue.AffectedMilestoneId != issueToCompare.AffectedMilestoneId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Affected Milestone", originalIssue.AffectedMilestoneName, issueToCompare.AffectedMilestoneName));
                if (originalIssue.IssueTypeId != issueToCompare.IssueTypeId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Issue Type", originalIssue.IssueTypeName, issueToCompare.IssueTypeName));
                if (originalIssue.ResolutionId != issueToCompare.ResolutionId)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Resolution", originalIssue.ResolutionName, issueToCompare.ResolutionName));

                string newAssignedUserName = String.IsNullOrEmpty(originalIssue.AssignedUserName) ? Globals.UnassignedDisplayText : issueToCompare.AssignedUserName;

                if ((originalIssue.AssignedUserName != newAssignedUserName))
                {
                    // if the new assigned user is the unassigned user then don't trigger the new assignee notification
                    originalIssue.SendNewAssigneeNotification = (newAssignedUserName != Globals.UnassignedDisplayText);
                    originalIssue.NewAssignee = true;

                    string newAssignedDisplayName = (newAssignedUserName == Globals.UnassignedDisplayText) ? newAssignedUserName :
                        UserManager.GetUserDisplayName(newAssignedUserName);
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Assigned to", originalIssue.AssignedDisplayName, newAssignedDisplayName));
                }
                if (originalIssue.OwnerUserName != issueToCompare.OwnerUserName)
                {
                    string newOwnerDisplayName = UserManager.GetUserDisplayName(issueToCompare.OwnerUserName);
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Owner", originalIssue.OwnerDisplayName, newOwnerDisplayName));
                }
                if (originalIssue.Estimation != issueToCompare.Estimation)
                    issueChanges.Add(new IssueHistory(originalIssue.Id, createdUserName, "Estimation", IssueManager.EstimationToString(originalIssue.Estimation), IssueManager.EstimationToString(issueToCompare.Estimation)));
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
            int issueSum = 0;

            // calculate the total issues count
            foreach (IssueCount issueCount in issueCountList)
            {
                issueSum += issueCount.Count;
            }

            // update each issue percentage
            foreach (IssueCount issueCount in issueCountList)
            {
                if (issueSum != 0)
                    issueCount.Percentage = Math.Round((decimal)((issueCount.Count * 100) / issueSum));
                else
                    issueCount.Percentage = 0;
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
        /// Gets the bug status count by project.
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
        /// Gets the bug version count by project.
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
        /// Gets the bug priority count by project.
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
        /// Gets the bug user count by project.
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
        /// Gets the bug type count by project.
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
        /// <param name="IssueTypeId">The type id.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="AssignedToUserName">Name of the assigned to user.</param>
        /// <param name="resolutionId">The resolution id.</param>
        /// <param name="keywords">The keywords.</param>
        /// <param name="excludeClosed">if set to <c>true</c> [exclude closed].</param>
        /// <param name="reporterUserName">Name of the reporter user.</param>
        /// <param name="fixedInVersionId">The fixed in version id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCriteria(int projectId, int componentId, int versionId, int IssueTypeId,
                int priorityId, int statusId, string AssignedToUserName,
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
        /// <param name="AssignedName">The Assigned To username.</param> 
        /// <param name="OwnerName">The owner and reporter username.</param> 
        /// <returns></returns>
        public static Issue GetDefaultIssueByProjectId(int projectId, string Title, string Description, string AssignedName, string OwnerName)
        {
            if (projectId < DefaultValues.GetProjectIdMinValue())
                throw new ArgumentOutOfRangeException(string.Format("ProjectID must be {0} or larger.", DefaultValues.GetProjectIdMinValue()));

            Project CurProject = ProjectManager.GetProjectById(projectId);

            if (CurProject == null)
                throw new ArgumentException("Project not found for ProjectID.");

            List<Category> Cats = CategoryManager.GetCategoriesByProjectId(projectId);
            Category defCat = null;
            List<Status> Statuses = StatusManager.GetStatusByProjectId(projectId);
            Status defStatus = null;
            List<Priority> Priorities = PriorityManager.GetPrioritiesByProjectId(projectId);
            Priority defPriority = null;
            List<IssueType> IssueTypes = IssueTypeManager.GetIssueTypesByProjectId(projectId);
            IssueType defIssueType = null;
            List<Resolution> Resolutions = ResolutionManager.GetResolutionsByProjectId(projectId);
            Resolution defResolution = null;
            List<Milestone> AffectedMilestones = MilestoneManager.GetMilestoneByProjectId(projectId);
            Milestone defAffectedMilestone = null;
            List<Milestone> Milestones = MilestoneManager.GetMilestoneByProjectId(projectId);
            Milestone defMilestone = null;

            // Select the first one in the list, not really the default intended.
            defCat = Cats[0];
            defStatus = Statuses[0];
            defPriority = Priorities[0];
            defIssueType = IssueTypes[0];
            defResolution = Resolutions[0];
            defAffectedMilestone = AffectedMilestones[0];
            defMilestone = Milestones[0];

            // Now create an issue                
            Issue iss = new Issue(0, projectId, Title, Description, defCat.Id, defPriority.Id, defStatus.Id,
                defIssueType.Id, defMilestone.Id, defAffectedMilestone.Id, defResolution.Id,
                OwnerName, AssignedName, OwnerName, 0, 0, DateTime.MinValue);

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

        /// <summary>
        /// Checks the Issue ID passed in to verify that it exists.
        /// </summary>
        /// <param name="issueId">Issue ID to check</param>
        /// <returns>True if the ID is valid. False otherwise.</returns>
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
