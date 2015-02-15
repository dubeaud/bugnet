/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
 @ProjectId int
AS
	SELECT 
		ISNULL(AssignedUsersProfile.DisplayName,u.Username ) AS 'Name',COUNT(I.IssueId) AS 'Number', u.UserID, ''
	FROM 
		BugNet_UserProjects pm 
		LEFT OUTER JOIN aspnet_Users u ON pm.UserId = u.UserId 
		LEFT OUTER JOIN BugNet_Issues I ON I.IssueAssignedUserId = u.UserId
		LEFT OUTER JOIN BugNet_UserProfiles AS AssignedUsersProfile ON u.UserName = AssignedUsersProfile.UserName
	WHERE 
		(pm.ProjectId = @ProjectId) 
		AND (I.ProjectId = @ProjectId ) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
	GROUP BY 
		u.Username, u.UserID,AssignedUsersProfile.DisplayName
	ORDER BY AssignedUsersProfile.DisplayName ASC
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
	@UserName	nvarchar(256),
	@RoleId		Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId
GO

UPDATE BugNet_StringResources SET resourceValue = 'Allow all users to run this query' WHERE resourceKey = 'chkGlobalQuery.Text'
UPDATE BugNet_StringResources SET resourceValue = 'Text\IssueAdded.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'IssueAdded'
UPDATE BugNet_StringResources SET resourceValue = 'Text\IssueUpdated.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'IssueUpdated'
UPDATE BugNet_StringResources SET resourceValue = 'Text\IssueUpdatedWithChanges.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'IssueUpdatedWithChanges'
UPDATE BugNet_StringResources SET resourceValue = 'Text\NewAssignee.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'NewAssignee'
UPDATE BugNet_StringResources SET resourceValue = 'Text\NewIssueComment.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'NewIssueComment'
UPDATE BugNet_StringResources SET resourceValue = 'Text\UserRegistered.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'UserRegistered'
UPDATE BugNet_StringResources SET resourceValue = 'Text\PasswordReset.xslt' WHERE resourceType = 'Notification' AND cultureCode = 'en' AND resourceKey = 'PasswordReset'
UPDATE BugNet_StringResources SET resourceValue = 'POP3 Mailbox' WHERE resourceType = 'Administration/Host/UserControls/POP3Settings.ascx' AND cultureCode = 'en' AND resourceKey = 'POP3Settings'

INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'IssueAddedHTML', 'Html\IssueAdded.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'IssueUpdatedHTML', 'Html\IssueUpdated.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'IssueUpdatedWithChangesHTML', 'Html\IssueUpdatedWithChanges.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'NewAssigneeHTML', 'Html\NewAssignee.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'NewIssueCommentHTML', 'Html\NewIssueComment.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'UserRegisteredHTML', 'Html\UserRegistered.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Notification', 'en', 'PasswordResetHTML', 'Html\PasswordReset.xslt')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Administration/Host/UserControls/MailSettings.ascx', 'en', 'EmailFormat', 'Email Format')
INSERT INTO BugNet_StringResources (resourceType, cultureCode, resourceKey, resourceValue) VALUES ('Administration/Host/UserControls/MailSettings.ascx', 'en', 'EmailTemplateRoot', 'Email Template Root')

INSERT INTO BugNet_HostSettings (SettingName, SettingValue) VALUES('SMTPEmailTemplateRoot', '~/templates')
INSERT INTO BugNet_HostSettings (SettingName, SettingValue) VALUES('SMTPEMailFormat','HTML')
INSERT INTO BugNet_HostSettings (SettingName, SettingValue) VALUES('SMTPDomain','')
INSERT INTO BugNet_HostSettings (SettingName, SettingValue) VALUES('EnableGravatar','true')
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256)
)
AS
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
  ProjectCreatorUserId,
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
  ProjectId = @ProjectId  


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

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCustomField_DeleteCustomField]    Script Date: 11/17/2010 15:07:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
 @CustomFieldIdToDelete INT
AS
BEGIN TRAN
	DELETE FROM BugNet_ProjectCustomFieldValues WHERE CustomFieldId = @CustomFieldIdToDelete
	DELETE FROM BugNet_ProjectCustomFields WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Query_UpdateQuery]    Script Date: 11/21/2010 11:01:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_UpdateQuery] 
	@QueryId Int,
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

UPDATE 
	BugNet_Queries 
SET
	UserId = @UserId,
	ProjectId = @ProjectId,
	QueryName = @QueryName,
	IsPublic = @IsPublic
WHERE 
	QueryId = @QueryId

DELETE FROM BugNet_QueryClauses WHERE QueryId = @QueryId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Project_GetProjectByCode]  Script Date: 08/30/2010 14:40:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
@ProjectCode nvarchar(50)
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectCode = @ProjectCode
GO

COMMIT

SET NOEXEC OFF
GO