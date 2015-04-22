using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using BugNET.Common;
using BugNET.Entities;
using Permission = BugNET.Entities.Permission;

namespace BugNET.Providers.DataProviders
{
    public partial class SqlDataProvider
    {
        /// <summary>
        /// 
        /// </summary>
        public const string TOTAL_ROW_COUNT_FIELD_NAME = "TotalRecordCount";

        public void TGenerateDefaultValueListFromReader<T>(SqlDataReader returnData, ref List<DefaultValue> defaultList)
        {
            while (returnData.Read())
            {
                DefaultValue defaultValues = new DefaultValue()
                {
                    IssueTypeId = (int)returnData["DefaultType"],
                    StatusId = (int)returnData["StatusId"],
                    OwnerUserName = (string)returnData["OwnerUserName"],
                    PriorityId = returnData["IssuePriorityId"] == DBNull.Value ? 1 : (int)returnData["IssuePriorityId"],
                    AffectedMilestoneId = returnData["IssueAffectedMilestoneId"] == DBNull.Value ? 1 : (int)returnData["IssueAffectedMilestoneId"],
                    IssueVisibility = returnData["IssueVisibility"] == DBNull.Value ? 0 : (int)returnData["IssueVisibility"],
                    CategoryId = returnData["IssueCategoryId"] == DBNull.Value ? 0 : (int)returnData["IssueCategoryId"],
                    DueDate = returnData["IssueDueDate"] == DBNull.Value ? null : (int?)returnData["IssueDueDate"],
                    Progress = returnData["IssueProgress"] == DBNull.Value ? 0 : (int)returnData["IssueProgress"],
                    MilestoneId = returnData["IssueMilestoneId"] == DBNull.Value ? 0 : (int)returnData["IssueMilestoneId"],
                    Estimation = returnData["IssueEstimation"] == DBNull.Value ? 0 : (decimal)returnData["IssueEstimation"],
                    ResolutionId = returnData["IssueResolutionId"] == DBNull.Value ? 0 : (int)returnData["IssueResolutionId"],
                    StatusVisibility = returnData["StatusVisibility"] == DBNull.Value ? true : (bool)returnData["StatusVisibility"],
                    OwnedByVisibility = returnData["OwnedByVisibility"] == DBNull.Value ? true : (bool)returnData["OwnedByVisibility"],
                    PriorityVisibility = returnData["PriorityVisibility"] == DBNull.Value ? true : (bool)returnData["PriorityVisibility"],
                    AssignedToVisibility = returnData["AssignedToVisibility"] == DBNull.Value ? true : (bool)returnData["AssignedToVisibility"],
                    PrivateVisibility = returnData["PrivateVisibility"] == DBNull.Value ? true : (bool)returnData["PrivateVisibility"],
                    CategoryVisibility = returnData["CategoryVisibility"] == DBNull.Value ? true : (bool)returnData["CategoryVisibility"],
                    DueDateVisibility = returnData["DueDateVisibility"] == DBNull.Value ? true : (bool)returnData["DueDateVisibility"],
                    TypeVisibility = returnData["TypeVisibility"] == DBNull.Value ? true : (bool)returnData["TypeVisibility"],
                    PercentCompleteVisibility = returnData["PercentCompleteVisibility"] == DBNull.Value ? true : (bool)returnData["PercentCompleteVisibility"],
                    MilestoneVisibility = returnData["MilestoneVisibility"] == DBNull.Value ? true : (bool)returnData["MilestoneVisibility"],
                    EstimationVisibility = returnData["EstimationVisibility"] == DBNull.Value ? true : (bool)returnData["EstimationVisibility"],
                    ResolutionVisibility = returnData["ResolutionVisibility"] == DBNull.Value ? true : (bool)returnData["ResolutionVisibility"],
                    AffectedMilestoneVisibility = returnData["AffectedMilestoneVisibility"] == DBNull.Value ? true : (bool)returnData["AffectedMilestoneVisibility"],
                    StatusEditVisibility = returnData["StatusEditVisibility"] == DBNull.Value ? true : (bool)returnData["StatusEditVisibility"],
                    OwnedByEditVisibility = returnData["OwnedByEditVisibility"] == DBNull.Value ? true : (bool)returnData["OwnedByEditVisibility"],
                    PriorityEditVisibility = returnData["PriorityEditVisibility"] == DBNull.Value ? true : (bool)returnData["PriorityEditVisibility"],
                    AssignedToEditVisibility = returnData["AssignedToEditVisibility"] == DBNull.Value ? true : (bool)returnData["AssignedToEditVisibility"],
                    PrivateEditVisibility = returnData["PrivateEditVisibility"] == DBNull.Value ? true : (bool)returnData["PrivateEditVisibility"],
                    CategoryEditVisibility = returnData["CategoryEditVisibility"] == DBNull.Value ? true : (bool)returnData["CategoryEditVisibility"],
                    DueDateEditVisibility = returnData["DueDateEditVisibility"] == DBNull.Value ? true : (bool)returnData["DueDateEditVisibility"],
                    TypeEditVisibility = returnData["TypeEditVisibility"] == DBNull.Value ? true : (bool)returnData["TypeEditVisibility"],
                    PercentCompleteEditVisibility = returnData["PercentCompleteEditVisibility"] == DBNull.Value ? true : (bool)returnData["PercentCompleteEditVisibility"],
                    MilestoneEditVisibility = returnData["MilestoneEditVisibility"] == DBNull.Value ? true : (bool)returnData["MilestoneEditVisibility"],
                    EstimationEditVisibility = returnData["EstimationEditVisibility"] == DBNull.Value ? true : (bool)returnData["EstimationEditVisibility"],
                    ResolutionEditVisibility = returnData["ResolutionEditVisibility"] == DBNull.Value ? true : (bool)returnData["ResolutionEditVisibility"],
                    AffectedMilestoneEditVisibility = returnData["AffectedMilestoneEditVisibility"] == DBNull.Value ? true : (bool)returnData["AffectedMilestoneEditVisibility"],
                    AssignedToNotify = returnData["AssignedToNotify"] == DBNull.Value ? true : (bool)returnData["AssignedToNotify"],
                    OwnedByNotify = returnData["OwnedByNotify"] == DBNull.Value ? true : (bool)returnData["OwnedByNotify"],
                    AssignedUserName = (string)returnData["AssignedUserName"]
                };

                defaultList.Add(defaultValues);
            }
        }


