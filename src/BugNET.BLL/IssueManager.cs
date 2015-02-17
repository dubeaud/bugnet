using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
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

        /// <summary>
        /// Saves the issue
        /// </summary>
        /// <param name="entity">The issue to save.</param>
        /// <returns></returns>
        public static bool SaveOrUpdate(Issue entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (entity.ProjectId <= Globals.NEW_ID) throw (new ArgumentException("The issue project id is invalid"));
            if (string.IsNullOrEmpty(entity.Title)) throw (new ArgumentException("The issue title cannot be empty or null"));

            try
            {
                if (entity.Id <= Globals.NEW_ID)
                {
                    var tempId = DataProviderManager.Provider.CreateNewIssue(entity);

                    if (tempId > 0)
                    {
                        entity.Id = tempId;
                        return true;
                    }

                    return false;
                }

                // this is here due to issue with updating the issue from the Mailbox reader
                // to fix the inline images.  we don't have an http context so we are limited to what we can
                // do from here.  in any case the mailbox reader is creating and updating concurrently so
                // we are not missing anything.
                if (HttpContext.Current != null)
                {
                    //existing issue
                    entity.LastUpdate = DateTime.Now;
                    entity.LastUpdateUserName = Security.GetUserName();

                    var issueChanges = GetIssueChanges(GetById(entity.Id), entity);

                    DataProviderManager.Provider.UpdateIssue(entity);

                    UpdateHistory(issueChanges);

                    IssueNotificationManager.SendIssueNotifications(entity.Id, issueChanges);

                    if (entity.SendNewAssigneeNotification)
                    {
                        //add this user to notifications and send them a notification
                        var notification = new IssueNotification
                            {
                                IssueId = entity.Id,
                                NotificationUsername = entity.AssignedUserName,
                                NotificationCulture = string.Empty
                            };

                        var profile = new WebProfile().GetProfile(entity.AssignedUserName);
                        if (profile != null && !string.IsNullOrWhiteSpace(profile.PreferredLocale))
                        {
                            notification.NotificationCulture = profile.PreferredLocale;
                        }

                        IssueNotificationManager.SaveOrUpdate(notification);
                        IssueNotificationManager.SendNewAssigneeNotification(notification);
                    }
                }
                else
                {
                    DataProviderManager.Provider.UpdateIssue(entity);
                }

                return true;
            }
            catch (Exception ex)
            {
                Log.Error(LoggingManager.GetErrorMessageResource("SaveIssueError"), ex);
                return false;
            }
        }

        /// <summary>
        /// Updates the IssueHistory objects in the changes array list
        /// </summary>
        /// <param name="issueChanges">The issue changes.</param>
        private static void UpdateHistory(IEnumerable<IssueHistory> issueChanges)
        {
            if (issueChanges == null) return;

            foreach (var issueHistory in issueChanges)
            {
                issueHistory.TriggerLastUpdateChange = false; // set this to false since we don't trigger it from here
                IssueHistoryManager.SaveOrUpdate(issueHistory);
            }
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

                var unassignedLiteral = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Unassigned", "Unassigned");

                var newAssignedUserName = String.IsNullOrEmpty(issueToCompare.AssignedUserName) ? unassignedLiteral : issueToCompare.AssignedUserName;

                if (originalIssue.AssignedUserName != newAssignedUserName)
                {
                    // if the new assigned user is the unassigned user then don't trigger the new assignee notification
                    issueToCompare.SendNewAssigneeNotification = (newAssignedUserName != unassignedLiteral);
                    issueToCompare.NewAssignee = true;
                    var newAssignedDisplayName = (newAssignedUserName == unassignedLiteral) ? newAssignedUserName : UserManager.GetUserDisplayName(newAssignedUserName);
                    issueChanges.Add(GetNewIssueHistory(history, "Assigned to", originalIssue.AssignedDisplayName, newAssignedDisplayName));
                }

                var newOwnerUserName = String.IsNullOrEmpty(issueToCompare.OwnerUserName) ? unassignedLiteral : issueToCompare.OwnerUserName;

                if (originalIssue.OwnerUserName != newOwnerUserName)
                {
                    var newOwnerDisplayName = (newOwnerUserName == unassignedLiteral) ? newOwnerUserName : UserManager.GetUserDisplayName(issueToCompare.OwnerUserName);
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
                {
                    var nfi = new NumberFormatInfo { PercentDecimalDigits = 0 };

                    var oldProgress = originalIssue.Progress.Equals(0) ? 0 : (originalIssue.Progress.To<double>() / 100);
                    var newProgress = issueToCompare.Progress.Equals(0) ? 0 : (issueToCompare.Progress.To<double>() / 100);

                    issueChanges.Add(GetNewIssueHistory(history, "Progress", oldProgress.ToString("P", nfi), newProgress.ToString("P", nfi)));
                }
            }
            else
            {
                throw new Exception("Unable to retrieve original issue data");
            }

            return issueChanges;
        }

        /// <summary>
        /// Gets the new issue history.
        /// </summary>
        /// <param name="history">The history.</param>
        /// <param name="fieldChanged">The field changed.</param>
        /// <param name="oldValue">The old value.</param>
        /// <param name="newValue">The new value.</param>
        /// <returns></returns>
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
                var count = (decimal)issueCount.Count;

                if (count == 0)
                {
                    issueCount.Percentage = 0;
                }
                else
                {
                    var value = (count / issueSum) * 100;
                    value = Math.Round(value, MidpointRounding.ToEven); // might help make the percentages closer to 100% on UI
                    issueCount.Percentage = issueSum != 0 ? value : 0;
                }
            }

            return issueCountList;
        }

        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static Issue GetById(int issueId)
        {
            if (issueId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("issueId"));

            var issue = DataProviderManager.Provider.GetIssueById(issueId);
            LocalizeUnassigned(issue);
            return issue;
        }

        /// <summary>
        /// Gets the bugs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            var list = DataProviderManager.Provider.GetIssuesByProjectId(projectId);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Gets the issue status count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetStatusCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueStatusCountByProject(projectId));
        }

        /// <summary>
        /// Gets the issue version count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetMilestoneCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueMilestoneCountByProject(projectId));
        }
        /// <summary>
        /// Gets the issue priority count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetPriorityCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssuePriorityCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue user count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetUserCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUserCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unassigned count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetUnassignedCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnassignedCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unscheduled milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetUnscheduledMilestoneCountByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnscheduledMilestoneCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue type count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetTypeCountByProjectId(int projectId)
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
        public static int GetCountByProjectAndCategoryId(int projectId, int categoryId = 0)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueCountByProjectAndCategory(projectId, categoryId);
        }

        /// <summary>
        /// Deletes the issue
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static bool Delete(int issueId)
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
        public static List<Issue> GetByAssignedUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            var list = DataProviderManager.Provider.GetIssuesByAssignedUserName(projectId, username);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Gets the issues by creator username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetByCreatorUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            var list = DataProviderManager.Provider.GetIssuesByCreatorUserName(projectId, username);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Gets the issues by owner username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetByOwnerUserName(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            var list = DataProviderManager.Provider.GetIssuesByOwnerUserName(projectId, username);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Gets the issues by relevancy.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetByRelevancy(int projectId, string username)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));
            if (string.IsNullOrEmpty(username)) throw (new ArgumentOutOfRangeException("username"));

            var list = DataProviderManager.Provider.GetIssuesByRelevancy(projectId, username);
            LocalizeUnassigned(list);
            return list;
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

            var list = DataProviderManager.Provider.GetMonitoredIssuesByUserName(username, excludeClosedStatus);
            LocalizeUnassigned(list);
            return list;
        }

        public static List<Issue> GetMonitoredIssuesByUserName(object userId, ICollection<KeyValuePair<string, string>> sortFields, List<int> projects, bool excludeClosedStatus)
        {
            if (userId == null) throw (new ArgumentOutOfRangeException("userId"));

            var list = DataProviderManager.Provider.GetMonitoredIssuesByUserName(userId, sortFields, projects, excludeClosedStatus);
            LocalizeUnassigned(list);
            return list;
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
        public static Issue GetDefaultIssueByProjectId(int projectId, string title, string description, int issueTypeId, string assignedName, string ownerName)
        {
            if (projectId <= Globals.NEW_ID)
                throw new ArgumentException(string.Format(LoggingManager.GetErrorMessageResource("InvalidProjectId"), projectId));

            var curProject = ProjectManager.GetById(projectId);

            if (curProject == null)
                throw new ArgumentException(string.Format(LoggingManager.GetErrorMessageResource("ProjectNotFoundError"), projectId));

            var issue = new Issue()
            {
                ProjectId = projectId
            };

            SetDefaultValues(issue);

            issue.Id = Globals.NEW_ID;
            issue.Title = title;
            issue.CreatorUserName = ownerName;
            issue.DateCreated = DateTime.Now;
            issue.Description = description;
            issue.IssueTypeId = issueTypeId;
            issue.AssignedUserName = assignedName;
            issue.OwnerUserName = ownerName;

            return issue;
        }

        /// <summary>
        /// Applies project default values to the issue
        /// </summary>
        /// <param name="issue">Issue that will be initialized with default values</param>
        private static void SetDefaultValues(Issue issue)
        {

            List<DefaultValue> defValues = IssueManager.GetDefaultIssueTypeByProjectId(issue.ProjectId);
            DefaultValue selectedValue = defValues.FirstOrDefault();

            if (selectedValue != null)
            {
                issue.IssueTypeId = selectedValue.IssueTypeId;
                issue.PriorityId = selectedValue.PriorityId;
                issue.ResolutionId = selectedValue.ResolutionId;
                issue.CategoryId = selectedValue.CategoryId;
                issue.MilestoneId = selectedValue.MilestoneId;
                issue.AffectedMilestoneId = selectedValue.AffectedMilestoneId;

                if (selectedValue.AssignedUserName != "none")
                    issue.AssignedUserName = selectedValue.AssignedUserName;

                if (selectedValue.OwnerUserName != "none")
                    issue.OwnerUserName = selectedValue.OwnerUserName;

                issue.StatusId = selectedValue.StatusId;

                issue.Visibility = selectedValue.IssueVisibility;

                if (selectedValue.DueDate.HasValue)
                {
                    DateTime date = DateTime.Today;
                    date = date.AddDays(selectedValue.DueDate.Value);
                    issue.DueDate = date;
                }

                issue.Progress = selectedValue.Progress;
                issue.Estimation = selectedValue.Estimation;
            }
        }


        /// <summary>
        /// Gets the open issues.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetOpenIssues(int projectId)
        {
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            var list = DataProviderManager.Provider.GetOpenIssues(projectId);
            LocalizeUnassigned(list);
            return list;
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

            var list = DataProviderManager.Provider.PerformQuery(queryClauses, null, projectId);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Performs the query.
        /// </summary>
        /// <param name="queryClauses">The query clauses.</param>
        /// <param name="sortColumns">key value pair of sort fields and directions</param>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> PerformQuery(List<QueryClause> queryClauses, ICollection<KeyValuePair<string, string>> sortColumns, int projectId = 0)
        {
            var list = DataProviderManager.Provider.PerformQuery(queryClauses, sortColumns, projectId);
            LocalizeUnassigned(list);
            return list;
        }

        /// <summary>
        /// Performs the saved query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryId">The query id.</param>
        /// <param name="sortColumns">key value pair of sort fields and directions</param>
        /// <returns></returns>
        public static List<Issue> PerformSavedQuery(int projectId, int queryId, ICollection<KeyValuePair<string, string>> sortColumns)
        {
            if (queryId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("queryId"));
            if (projectId <= Globals.NEW_ID) throw (new ArgumentOutOfRangeException("projectId"));

            var list = DataProviderManager.Provider.PerformSavedQuery(projectId, queryId, sortColumns);
            LocalizeUnassigned(list);
            return list;
        }

        private static bool NeedLocalize
        {
            get { return System.Threading.Thread.CurrentThread.CurrentUICulture.Name != "en-US"; }
        }

        private static void LocalizeUnassigned(List<Issue> issues)
        {
            if (NeedLocalize)
            {
                var s = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Unassigned", "Unassigned");

                foreach (var issue in issues)
                {
                    LocalizeUnassigned(issue, s);
                }
            }
        }

        private static void LocalizeUnassigned(Issue issue)
        {
            if (NeedLocalize)
                LocalizeUnassigned(issue, ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Unassigned", "Unassigned"));
        }

        private static void LocalizeUnassigned(Issue issue, string unassignedLiteral)
        {
            if (issue.AffectedMilestoneId == 0) issue.AffectedMilestoneName = unassignedLiteral;
            if (issue.AssignedUserId == Guid.Empty) issue.AssignedDisplayName = issue.AssignedUserName = unassignedLiteral;
            if (issue.CategoryId == 0) issue.CategoryName = unassignedLiteral;
            if (issue.CreatorUserId == Guid.Empty) issue.CreatorDisplayName = issue.CreatorUserName = unassignedLiteral;
            if (issue.IssueTypeId == 0) issue.IssueTypeName = unassignedLiteral;
            if (issue.MilestoneId == 0) issue.MilestoneName = unassignedLiteral;
            if (issue.OwnerUserId == Guid.Empty) issue.OwnerDisplayName = issue.OwnerUserName = unassignedLiteral;
            if (issue.PriorityId == 0) issue.PriorityName = unassignedLiteral;
            if (issue.ResolutionId == 0) issue.ResolutionName = unassignedLiteral;
            if (issue.StatusId == 0) issue.StatusName = unassignedLiteral;
        }

        /// <summary>
        /// Validates the issue by fetching the issue from the database
        /// </summary>
        /// <param name="issueId">The issue Id to search for</param>
        /// <returns></returns>
        public static bool IsValidId(int issueId)
        {
            var issue = GetById(issueId);

            return (issue != null);
        }

        /// <summary>
        /// Removes private issues from the list when the requesting user does not have the permission to view it
        /// </summary>
        /// <param name="issues">The list of issues to validate</param>
        /// <param name="requestingUserName">The requesting user</param>
        /// <returns></returns>
        public static IEnumerable<Issue> StripPrivateIssuesForRequestor(IEnumerable<Issue> issues, string requestingUserName)
        {
            // if the current user is a super user don't bother checking at all
            if (UserManager.IsSuperUser()) return issues;

            return issues.Where(issue => CanViewIssue(issue, requestingUserName)).ToList();
        }

        /// <summary>
        /// Returns true or false if the requesting user can view the issue or not
        /// </summary>
        /// <param name="issue">The issue to be viewed</param>
        /// <param name="requestingUserName">The requesting user name (Use Security.GetUserName()) for this</param>
        /// <returns></returns>
        public static bool CanViewIssue(Issue issue, string requestingUserName)
        {
            // if the current user is a super user don't bother checking at all
            if (UserManager.IsSuperUser()) return true;

            // if the issue is private and current user does not have project admin rights
            if (issue.Visibility == IssueVisibility.Private.To<int>() && !UserManager.IsInRole(issue.ProjectId, Globals.ProjectAdminRole))
            {
                // if the current user is either the assigned / creator / owner then they can see the private issue
                return (
                    issue.AssignedUserName.Trim().Equals(requestingUserName.Trim()) ||
                    issue.CreatorUserName.Trim().Equals(requestingUserName.Trim()) ||
                    issue.OwnerUserName.Trim().Equals(requestingUserName.Trim())
                );
            }

            return true;
        }


        /// <summary>
        /// Gets the default issue type by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        /// <exception cref="System.ArgumentOutOfRangeException">projectId</exception>
        public static List<DefaultValue> GetDefaultIssueTypeByProjectId(int projectId)
        {
            if (projectId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetDefaultIssueTypeByProjectId(projectId));
        }

        /// <summary>
        /// Saves the default values.
        /// </summary>
        /// <param name="defaultValues">The default values.</param>
        /// <returns></returns>
        public static bool SaveDefaultValues(DefaultValue defaultValues)
        {
            return DataProviderManager.Provider.SetDefaultIssueTypeByProjectId(defaultValues);
        }
    }
}
