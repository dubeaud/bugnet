using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.Providers.DataProviders
{
    public partial class SqlDataProvider
    {
        public const string TOTAL_ROW_COUNT_FIELD_NAME = "TotalRecordCount";

        /// <summary>
        /// Ts the generate issue comment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCommentList">The issue comment list.</param>
        private static int GenerateIssueCommentListFromReader(IDataReader returnData, ref List<IssueComment> issueCommentList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                issueCommentList.Add(new IssueComment
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueCommentId")),
                    Comment = returnData.GetString(returnData.GetOrdinal("Comment")),
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    CreatorUserId = returnData.GetGuid(returnData.GetOrdinal("CreatorUserId"))
                });

                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue count list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCountList">The issue count list.</param>
        private static int GenerateIssueCountListFromReader(IDataReader returnData, ref List<IssueCount> issueCountList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var issueCount = new IssueCount(
                    returnData.GetValue(2),
                    (string)returnData.GetValue(0),
                    (int)returnData.GetValue(1),
                    (string)returnData.GetValue(3)
                );
                issueCountList.Add(issueCount);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static int GenerateIssueListFromReader(IDataReader returnData, ref List<Issue> issueList)
        {
            var totalRowCount = 0;
            var hasRowCountColumn = returnData.HasColumn(TOTAL_ROW_COUNT_FIELD_NAME);
            var populated = false;

            while (returnData.Read())
            {
                if (!populated && hasRowCountColumn) totalRowCount = returnData.GetInt32(returnData.GetOrdinal(TOTAL_ROW_COUNT_FIELD_NAME));

                populated = true;
                issueList.Add(MapIssue(returnData));
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate installed resources list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="cultureCodes">The culture codes.</param>
        private static int GenerateInstalledResourcesListFromReader(IDataReader returnData, ref List<string> cultureCodes)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                cultureCodes.Add((string)returnData["cultureCode"]);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue history list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueHistoryList">The issue history list.</param>
        private static int GenerateIssueHistoryListFromReader(IDataReader returnData, ref List<IssueHistory> issueHistoryList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                issueHistoryList.Add(new IssueHistory
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueHistoryId")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    CreatedUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    FieldChanged = returnData.GetString(returnData.GetOrdinal("FieldChanged")),
                    NewValue = returnData.GetString(returnData.GetOrdinal("NewValue")),
                    OldValue = returnData.GetString(returnData.GetOrdinal("OldValue")),
                    DateChanged = returnData.GetDateTime(returnData.GetOrdinal("DateCreated"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueNotificationList">The issue notification list.</param>
        private static int GenerateIssueNotificationListFromReader(IDataReader returnData, ref List<IssueNotification> issueNotificationList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                issueNotificationList.Add(new IssueNotification
                {
                    Id = 1,
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    NotificationUsername = returnData.GetString(returnData.GetOrdinal("NotificationUsername")),
                    NotificationEmail = returnData.GetString(returnData.GetOrdinal("NotificationEmail")),
                    NotificationDisplayName = returnData.GetString(returnData.GetOrdinal("NotificationDisplayName"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate host setting list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="hostsettingList">The hostsetting list.</param>
        private static int GenerateHostSettingListFromReader(IDataReader returnData, ref List<HostSetting> hostsettingList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                hostsettingList.Add(new HostSetting
                {
                    SettingName = returnData.GetString(returnData.GetOrdinal("SettingName")),
                    SettingValue = returnData.GetString(returnData.GetOrdinal("SettingValue"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate role list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="roleList">The role list.</param>
        private static int GenerateRoleListFromReader(IDataReader returnData, ref List<Role> roleList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                roleList.Add(new Role
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("RoleId")),
                    ProjectId = (returnData["ProjectId"] != DBNull.Value) ? returnData.GetInt32(returnData.GetOrdinal("ProjectId")) : 0,
                    Name = returnData.GetString(returnData.GetOrdinal("RoleName")),
                    AutoAssign = returnData.GetBoolean(returnData.GetOrdinal("AutoAssign")),
                    Description = returnData.GetString(returnData.GetOrdinal("RoleDescription")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate role permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="rolePermissionList">The role permission list.</param>
        private static int GenerateRolePermissionListFromReader(SqlDataReader returnData, ref List<RolePermission> rolePermissionList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var permission = new RolePermission((int)returnData["PermissionId"], (int)returnData["ProjectId"], returnData["RoleName"].ToString(),
                    returnData["PermissionName"].ToString(), returnData["PermissionKey"].ToString());
                rolePermissionList.Add(permission);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="permissionList">The permission list.</param>
        private static int GeneratePermissionListFromReader(SqlDataReader returnData, ref List<Permission> permissionList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var permission = new Permission((int)returnData["PermissionId"], returnData["PermissionName"].ToString(), returnData["PermissionKey"].ToString());
                permissionList.Add(permission);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate user list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="userList">The user list.</param>
        private static int GenerateUserListFromReader(SqlDataReader returnData, ref List<ITUser> userList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var user = new ITUser((Guid)returnData["UserId"], (string)returnData["UserName"], (string)returnData["DisplayName"]);
                userList.Add(user);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate project list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectList">The project list.</param>
        private static int GenerateProjectListFromReader(IDataReader returnData, ref List<Project> projectList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                projectList.Add(new Project
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("ProjectName")),
                    Description = returnData.GetString(returnData.GetOrdinal("ProjectDescription")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    AllowAttachments = returnData.GetBoolean(returnData.GetOrdinal("AllowAttachments")),
                    AccessType = (Globals.ProjectAccessType)returnData["ProjectAccessType"],
                    AllowIssueVoting = returnData.GetBoolean(returnData.GetOrdinal("AllowIssueVoting")),
                    AttachmentStorageType = (IssueAttachmentStorageTypes)returnData["AttachmentStorageType"],
                    Code = returnData.GetString(returnData.GetOrdinal("ProjectCode")),
                    Disabled = returnData.GetBoolean(returnData.GetOrdinal("ProjectDisabled")),
                    ManagerDisplayName = returnData.GetString(returnData.GetOrdinal("ManagerDisplayName")),
                    ManagerId = returnData.GetGuid(returnData.GetOrdinal("ProjectManagerUserId")),
                    ManagerUserName = returnData.GetString(returnData.GetOrdinal("ManagerUserName")),
                    SvnRepositoryUrl = returnData.GetString(returnData.GetOrdinal("SvnRepositoryUrl")),
                    UploadPath = returnData.GetString(returnData.GetOrdinal("AttachmentUploadPath")),
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate member roles list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="memberRoleList">The member roles list.</param>
        private static int GenerateProjectMemberRoleListFromReader(SqlDataReader returnData, ref List<MemberRoles> memberRoleList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                int i;
                var found = false;
                for (i = 0; i < memberRoleList.Count; i++)
                {
                    if (!memberRoleList[i].Username.Equals((string)returnData.GetValue(0))) continue;
                    memberRoleList[i].AddRole((string)returnData.GetValue(1));
                    found = true;
                }

                if (found) continue;

                var memberRoles = new MemberRoles((string)returnData.GetValue(0), (string)returnData.GetValue(1));
                memberRoleList.Add(memberRoles);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate roadmap issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static int GenerateRoadmapIssueListFromReader(IDataReader returnData, ref List<RoadMapIssue> issueList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var issue = MapIssue(returnData);

                if (issue == null) continue;

                var rmIssue = new RoadMapIssue(issue, returnData.GetInt32(returnData.GetOrdinal("MilestoneSortOrder")));
                issueList.Add(rmIssue);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate project notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectNotificationList">The project notification list.</param>
        private static int GenerateProjectNotificationListFromReader(IDataReader returnData, ref List<ProjectNotification> projectNotificationList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                projectNotificationList.Add(new ProjectNotification
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("ProjectNotificationId")),
                    NotificationDisplayName = returnData.GetString(returnData.GetOrdinal("NotificationDisplayName")),
                    NotificationEmail = returnData.GetString(returnData.GetOrdinal("NotificationEmail")),
                    NotificationUsername = returnData.GetString(returnData.GetOrdinal("NotificationUsername")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    ProjectName = returnData.GetString(returnData.GetOrdinal("ProjectName"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate category list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="categoryList">The category list.</param>
        private static int GenerateCategoryListFromReader(IDataReader returnData, ref List<Category> categoryList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                categoryList.Add(new Category
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("CategoryId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("CategoryName")),
                    ChildCount = returnData.GetInt32(returnData.GetOrdinal("ChildCount")),
                    ParentCategoryId = returnData.GetInt32(returnData.GetOrdinal("ParentCategoryId")),
                    IssueCount = returnData.GetInt32(returnData.GetOrdinal("IssueCount")),
                    Disabled = returnData.GetBoolean(returnData.GetOrdinal("Disabled"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue attachment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueAttachmentList">The issue attachment list.</param>
        private static int GenerateIssueAttachmentListFromReader(IDataReader returnData, ref List<IssueAttachment> issueAttachmentList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var attachment = new IssueAttachment
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueAttachmentId")),
                    Attachment = null,
                    Description = returnData.GetString(returnData.GetOrdinal("Description")),
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                    ContentType = returnData.GetString(returnData.GetOrdinal("ContentType")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                    FileName = returnData.GetString(returnData.GetOrdinal("FileName")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    Size = returnData.GetInt32(returnData.GetOrdinal("FileSize"))
                };

                issueAttachmentList.Add(attachment);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate query clause list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryClauseList">The query clause list.</param>
        private static int GenerateQueryClauseListFromReader(IDataReader returnData, ref List<QueryClause> queryClauseList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var queryClause = new QueryClause((string)returnData["BooleanOperator"], (string)returnData["FieldName"], (string)returnData["ComparisonOperator"], (string)returnData["FieldValue"], (SqlDbType)returnData["DataType"], (bool)returnData["IsCustomField"]);
                queryClauseList.Add(queryClause);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate query list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryList">The query list.</param>
        private static int GenerateQueryListFromReader(IDataReader returnData, ref List<Query> queryList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                queryList.Add(new Query
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("QueryId")),
                    Name = returnData.GetString(returnData.GetOrdinal("QueryName")),
                    IsPublic = returnData.GetBoolean(returnData.GetOrdinal("IsPublic"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate required field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="requiredFieldList">The required field list.</param>
        private static int GenerateRequiredFieldListFromReader(SqlDataReader returnData, ref List<RequiredField> requiredFieldList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var newRequiredField = new RequiredField(returnData["FieldName"].ToString(), returnData["FieldValue"].ToString());
                requiredFieldList.Add(newRequiredField);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate related issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="relatedIssueList">The related issue list.</param>
        private static int GenerateRelatedIssueListFromReader(IDataReader returnData, ref List<RelatedIssue> relatedIssueList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var relatedIssue = new RelatedIssue
                {
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    Resolution = DefaultIfNull(returnData["IssueResolution"], string.Empty),
                    Status = DefaultIfNull(returnData["IssueStatus"], string.Empty),
                    Title = returnData.GetString(returnData.GetOrdinal("IssueTitle"))
                };

                relatedIssueList.Add(relatedIssue);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue revision list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="revisionList">The revision list.</param>
        private static int GenerateIssueRevisionListFromReader(IDataReader returnData, ref List<IssueRevision> revisionList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                revisionList.Add(new IssueRevision
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueRevisionId")),
                    Author = returnData.GetString(returnData.GetOrdinal("RevisionAuthor")),
                    DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    Message = returnData.GetString(returnData.GetOrdinal("RevisionMessage")),
                    Repository = returnData.GetString(returnData.GetOrdinal("Repository")),
                    RevisionDate = returnData.GetString(returnData.GetOrdinal("RevisionDate")),
                    Revision = returnData.GetInt32(returnData.GetOrdinal("Revision"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate milestone list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="milestoneList">The milestone list.</param>
        private static int GenerateMilestoneListFromReader(IDataReader returnData, ref List<Milestone> milestoneList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var milestone = new Milestone
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("MilestoneId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("MilestoneName")),
                    DueDate = returnData[returnData.GetOrdinal("MilestoneDueDate")] as DateTime?,
                    ImageUrl = returnData.GetString(returnData.GetOrdinal("MilestoneImageUrl")),
                    ReleaseDate = returnData[returnData.GetOrdinal("MilestoneReleaseDate")] as DateTime?,
                    IsCompleted = returnData.GetBoolean(returnData.GetOrdinal("MilestoneCompleted")),
                    Notes = returnData[returnData.GetOrdinal("MilestoneNotes")] as string ?? string.Empty,
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder"))
                };

                milestoneList.Add(milestone);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate priority list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="priorityList">The priority list.</param>
        private static int GeneratePriorityListFromReader(IDataReader returnData, ref List<Priority> priorityList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                priorityList.Add(new Priority
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("PriorityId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("PriorityName")),
                    ImageUrl = returnData.GetString(returnData.GetOrdinal("PriorityImageUrl")),
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate project mailbox list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectMailboxList">The project mailbox list.</param>
        private static int GenerateProjectMailboxListFromReader(IDataReader returnData, ref List<ProjectMailbox> projectMailboxList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var mailbox = new ProjectMailbox
                {
                    AssignToDisplayName = returnData.GetString(returnData.GetOrdinal("AssignToDisplayName")),
                    AssignToId = returnData["AssignToUserId"] as Guid? ?? Guid.Empty,
                    AssignToUserName = DefaultIfNull(returnData["AssignToUserName"], string.Empty),
                    Id = returnData.GetInt32(returnData.GetOrdinal("ProjectMailboxId")),
                    IssueTypeId = returnData.GetInt32(returnData.GetOrdinal("IssueTypeId")),
                    IssueTypeName = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                    Mailbox = returnData.GetString(returnData.GetOrdinal("Mailbox")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId"))
                };
                projectMailboxList.Add(mailbox);
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate status list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="statusList">The status list.</param>
        private static int GenerateStatusListFromReader(IDataReader returnData, ref List<Status> statusList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                statusList.Add(new Status
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("StatusId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("StatusName")),
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                    ImageUrl = returnData.GetString(returnData.GetOrdinal("StatusImageUrl")),
                    IsClosedState = returnData.GetBoolean(returnData.GetOrdinal("IsClosedState"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate custom field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldList">The custom field list.</param>
        private static int GenerateCustomFieldListFromReader(IDataReader returnData, ref List<CustomField> customFieldList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                customFieldList.Add(new CustomField
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("CustomFieldId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("CustomFieldName")),
                    DataType = (ValidationDataType)returnData["CustomFieldDataType"],
                    FieldType = (CustomFieldType)returnData["CustomFieldTypeId"],
                    Required = returnData.GetBoolean(returnData.GetOrdinal("CustomFieldRequired")),
                    Value = returnData.GetString(returnData.GetOrdinal("CustomFieldValue")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate custom field selection list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldSelectionList">The custom field list.</param>
        private static int GenerateCustomFieldSelectionListFromReader(IDataReader returnData, ref List<CustomFieldSelection> customFieldSelectionList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                customFieldSelectionList.Add(new CustomFieldSelection
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("CustomFieldSelectionId")),
                    CustomFieldId = returnData.GetInt32(returnData.GetOrdinal("CustomFieldId")),
                    Value = returnData.GetString(returnData.GetOrdinal("CustomFieldSelectionValue")),
                    Name = returnData.GetString(returnData.GetOrdinal("CustomFieldSelectionName")),
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("CustomFieldSelectionSortOrder")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue type list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueTypeList">The issue type list.</param>
        private static int GenerateIssueTypeListFromReader(IDataReader returnData, ref List<IssueType> issueTypeList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                issueTypeList.Add(new IssueType
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueTypeId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                    ImageUrl = returnData.GetString(returnData.GetOrdinal("IssueTypeImageUrl")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate issue time entry list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueWorkReportList">The issue time entry list.</param>
        private static int GenerateIssueTimeEntryListFromReader(IDataReader returnData, ref List<IssueWorkReport> issueWorkReportList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                issueWorkReportList.Add(new IssueWorkReport
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("IssueWorkReportId")),
                    CommentId = returnData.GetInt32(returnData.GetOrdinal("IssueCommentId")),
                    CommentText = returnData.GetString(returnData.GetOrdinal("Comment")),
                    CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                    CreatorUserId = returnData.GetGuid(returnData.GetOrdinal("CreatorUserId")),
                    CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),
                    Duration = returnData.GetDecimal(returnData.GetOrdinal("Duration")),
                    IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                    WorkDate = returnData.GetDateTime(returnData.GetOrdinal("WorkDate"))
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate resolution list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="resolutionList">The resolution list.</param>
        private static int GenerateResolutionListFromReader(SqlDataReader returnData, ref List<Resolution> resolutionList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                resolutionList.Add(new Resolution
                {
                    Id = returnData.GetInt32(returnData.GetOrdinal("ResolutionId")),
                    ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                    Name = returnData.GetString(returnData.GetOrdinal("ResolutionName")),
                    SortOrder = returnData.GetInt32(returnData.GetOrdinal("SortOrder")),
                    ImageUrl = returnData.GetString(returnData.GetOrdinal("ResolutionImageUrl")),
                });
                totalRowCount++;
            }

            return totalRowCount;
        }

        /// <summary>
        /// Ts the generate application log list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="applicationLogList">The application log list.</param>
        private static int GenerateApplicationLogListFromReader(IDataReader returnData, ref List<ApplicationLog> applicationLogList)
        {
            var totalRowCount = 0;

            while (returnData.Read())
            {
                var newAppLog = new ApplicationLog
                {
                    Id = (int)returnData["Id"],
                    Date = (DateTime)returnData["Date"],
                    Thread = (string)returnData["Thread"],
                    Level = (string)returnData["Level"],
                    User = (string)returnData["User"],
                    Logger = (string)returnData["Logger"],
                    Message = (string)returnData["Message"],
                    Exception = (string)returnData["Exception"]
                };

                applicationLogList.Add(newAppLog);
                totalRowCount++;
            }

            return totalRowCount;
        }

        private static Issue MapIssue(IDataRecord returnData)
        {
            var time = returnData["TimeLogged"].ToString();
            double timeLogged;
            double.TryParse(time, out timeLogged);

            var entity = new Issue
            {
                AffectedMilestoneId = DefaultIfNull(returnData["IssueAffectedMilestoneId"], 0),
                AffectedMilestoneImageUrl =
                    returnData.GetString(returnData.GetOrdinal("AffectedMilestoneImageUrl")),
                AffectedMilestoneName =
                    returnData.GetString(returnData.GetOrdinal("AffectedMilestoneName")),

                AssignedDisplayName =
                    returnData.GetString(returnData.GetOrdinal("AssignedDisplayName")),
                AssignedUserId = DefaultIfNull(returnData["IssueAssignedUserId"], Guid.Empty),
                AssignedUserName = returnData.GetString(returnData.GetOrdinal("AssignedUserName")),

                CategoryId = DefaultIfNull(returnData["IssueCategoryId"], 0),
                CategoryName = returnData.GetString(returnData.GetOrdinal("CategoryName")),

                CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                CreatorUserId = DefaultIfNull(returnData["IssueCreatorUserId"], Guid.Empty),
                CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUserName")),

                DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                Description = returnData.GetString(returnData.GetOrdinal("IssueDescription")),
                Disabled = returnData.GetBoolean(returnData.GetOrdinal("Disabled")),
                DueDate = DefaultIfNull(returnData["IssueDueDate"], DateTime.MinValue),
                Estimation = returnData.GetDecimal(returnData.GetOrdinal("IssueEstimation")),
                Id = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                IsClosed = returnData.GetBoolean(returnData.GetOrdinal("IsClosed")),

                IssueTypeId = DefaultIfNull(returnData["IssueTypeId"], 0),
                IssueTypeName = returnData.GetString(returnData.GetOrdinal("IssueTypeName")),
                IssueTypeImageUrl = returnData.GetString(returnData.GetOrdinal("IssueTypeImageUrl")),

                LastUpdate = returnData.GetDateTime(returnData.GetOrdinal("LastUpdate")),
                LastUpdateDisplayName =
                    returnData.GetString(returnData.GetOrdinal("LastUpdateDisplayName")),
                LastUpdateUserName = returnData.GetString(returnData.GetOrdinal("LastUpdateUserName")),

                MilestoneDueDate = DefaultIfNull(returnData["MilestoneDueDate"], DateTime.MinValue),
                MilestoneId = DefaultIfNull(returnData["IssueMilestoneId"], 0),
                MilestoneImageUrl = returnData.GetString(returnData.GetOrdinal("MilestoneImageUrl")),
                MilestoneName = returnData.GetString(returnData.GetOrdinal("MilestoneName")),

                OwnerDisplayName = returnData.GetString(returnData.GetOrdinal("OwnerDisplayName")),
                OwnerUserId = DefaultIfNull(returnData["IssueOwnerUserId"], Guid.Empty),
                OwnerUserName = returnData.GetString(returnData.GetOrdinal("OwnerUserName")),

                PriorityId = DefaultIfNull(returnData["IssuePriorityId"], 0),
                PriorityImageUrl = returnData.GetString(returnData.GetOrdinal("PriorityImageUrl")),
                PriorityName = returnData.GetString(returnData.GetOrdinal("PriorityName")),

                Progress = returnData.GetInt32(returnData.GetOrdinal("IssueProgress")),

                ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId")),
                ProjectCode = returnData.GetString(returnData.GetOrdinal("ProjectCode")),
                ProjectName = returnData.GetString(returnData.GetOrdinal("ProjectName")),

                ResolutionId = DefaultIfNull(returnData["IssueResolutionId"], 0),
                ResolutionImageUrl = returnData.GetString(returnData.GetOrdinal("ResolutionImageUrl")),
                ResolutionName = returnData.GetString(returnData.GetOrdinal("ResolutionName")),

                StatusId = DefaultIfNull(returnData["IssueStatusId"], 0),
                StatusImageUrl = returnData.GetString(returnData.GetOrdinal("StatusImageUrl")),
                StatusName = returnData.GetString(returnData.GetOrdinal("StatusName")),

                Title = returnData.GetString(returnData.GetOrdinal("IssueTitle")),
                TimeLogged = timeLogged,
                Visibility = returnData.GetInt32(returnData.GetOrdinal("IssueVisibility")),
                Votes = returnData.GetInt32(returnData.GetOrdinal("IssueVotes"))
            };

            for (var i = 0; i < returnData.FieldCount; i++)
            {
                var field = returnData.GetName(i);
                if (!field.StartsWith("bgn_cf_")) continue;

                field = field.Replace("bgn_cf_", "");
                var value = returnData.GetString(i);
                entity.CustomFieldValues.Add(new KeyValuePair<string, string>(field, value));
            }

            return entity;
        }

        private static T DefaultIfNull<T>(object value, T defaultValue)
        {
            if (value == DBNull.Value) return defaultValue;

            return (T)value;
        }
    }
}