        /// <summary>
        /// Ts the generate issue comment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCommentList">The issue comment list.</param>
        public static void GenerateIssueCommentListFromReader(IDataReader returnData,
                                                              ref List<IssueComment> issueCommentList)
        {
            while (returnData.Read())
            {
                issueCommentList.Add(new IssueComment
                    {
                        CreatorUser = new ITUser(returnData.GetGuid(returnData.GetOrdinal("CreatorUserId")),
                                              returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                                              returnData.GetString(returnData.GetOrdinal("CreatorDisplayName"))
                                              ),
                        Id = returnData.GetInt32(returnData.GetOrdinal("IssueCommentId")),
                        Comment = returnData.GetString(returnData.GetOrdinal("Comment")),
                        DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                        CreatorDisplayName = returnData.GetString(returnData.GetOrdinal("CreatorDisplayName")),
                        CreatorUserName = returnData.GetString(returnData.GetOrdinal("CreatorUsername")),
                        IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                        CreatorUserId = returnData.GetGuid(returnData.GetOrdinal("CreatorUserId"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate issue count list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueCountList">The issue count list.</param>
        private static void GenerateIssueCountListFromReader(IDataReader returnData, ref List<IssueCount> issueCountList)
        {
            while (returnData.Read())
            {
                var issueCount = new IssueCount(
                    returnData.GetValue(2),
                    (string)returnData.GetValue(0),
                    (int)returnData.GetValue(1),
                    (string)returnData.GetValue(3)
                    );
                issueCountList.Add(issueCount);
            }
        }

        /// <summary>
        /// Ts the generate issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static void GenerateIssueListFromReader(IDataReader returnData, ref List<Issue> issueList)
        {
            while (returnData.Read())
            {
                issueList.Add(MapIssue(returnData));
            }
        }

        /// <summary>
        /// Ts the generate installed resources list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="cultureCodes">The culture codes.</param>
        private static void GenerateInstalledResourcesListFromReader(IDataReader returnData,
                                                                     ref List<string> cultureCodes)
        {
            while (returnData.Read())
            {
                cultureCodes.Add((string)returnData["cultureCode"]);
            }
        }

        /// <summary>
        /// Ts the generate issue history list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueHistoryList">The issue history list.</param>
        private static void GenerateIssueHistoryListFromReader(IDataReader returnData,
                                                               ref List<IssueHistory> issueHistoryList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate issue notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueNotificationList">The issue notification list.</param>
        private static void GenerateIssueNotificationListFromReader(IDataReader returnData,
                                                                    ref List<IssueNotification> issueNotificationList)
        {
            while (returnData.Read())
            {
                issueNotificationList.Add(new IssueNotification
                    {
                        Id = 1,
                        IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                        NotificationUsername = returnData.GetString(returnData.GetOrdinal("NotificationUsername")),
                        NotificationEmail = returnData.GetString(returnData.GetOrdinal("NotificationEmail")),
                        NotificationDisplayName = returnData.GetString(returnData.GetOrdinal("NotificationDisplayName")),
                        NotificationCulture = returnData.GetString(returnData.GetOrdinal("NotificationCulture"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate host setting list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="hostsettingList">The hostsetting list.</param>
        private static void GenerateHostSettingListFromReader(IDataReader returnData,
                                                              ref List<HostSetting> hostsettingList)
        {
            while (returnData.Read())
            {
                hostsettingList.Add(new HostSetting
                    {
                        SettingName = returnData.GetString(returnData.GetOrdinal("SettingName")),
                        SettingValue = returnData.GetString(returnData.GetOrdinal("SettingValue"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate role list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="roleList">The role list.</param>
        private static void GenerateRoleListFromReader(IDataReader returnData, ref List<Role> roleList)
        {
            while (returnData.Read())
            {
                roleList.Add(new Role
                    {
                        Id = returnData.GetInt32(returnData.GetOrdinal("RoleId")),
                        ProjectId =
                            (returnData["ProjectId"] != DBNull.Value)
                                ? returnData.GetInt32(returnData.GetOrdinal("ProjectId"))
                                : 0,
                        Name = returnData.GetString(returnData.GetOrdinal("RoleName")),
                        AutoAssign = returnData.GetBoolean(returnData.GetOrdinal("AutoAssign")),
                        Description = returnData.GetString(returnData.GetOrdinal("RoleDescription")),
                    });
            }
        }

        /// <summary>
        /// Ts the generate role permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="rolePermissionList">The role permission list.</param>
        private static void GenerateRolePermissionListFromReader(SqlDataReader returnData,
                                                                 ref List<RolePermission> rolePermissionList)
        {
            while (returnData.Read())
            {
                var permission = new RolePermission((int)returnData["PermissionId"], (int)returnData["ProjectId"],
                                                    returnData["RoleName"].ToString(),
                                                    returnData["PermissionName"].ToString(),
                                                    returnData["PermissionKey"].ToString());
                rolePermissionList.Add(permission);
            }
        }

        /// <summary>
        /// Ts the generate permission list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="permissionList">The permission list.</param>
        private static void GeneratePermissionListFromReader(SqlDataReader returnData,
                                                             ref List<Permission> permissionList)
        {
            while (returnData.Read())
            {
                var permission = new Permission((int)returnData["PermissionId"],
                                                returnData["PermissionName"].ToString(),
                                                returnData["PermissionKey"].ToString());
                permissionList.Add(permission);
            }
        }

        /// <summary>
        /// Ts the generate user list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="userList">The user list.</param>
        private static void GenerateUserListFromReader(SqlDataReader returnData, ref List<ITUser> userList)
        {
            while (returnData.Read())
            {
                var user = new ITUser((Guid)returnData["UserId"], (string)returnData["UserName"],
                                      (string)returnData["DisplayName"], (string)returnData["Email"]);
                userList.Add(user);
            }
        }

        /// <summary>
        /// Ts the generate project list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectList">The project list.</param>
        private static void GenerateProjectListFromReader(IDataReader returnData, ref List<Project> projectList)
        {
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
                        AccessType = (ProjectAccessType)returnData["ProjectAccessType"],
                        AllowIssueVoting = returnData.GetBoolean(returnData.GetOrdinal("AllowIssueVoting")),
                        Code = returnData.GetString(returnData.GetOrdinal("ProjectCode")),
                        Disabled = returnData.GetBoolean(returnData.GetOrdinal("ProjectDisabled")),
                        ManagerDisplayName = returnData.GetString(returnData.GetOrdinal("ManagerDisplayName")),
                        ManagerId = returnData.GetGuid(returnData.GetOrdinal("ProjectManagerUserId")),
                        ManagerUserName = returnData.GetString(returnData.GetOrdinal("ManagerUserName")),
                        SvnRepositoryUrl = returnData.GetString(returnData.GetOrdinal("SvnRepositoryUrl")),
                        UploadPath = returnData.GetString(returnData.GetOrdinal("AttachmentUploadPath")),
                        DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate member roles list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="memberRoleList">The member roles list.</param>
        private static void GenerateProjectMemberRoleListFromReader(SqlDataReader returnData,
                                                                    ref List<MemberRoles> memberRoleList)
        {
            while (returnData.Read())
            {
                int i;
                bool found = false;
                for (i = 0; i < memberRoleList.Count; i++)
                {
                    if (!memberRoleList[i].Username.Equals((string)returnData.GetValue(0))) continue;
                    memberRoleList[i].AddRole((string)returnData.GetValue(1));
                    found = true;
                }

                if (found) continue;

                var memberRoles = new MemberRoles((string)returnData.GetValue(0), (string)returnData.GetValue(1));
                memberRoleList.Add(memberRoles);
            }
        }

        /// <summary>
        /// Ts the generate roadmap issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueList">The issue list.</param>
        private static void GenerateRoadmapIssueListFromReader(IDataReader returnData, ref List<RoadMapIssue> issueList)
        {
            while (returnData.Read())
            {
                Issue issue = MapIssue(returnData);

                if (issue == null) continue;

                var rmIssue = new RoadMapIssue(issue, returnData.GetInt32(returnData.GetOrdinal("MilestoneSortOrder")));
                issueList.Add(rmIssue);
            }
        }

        /// <summary>
        /// Ts the generate project notification list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectNotificationList">The project notification list.</param>
        private static void GenerateProjectNotificationListFromReader(IDataReader returnData,
                                                                      ref List<ProjectNotification>
                                                                          projectNotificationList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate category list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="categoryList">The category list.</param>
        private static void GenerateCategoryListFromReader(IDataReader returnData, ref List<Category> categoryList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate issue attachment list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueAttachmentList">The issue attachment list.</param>
        private static void GenerateIssueAttachmentListFromReader(IDataReader returnData,
                                                                  ref List<IssueAttachment> issueAttachmentList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate query clause list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryClauseList">The query clause list.</param>
        private static void GenerateQueryClauseListFromReader(IDataReader returnData,
                                                              ref List<QueryClause> queryClauseList)
        {
            while (returnData.Read())
            {
                var queryClause = new QueryClause
                    {
                        BooleanOperator = returnData["BooleanOperator"].ToString(),
                        FieldName = returnData["FieldName"].ToString(),
                        ComparisonOperator = returnData["ComparisonOperator"].ToString(),
                        FieldValue = returnData["FieldValue"].ToString(),
                        DataType = (SqlDbType)returnData["DataType"]
                    };

                if (!returnData.IsDBNull(returnData.GetOrdinal("CustomFieldId")))
                {
                    queryClause.CustomFieldId = returnData.GetInt32(returnData.GetOrdinal("CustomFieldId"));
                }
                queryClauseList.Add(queryClause);
            }
        }

        /// <summary>
        /// Ts the generate query list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="queryList">The query list.</param>
        private static void GenerateQueryListFromReader(IDataReader returnData, ref List<Query> queryList)
        {
            while (returnData.Read())
            {
                queryList.Add(new Query
                    {
                        Id = returnData.GetInt32(returnData.GetOrdinal("QueryId")),
                        Name = returnData.GetString(returnData.GetOrdinal("QueryName")),
                        IsPublic = returnData.GetBoolean(returnData.GetOrdinal("IsPublic"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate required field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="requiredFieldList">The required field list.</param>
        private static void GenerateRequiredFieldListFromReader(SqlDataReader returnData,
                                                                ref List<RequiredField> requiredFieldList)
        {
            while (returnData.Read())
            {
                var newRequiredField = new RequiredField(returnData["FieldName"].ToString(),
                                                         returnData["FieldValue"].ToString());
                requiredFieldList.Add(newRequiredField);
            }
        }

        /// <summary>
        /// Ts the generate related issue list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="relatedIssueList">The related issue list.</param>
        private static void GenerateRelatedIssueListFromReader(IDataReader returnData,
                                                               ref List<RelatedIssue> relatedIssueList)
        {
            while (returnData.Read())
            {
                var relatedIssue = new RelatedIssue
                    {
                        DateCreated = returnData.GetDateTime(returnData.GetOrdinal("DateCreated")),
                        IssueId = returnData.GetInt32(returnData.GetOrdinal("IssueId")),
                        Resolution = DefaultIfNull(returnData["IssueResolution"], string.Empty),
                        Status = DefaultIfNull(returnData["IssueStatus"], string.Empty),
                        StatusName = DefaultIfNull(returnData["StatusName"], string.Empty),
                        StatusImageUrl = DefaultIfNull(returnData["StatusImageUrl"], string.Empty),
                        Title = returnData.GetString(returnData.GetOrdinal("IssueTitle"))
                    };

                relatedIssueList.Add(relatedIssue);
            }
        }

        /// <summary>
        /// Ts the generate issue revision list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="revisionList">The revision list.</param>
        private static void GenerateIssueRevisionListFromReader(IDataReader returnData,
                                                                ref List<IssueRevision> revisionList)
        {
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
                        Revision = returnData.GetInt32(returnData.GetOrdinal("Revision")),
                        Changeset = returnData.GetString(returnData.GetOrdinal("Changeset")),
                        Branch = returnData.GetString(returnData.GetOrdinal("Branch"))
                    });
            }
        }

        /// <summary>
        /// Ts the generate milestone list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="milestoneList">The milestone list.</param>
        private static void GenerateMilestoneListFromReader(IDataReader returnData, ref List<Milestone> milestoneList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate priority list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="priorityList">The priority list.</param>
        private static void GeneratePriorityListFromReader(IDataReader returnData, ref List<Priority> priorityList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate project mailbox list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="projectMailboxList">The project mailbox list.</param>
        private static void GenerateProjectMailboxListFromReader(IDataReader returnData,
                                                                 ref List<ProjectMailbox> projectMailboxList)
        {
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
                        CategoryId = DefaultIfNull(returnData["CategoryId"], 0),
                        CategoryName = DefaultIfNull(returnData["CategoryName"], string.Empty),
                        Mailbox = returnData.GetString(returnData.GetOrdinal("Mailbox")),
                        ProjectId = returnData.GetInt32(returnData.GetOrdinal("ProjectId"))
                    };
                projectMailboxList.Add(mailbox);
            }
        }

        /// <summary>
        /// Ts the generate status list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="statusList">The status list.</param>
        private static void GenerateStatusListFromReader(IDataReader returnData, ref List<Status> statusList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate custom field list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldList">The custom field list.</param>
        private static void GenerateCustomFieldListFromReader(IDataReader returnData,
                                                              ref List<CustomField> customFieldList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate custom field selection list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="customFieldSelectionList">The custom field list.</param>
        private static void GenerateCustomFieldSelectionListFromReader(IDataReader returnData,
                                                                       ref List<CustomFieldSelection>
                                                                           customFieldSelectionList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate issue type list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueTypeList">The issue type list.</param>
        private static void GenerateIssueTypeListFromReader(IDataReader returnData, ref List<IssueType> issueTypeList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate issue time entry list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="issueWorkReportList">The issue time entry list.</param>
        private static void GenerateIssueTimeEntryListFromReader(IDataReader returnData,
                                                                 ref List<IssueWorkReport> issueWorkReportList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate resolution list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="resolutionList">The resolution list.</param>
        private static void GenerateResolutionListFromReader(SqlDataReader returnData,
                                                             ref List<Resolution> resolutionList)
        {
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
            }
        }

        /// <summary>
        /// Ts the generate application log list from reader.
        /// </summary>
        /// <param name="returnData">The return data.</param>
        /// <param name="applicationLogList">The application log list.</param>
        private static void GenerateApplicationLogListFromReader(IDataReader returnData,
                                                                 ref List<ApplicationLog> applicationLogList)
        {
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
            }
        }

        private static Issue MapIssue(IDataRecord returnData)
        {
            string time = returnData["TimeLogged"].ToString();
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
                    AssignedUser = new ITUser(DefaultIfNull(returnData["IssueAssignedUserId"], Guid.Empty),
                                              returnData.GetString(returnData.GetOrdinal("AssignedUserName")),
                                              returnData.GetString(returnData.GetOrdinal("AssignedDisplayName"))                                              
                                              ),
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

            for (int i = 0; i < returnData.FieldCount; i++)
            {
                string field = returnData.GetName(i);
                if (!field.StartsWith(Globals.PROJECT_CUSTOM_FIELDS_PREFIX)) continue;

                entity.IssueCustomFields.Add(
                    new IssueCustomField
                        {
                            DatabaseFieldName = field,
                            FieldName = field.Replace(Globals.PROJECT_CUSTOM_FIELDS_PREFIX, ""),
                            FieldValue = returnData.GetString(i)
                        }
                    );
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