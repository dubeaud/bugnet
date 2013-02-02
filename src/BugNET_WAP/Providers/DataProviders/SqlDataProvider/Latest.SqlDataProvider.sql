INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('ru-RU', 'Russian (Russia)', 'en-US')
GO


/****** Object:  View [dbo].[BugNet_IssuesView]    Script Date: 1/26/2013 10:21:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, dbo.BugNet_Issues.IssueOwnerUserId, 
                      dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                      dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, 
                      dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') 
                      AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, 
                      N'Unassigned') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N'Unassigned') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 
                      'Unassigned') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, 
                      'Unassigned') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') 
                      AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate, dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) 
                      AS IsClosed, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.LastUpdate, 112) AS DATETIME) AS LastUpdateAsDate, 
					  CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.DateCreated, 112) AS DATETIME) AS DateCreatedAsDate
FROM         dbo.BugNet_Issues LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Project_CloneProject]    Script Date: 1/26/2013 11:03:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256),
  @CloningUsername VARCHAR(75) = NULL
)
AS

DECLARE
	@CreatorUserId UNIQUEIDENTIFIER

SET NOCOUNT OFF

SET @CreatorUserId = (SELECT ProjectCreatorUserId FROM BugNet_Projects WHERE ProjectId = @ProjectId)

IF(@CloningUsername IS NOT NULL OR LTRIM(RTRIM(@CloningUsername)) != '')
	EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @CloningUsername, @UserId = @CreatorUserId OUTPUT

-- Copy Project
INSERT BugNet_Projects
(
  ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  DateCreated,
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl 
)
SELECT
  @ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  GetDate(),
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  @CreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl
FROM 
  BugNet_Projects
WHERE
  ProjectId = @ProjectId
  
DECLARE @NewProjectId INT
SET @NewProjectId = SCOPE_IDENTITY()

-- Copy Milestones
INSERT BugNet_ProjectMilestones
(
  ProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  DateCreated
)
SELECT
  @NewProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  GetDate()
FROM
  BugNet_ProjectMilestones
WHERE
  ProjectId = @ProjectId  

-- Copy Project Members
INSERT BugNet_UserProjects
(
  UserId,
  ProjectId,
  DateCreated
)
SELECT
  UserId,
  @NewProjectId,
  GetDate()
FROM
  BugNet_UserProjects
WHERE
  ProjectId = @ProjectId

-- Copy Project Roles
INSERT BugNet_Roles
( 
	ProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
)
SELECT 
	@NewProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId

CREATE TABLE #OldRoles
(
  OldRowNumber INT IDENTITY,
  OldRoleId INT,
)

INSERT #OldRoles
(
  OldRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId
ORDER BY 
	RoleId

CREATE TABLE #NewRoles
(
  NewRowNumber INT IDENTITY,
  NewRoleId INT,
)

INSERT #NewRoles
(
  NewRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @NewProjectId
ORDER BY 
	RoleId

INSERT BugNet_UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId = NewRoleId
FROM 
	#OldRoles 
INNER JOIN #NewRoles ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_UserRoles UR ON UR.RoleId = OldRoleId

-- Copy Role Permissions
INSERT BugNet_RolePermissions
(
   PermissionId,
   RoleId
)
SELECT Perm.PermissionId, NewRoles.RoleId
FROM BugNet_RolePermissions Perm
INNER JOIN BugNet_Roles OldRoles ON Perm.RoleId = OldRoles.RoleID
INNER JOIN BugNet_Roles NewRoles ON NewRoles.RoleName = OldRoles.RoleName
WHERE OldRoles.ProjectId = @ProjectId 
	  and NewRoles.ProjectId = @NewProjectId


-- Copy Custom Fields
INSERT BugNet_ProjectCustomFields
(
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
)
SELECT
  @NewProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
  
-- Copy Custom Field Selections
CREATE TABLE #OldCustomFields
(
  OldRowNumber INT IDENTITY,
  OldCustomFieldId INT,
)
INSERT #OldCustomFields
(
  OldCustomFieldId
)
SELECT
	CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
ORDER BY CustomFieldId

CREATE TABLE #NewCustomFields
(
  NewRowNumber INT IDENTITY,
  NewCustomFieldId INT,
)

INSERT #NewCustomFields
(
  NewCustomFieldId
)
SELECT
  CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @NewProjectId
ORDER BY CustomFieldId

INSERT BugNet_ProjectCustomFieldSelections
(
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
)
SELECT 
	CustomFieldId = NewCustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
FROM 
	#OldCustomFields 
INNER JOIN #NewCustomFields ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_ProjectCustomFieldSelections CFS ON CFS.CustomFieldId = OldCustomFieldId

-- Copy Project Mailboxes
INSERT BugNet_ProjectMailBoxes
(
  MailBox,
  ProjectId,
  AssignToUserId,
  IssueTypeId
)
SELECT
  Mailbox,
  @NewProjectId,
  AssignToUserId,
  IssueTypeId
FROM
  BugNet_ProjectMailBoxes
WHERE
  ProjectId = @ProjectId

-- Copy Categories
INSERT BugNet_ProjectCategories
(
  ProjectId,
  CategoryName,
  ParentCategoryId
)
SELECT
  @NewProjectId,
  CategoryName,
  ParentCategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId AND Disabled = 0 


CREATE TABLE #OldCategories
(
  OldRowNumber INT IDENTITY,
  OldCategoryId INT,
)

INSERT #OldCategories
(
  OldCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId
ORDER BY CategoryId

CREATE TABLE #NewCategories
(
  NewRowNumber INT IDENTITY,
  NewCategoryId INT,
)

INSERT #NewCategories
(
  NewCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @NewProjectId
ORDER BY CategoryId

UPDATE BugNet_ProjectCategories SET
  ParentCategoryId = NewCategoryId
FROM
  #OldCategories INNER JOIN #NewCategories ON OldRowNumber = NewRowNumber
WHERE
  ProjectId = @NewProjectId
  And ParentCategoryID = OldCategoryId 

-- Copy Status's
INSERT BugNet_ProjectStatus
(
  ProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
)
SELECT
  @NewProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
FROM
  BugNet_ProjectStatus
WHERE
  ProjectId = @ProjectId 
 
-- Copy Priorities
INSERT BugNet_ProjectPriorities
(
  ProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
FROM
  BugNet_ProjectPriorities
WHERE
  ProjectId = @ProjectId 

-- Copy Resolutions
INSERT BugNet_ProjectResolutions
(
  ProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
FROM
  BugNet_ProjectResolutions
WHERE
  ProjectId = @ProjectId
 
-- Copy Issue Types
INSERT BugNet_ProjectIssueTypes
(
  ProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
FROM
  BugNet_ProjectIssueTypes
WHERE
  ProjectId = @ProjectId

-- Copy Project Notifications
INSERT BugNet_ProjectNotifications
(
  ProjectId,
  UserId
)
SELECT
  @NewProjectId,
  UserId
FROM
  BugNet_ProjectNotifications
WHERE
  ProjectId = @ProjectId

RETURN @NewProjectId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]    Script Date: 2/2/2013 11:43:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level
*/

SET NOCOUNT ON

DECLARE
	@DefaultCulture NVARCHAR(50)

SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId AS NotificationUserId,
	U.UserName AS NotificationUsername,
	ISNULL(DisplayName,'') AS NotificationDisplayName,
	M.Email AS NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles UP ON U.UserName = UP.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName

GO
