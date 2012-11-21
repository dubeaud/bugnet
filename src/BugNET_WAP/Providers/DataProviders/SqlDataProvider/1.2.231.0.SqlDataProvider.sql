SET XACT_ABORT ON

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BugNet_QueryClauses' AND COLUMN_NAME = 'CustomFieldId')
BEGIN
	ALTER TABLE dbo.BugNet_QueryClauses ADD CustomFieldId int NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BugNet_IssueRevisions' AND COLUMN_NAME = 'Branch')
BEGIN
	ALTER TABLE dbo.BugNet_IssueRevisions ADD Branch nvarchar(255) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BugNet_IssueRevisions' AND COLUMN_NAME = 'Changeset')
BEGIN
	ALTER TABLE dbo.BugNet_IssueRevisions ADD Changeset nvarchar(100) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BugNet_IssueRevisions' AND COLUMN_NAME = 'Changeset')
BEGIN
	ALTER TABLE dbo.BugNet_IssueRevisions ADD Changeset nvarchar(100) NULL
END
GO

/* update changeset to revision for svn, the svn hook now passes in the revision for the changeset */
UPDATE BugNet_IssueRevisions
SET Changeset = CAST(Revision AS NVARCHAR)
WHERE Changeset IS NULL
GO

/* update branch to empty string */
UPDATE BugNet_IssueRevisions
SET Branch = ''
WHERE Branch IS NULL
GO

/* 
	update the current query fields from the old field names [DateCreated, LastUpdate] to the 
	new field names [DateCreatedAsDate, LastUpdateAsDate]
*/
UPDATE BugNet_QueryClauses
SET FieldName = 'DateCreatedAsDate'
WHERE FieldName = 'DateCreated'
AND IsCustomField = 0
GO

UPDATE BugNet_QueryClauses
SET FieldName = 'LastUpdateAsDate'
WHERE FieldName = 'LastUpdate'
AND IsCustomField = 0
GO

/* update the query clause with the custom field id for date fields only */
UPDATE BugNet_QueryClauses
SET CustomFieldId = data.CustomFieldId,
	DataType = 4
FROM BugNet_QueryClauses qc
INNER JOIN (
SELECT 
	qc.QueryId,
	pcf.CustomFieldName,  
	pcf.CustomFieldId,
	pcf.CustomFieldDataType
FROM BugNet_QueryClauses qc
INNER JOIN BugNet_Queries q ON q.QueryId = qc.QueryId
INNER JOIN BugNet_ProjectCustomFields pcf ON pcf.ProjectId = q.ProjectId AND pcf.CustomFieldName = qc.FieldName
WHERE qc.IsCustomField = 1
AND pcf.CustomFieldDataType = 3) AS data ON data.QueryId = qc.QueryId AND data.CustomFieldName = qc.FieldName
GO
	
UPDATE BugNet_HostSettings
SET SettingValue = 'templates/NewMailboxIssue.xslt'
WHERE SettingName = 'Pop3BodyTemplate'
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BugNet_QueryClauses' AND COLUMN_NAME = 'IsCustomField')
BEGIN
	ALTER TABLE dbo.BugNet_QueryClauses DROP COLUMN IsCustomField
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_IssueNotification_GetIssueNotificationsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_IssueNotification_GetIssueNotificationsByIssueId]
GO

CREATE PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssuesView]'))
DROP VIEW [dbo].[BugNet_IssuesView]
GO

CREATE VIEW [dbo].[BugNet_IssuesView]
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
                      AS IsClosed, CAST(CONVERT(VARCHAR(10), dbo.BugNet_Issues.LastUpdate, 120) AS DATETIME) AS LastUpdateAsDate, CAST(CONVERT(VARCHAR(10), 
                      dbo.BugNet_Issues.DateCreated, 120) AS DATETIME) AS DateCreatedAsDate
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Query_SaveQueryClause]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_SaveQueryClause]
GO

CREATE PROCEDURE [dbo].[BugNet_Query_SaveQueryClause] 
  @QueryId INT,
  @BooleanOperator NVarChar(50),
  @FieldName NVarChar(50),
  @ComparisonOperator NVarChar(50),
  @FieldValue NVarChar(50),
  @DataType INT,
  @CustomFieldId INT = NULL
AS
INSERT BugNet_QueryClauses
(
  QueryId,
  BooleanOperator,
  FieldName,
  ComparisonOperator,
  FieldValue,
  DataType, 
  CustomFieldId
) 
VALUES (
  @QueryId,
  @BooleanOperator,
  @FieldName,
  @ComparisonOperator,
  @FieldValue,
  @DataType,
  @CustomFieldId
)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Query_GetSavedQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_GetSavedQuery]
GO

CREATE PROCEDURE [dbo].[BugNet_Query_GetSavedQuery] 
  @QueryId INT
AS

SELECT 
	BooleanOperator,
	FieldName,
	ComparisonOperator,
	FieldValue,
	DataType,
	CustomFieldId
FROM 
	BugNet_QueryClauses
WHERE 
	QueryId = @QueryId;
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomField_DeleteCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN

	DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_IssueRevision_CreateNewIssueRevision]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_IssueRevision_GetIssueRevisionsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]
GO

CREATE PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId int,
	@Revision int,
	@Repository nvarchar(400),
	@RevisionDate nvarchar(100),
	@RevisionAuthor nvarchar(100),
	@RevisionMessage ntext,
	@Changeset nvarchar(100),
	@Branch nvarchar(255)
AS

INSERT BugNet_IssueRevisions
(
	Revision,
	IssueId,
	Repository,
	RevisionAuthor,
	RevisionDate,
	RevisionMessage,
	DateCreated,
	Changeset,
	Branch
) 
VALUES 
(
	@Revision,
	@IssueId,
	@Repository,
	@RevisionAuthor,
	@RevisionDate,
	@RevisionMessage,
	GETDATE(),
	@Changeset,
	@Branch
)

RETURN SCOPE_IDENTITY()

GO

CREATE PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId] 
	@IssueId Int
AS

SELECT *
FROM BugNet_IssueRevisions
WHERE IssueId = @IssueId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Project_DeleteProject]    Script Date: 11/16/2012 21:47:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_Project_DeleteProject]
    @ProjectIdToDelete int
AS

--Delete these first
DELETE FROM BugNet_IssueVotes WHERE BugNet_IssueVotes.IssueId in (SELECT B.IssueId FROM BugNet_Issues B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_Issues WHERE ProjectId = @ProjectIdToDelete

--Now Delete everything that was attached to a project and an issue
DELETE FROM BugNet_Issues WHERE BugNet_Issues.IssueCategoryId in (SELECT B.CategoryId FROM BugNet_ProjectCategories B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCategories WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_UserProjects WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMailBoxes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectIdToDelete

--now delete everything attached to the project
DELETE FROM BugNet_ProjectCustomFieldValues WHERE BugNet_ProjectCustomFieldValues.CustomFieldId in (SELECT B.CustomFieldId FROM BugNet_ProjectCustomFields B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Roles WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Queries WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectNotifications WHERE ProjectId = @ProjectIdToDelete

--now delete the project
DELETE FROM BugNet_Projects WHERE ProjectId = @ProjectIdToDelete

GO

INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('it-IT', 'Italian (Italy)', 'en-US')
GO