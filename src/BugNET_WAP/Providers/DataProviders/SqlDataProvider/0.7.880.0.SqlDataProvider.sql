/*
Script created by SQL Compare version 5.3.0.44 from Red Gate Software Ltd at 11/09/2007 9:13:02 PM
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[BugNet_ApplicationLog_GetLogCount]'
GO
CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLogCount] 
AS

SELECT COUNT(Id) FROM Log



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[HostSettings]'
GO
ALTER TABLE [dbo].[HostSettings] ALTER COLUMN [SettingValue] [nvarchar] (2000) NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_HostSettings_UpdateHostSetting]'
GO

ALTER PROCEDURE [dbo].[BugNet_HostSettings_UpdateHostSetting]
 @SettingName	nvarchar(50),
 @SettingValue 	nvarchar(2000)
AS
UPDATE HostSettings SET
	SettingName = @SettingName,
	SettingValue = @SettingValue
WHERE
	SettingName  = @SettingName

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_ApplicationLog_GetLog]'
GO
ALTER PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog] 
	@startRowIndex int ,
    @maximumRows int
AS

DECLARE @first_id int, @startRow int
	
-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex
SELECT @first_id = Id FROM Log ORDER BY Id

-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows


SELECT L.* FROM Log L
   
WHERE Id >= @first_id
ORDER BY L.Id

SET ROWCOUNT 0



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[Project]'
GO
ALTER TABLE [dbo].[Project] ALTER COLUMN [Description] [nvarchar] (1000) NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Component_GetComponentsByProjectId]'
GO
ALTER PROCEDURE [dbo].[BugNet_Component_GetComponentsByProjectId]
	@ProjectId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
ProjectId = @ProjectId
ORDER BY Name

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[Bug]'
GO
ALTER TABLE [dbo].[Bug] ADD
[Estimation] [decimal] (4, 2) NOT NULL CONSTRAINT [DF_Bug_Estimation] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Bug_CreateNewBug]'
GO
ALTER PROCEDURE [dbo].[BugNet_Bug_CreateNewBug]
  @Summary nvarchar(500),
  @Description ntext,
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @TypeId Int,
  @ResolutionId Int,
  @AssignedToUserName NVarChar(255),
  @ReporterUserName NVarChar(255),
  @DueDate datetime,
  @FixedInVersionId int,
  @Visibility int,
  @Estimation decimal(4,2)
AS
DECLARE @newIssueId Int
-- Get Reporter UserID
DECLARE @AssignedToUserId	UNIQUEIDENTIFIER
DECLARE @ReporterUserId		UNIQUEIDENTIFIER

SELECT @AssignedToUserId = UserId FROM aspnet_users WHERE Username = @AssignedToUserName
SELECT @ReporterUserId = UserId FROM aspnet_users WHERE Username = @ReporterUserName

	INSERT Bug
	(
		Summary,
		Description,
		ReporterUserId,
		ReportedDate,
		StatusId,
		PriorityId,
		TypeId,
		ComponentId,
		AssignedToUserId,
		ProjectId,
		ResolutionId,
		VersionId,
		LastUpdateUserId,
		LastUpdate,
		DueDate,
		FixedInVersionId,
		Visibility,
		Estimation
	)
	VALUES
	(
		@Summary,
		@Description,
		@ReporterUserId,
		GetDate(),
		@StatusId,
		@PriorityId,
		@TypeId,
		@ComponentId,
		@AssignedToUserId,
		@ProjectId,
		@ResolutionId,
		@VersionId,
		@ReporterUserId,
		GetDate(),
		@DueDate,
		@FixedInVersionId,
		@Visibility,
		@Estimation
	)
RETURN scope_identity()
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Bug_GetRoadMap]'
GO
ALTER PROCEDURE [dbo].[BugNet_Bug_GetRoadMap]
	@ProjectId int
AS
SELECT     dbo.Bug.BugID, dbo.Bug.Summary, dbo.Bug.Description, dbo.Bug.ReportedDate, dbo.Bug.StatusID, dbo.Bug.PriorityID, dbo.Bug.TypeID, 
                      dbo.Bug.ComponentID, dbo.Bug.ProjectID, dbo.Bug.ResolutionID, dbo.Bug.VersionID, dbo.Bug.LastUpdate, dbo.Bug.ReporterUserId, 
                      dbo.Bug.AssignedToUserId, dbo.Bug.LastUpdateUserId, dbo.Status.Name AS StatusName, dbo.Component.Name AS ComponentName, 
                      dbo.Priority.Name AS PriorityName, dbo.Project.Name AS ProjectName, dbo.Project.Code AS ProjectCode, dbo.Resolution.Name AS ResolutionName, 
                      dbo.Type.Name AS TypeName, ISNULL(dbo.Version.Name, 'Unassigned') AS VersionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ReportedUsers.UserName AS ReporterUserName, ISNULL(AssignedUsers.UserName, 'Unassigned') AS AssignedToUserName, dbo.Bug.DueDate, 
                      dbo.Bug.FixedInVersionId, ISNULL(FixedInVersion.Name, 'Unscheduled') AS FixedInVersionName, dbo.Bug.Visibility,
                      ISNULL
                             ((SELECT        SUM(Duration) AS Expr1
                                 FROM            dbo.BugTimeEntry AS BTE
                                 WHERE        (BugId = dbo.Bug.BugID)), 0.00) AS TimeLogged, dbo.Bug.Estimation

FROM         dbo.Bug LEFT OUTER JOIN
                      dbo.Component ON dbo.Bug.ComponentID = dbo.Component.ComponentID LEFT OUTER JOIN
                      dbo.Priority ON dbo.Bug.PriorityID = dbo.Priority.PriorityID LEFT OUTER JOIN
                      dbo.Project ON dbo.Bug.ProjectID = dbo.Project.ProjectID LEFT OUTER JOIN
                      dbo.Resolution ON dbo.Bug.ResolutionID = dbo.Resolution.ResolutionID LEFT OUTER JOIN
                      dbo.Status ON dbo.Bug.StatusID = dbo.Status.StatusID LEFT OUTER JOIN
                      dbo.Type ON dbo.Bug.TypeID = dbo.Type.TypeID LEFT OUTER JOIN
                      dbo.Version ON dbo.Bug.VersionID = dbo.Version.VersionID LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.Bug.AssignedToUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS ReportedUsers ON dbo.Bug.ReporterUserId = ReportedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.Bug.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.Version AS FixedInVersion ON dbo.Bug.FixedInVersionId = FixedInVersion.VersionID
WHERE 
Bug.ProjectId = @ProjectId  
AND 
FixedInVersionId IN (SELECT DISTINCT FixedInVersionId FROM Bug WHERE Bug.StatusId IN(1,2,3))
ORDER BY FixedInVersion.SortOrder DESC,Bug.StatusID ASC,ComponentName ASC, TypeName ASC, AssignedToUserName ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Role_AddUserToRole]'
GO
ALTER PROCEDURE dbo.BugNet_Role_AddUserToRole
	@UserName nvarchar(256),
	@RoleId int
AS

DECLARE @ProjectId int
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName
SELECT	@ProjectId = ProjectId FROM Roles WHERE RoleId = @RoleId

IF NOT EXISTS (SELECT UserId FROM UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId) AND @RoleId <> 1
BEGIN
 EXEC BugNet_Project_AddUserToProject @UserName, @ProjectId
END

IF NOT EXISTS (SELECT UserId FROM UserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
	INSERT  UserRoles
	(
		UserId,
		RoleId
	)
	VALUES
	(
		@UserId,
		@RoleId
	)
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_CreateNewProject]'
GO

ALTER PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @Name nvarchar(50),
 @Code nvarchar(3),
 @Description 	nvarchar(1000),
 @ManagerUserName nvarchar(255),
 @UploadPath nvarchar(80),
 @Active int,
 @AccessType int,
 @CreatorUserName nvarchar(255),
 @AllowAttachments int
AS
IF NOT EXISTS( SELECT ProjectId,Code  FROM Project WHERE LOWER(Name) = LOWER(@Name) OR LOWER(Code) = LOWER(@Code) )
BEGIN
	DECLARE @ManagerUserId UNIQUEIDENTIFIER
	DECLARE @CreatorUserId UNIQUEIDENTIFIER
	SELECT @ManagerUserId = UserId FROM aspnet_users WHERE Username = @ManagerUserName
	SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
	
	INSERT Project 
	(
		Name,
		Code,
		Description,
		UploadPath,
		ManagerUserId,
		CreateDate,
		CreatorUserId,
		AccessType,
		Active,
		AllowAttachments
	) 
	VALUES
	(
		@Name,
		@Code,
		@Description,
		@UploadPath,
		@ManagerUserId ,
		GetDate(),
		@CreatorUserId,
		@AccessType,
		@Active,
		@AllowAttachments
	)
 	RETURN @@IDENTITY
END
ELSE
  RETURN 0

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Bug_UpdateBug]'
GO
ALTER PROCEDURE [dbo].[BugNet_Bug_UpdateBug]
  @BugId Int,
  @Summary nvarchar(500),
  @Description ntext,
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @TypeId Int,
  @ResolutionId Int,
  @AssignedToUserName nvarchar(255),
  @LastUpdateUserName NVarChar(255),
  @DueDate datetime,
  @FixedInVersionId int,
  @Visibility int,
  @Estimation decimal(4,2)
   
AS
DECLARE @newIssueId Int
-- Get Last Update UserID
DECLARE @LastUpdateUserId UniqueIdentifier
DECLARE @AssignedToUserId UniqueIdentifier

SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName
SELECT @AssignedToUserId = UserId FROM aspnet_users WHERE UserName = @AssignedToUserName

	Update Bug Set
		Summary = @Summary,
		Description = @Description,
		StatusID =@StatusId,
		PriorityID =@PriorityId,
		TypeId = @TypeId,
		ComponentID = @ComponentId,
		AssignedToUserId=@AssignedToUserId,
		ProjectId =@ProjectId,
		ResolutionId =@ResolutionId,
		VersionId =@VersionId,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate(),
		DueDate = @DueDate,
		FixedInVersionId = @FixedInVersionId,
		Visibility = @Visibility,
		Estimation	= @Estimation
	WHERE 
		BugId = @BugId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_UpdateProject]'
GO

ALTER PROCEDURE [dbo].[BugNet_Project_UpdateProject]
 @ProjectId 		int,
 @Name				nvarchar(50),
 @Code				nvarchar(3),
 @Description 		nvarchar(1000),
 @ManagerUserName	nvarchar(255),
 @UploadPath 		nvarchar(80),
 @AccessType		int,
 @Active 			int,
 @AllowAttachments	bit
AS
DECLARE @ManagerUserId UNIQUEIDENTIFIER
SELECT @ManagerUserId = UserId FROM aspnet_users WHERE Username = @ManagerUserName

UPDATE Project SET
	Name = @Name,
	Code = @Code,
	Description = @Description,
	ManagerUserId = @ManagerUserId,
	UploadPath = @UploadPath,
	AccessType = @AccessType,
	Active = @Active,
	AllowAttachments = @AllowAttachments
WHERE
	ProjectId = @ProjectId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Component_UpdateComponent]'
GO
CREATE PROCEDURE [dbo].[BugNet_Component_UpdateComponent]
	@ComponentID int,
	@ProjectID int,
	@Name nvarchar(50),
	@ParentComponentID int
AS


UPDATE Component SET
	ProjectID = @ProjectID,
	Name = @Name,
	ParentComponentID = @ParentComponentID
WHERE ComponentID = @ComponentID
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Component_GetRootComponentsByProjectId]'
GO
ALTER PROCEDURE [dbo].[BugNet_Component_GetRootComponentsByProjectId]
	@ProjectId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
ProjectId = @ProjectId AND c.ParentComponentId = 0
ORDER BY Name
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Bug_GetBugFixedInVersionCountByProject]'
GO
CREATE PROCEDURE BugNet_Bug_GetBugFixedInVersionCountByProject 
	@ProjectId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT v.Name, COUNT(nt.FixedInVersionId) AS Number, v.VersionID
	FROM Version v 
	LEFT OUTER JOIN (SELECT FixedInVersionId
	FROM Bug b  
	WHERE (b.StatusID <> 4) AND (b.StatusID <> 5)) nt ON v.VersionID = nt.FixedInVersionId 
	WHERE (v.ProjectID = @ProjectId) 
	GROUP BY v.Name, v.VersionID,v.SortOrder
	ORDER BY v.SortOrder ASC
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Component_GetChildComponentsByComponentId]'
GO
ALTER PROCEDURE [dbo].[BugNet_Component_GetChildComponentsByComponentId]
	@ComponentId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
c.ParentComponentId = @ComponentId
ORDER BY Name

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugsView]'
GO
/* Handles 'unassigned' version 
*/
ALTER VIEW dbo.BugsView
AS
SELECT        dbo.Bug.BugID, dbo.Bug.Summary, dbo.Bug.Description, dbo.Bug.ReportedDate, dbo.Bug.StatusID, dbo.Bug.PriorityID, dbo.Bug.TypeID, 
                         dbo.Bug.ComponentID, dbo.Bug.ProjectID, dbo.Bug.ResolutionID, dbo.Bug.VersionID, dbo.Bug.LastUpdate, dbo.Bug.ReporterUserId, 
                         dbo.Bug.AssignedToUserId, dbo.Bug.LastUpdateUserId, dbo.Status.Name AS StatusName, dbo.Component.Name AS ComponentName, 
                         dbo.Priority.Name AS PriorityName, dbo.Project.Name AS ProjectName, dbo.Project.Code AS ProjectCode, dbo.Resolution.Name AS ResolutionName, 
                         dbo.Type.Name AS TypeName, ISNULL(dbo.Version.Name, 'Unassigned') AS VersionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                         ReportedUsers.UserName AS ReporterUserName, ISNULL(AssignedUsers.UserName, 'Unassigned') AS AssignedToUserName, dbo.Bug.DueDate, 
                         dbo.Bug.FixedInVersionId, ISNULL(FixedInVersion.Name, 'Unassigned') AS FixedInVersionName, dbo.Bug.Visibility, ISNULL
                             ((SELECT        SUM(Duration) AS Expr1
                                 FROM            dbo.BugTimeEntry AS BTE
                                 WHERE        (BugId = dbo.Bug.BugID)), 0.00) AS TimeLogged, dbo.Bug.Estimation
FROM            dbo.Bug LEFT OUTER JOIN
                         dbo.Component ON dbo.Bug.ComponentID = dbo.Component.ComponentID LEFT OUTER JOIN
                         dbo.Priority ON dbo.Bug.PriorityID = dbo.Priority.PriorityID LEFT OUTER JOIN
                         dbo.Project ON dbo.Bug.ProjectID = dbo.Project.ProjectID LEFT OUTER JOIN
                         dbo.Resolution ON dbo.Bug.ResolutionID = dbo.Resolution.ResolutionID LEFT OUTER JOIN
                         dbo.Status ON dbo.Bug.StatusID = dbo.Status.StatusID LEFT OUTER JOIN
                         dbo.Type ON dbo.Bug.TypeID = dbo.Type.TypeID LEFT OUTER JOIN
                         dbo.Version ON dbo.Bug.VersionID = dbo.Version.VersionID LEFT OUTER JOIN
                         dbo.aspnet_Users AS AssignedUsers ON dbo.Bug.AssignedToUserId = AssignedUsers.UserId LEFT OUTER JOIN
                         dbo.aspnet_Users AS ReportedUsers ON dbo.Bug.ReporterUserId = ReportedUsers.UserId LEFT OUTER JOIN
                         dbo.aspnet_Users AS LastUpdateUsers ON dbo.Bug.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                         dbo.Version AS FixedInVersion ON dbo.Bug.FixedInVersionId = FixedInVersion.VersionID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Project_CloneProject]'
GO

CREATE PROCEDURE [dbo].[BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256)
)
AS
-- Copy Project
INSERT Project
(
  Name,
  Code,
  Description,
  UploadPath,
  CreateDate,
  Active,
  AccessType,
  CreatorUserId,
  ManagerUserId,
  AllowAttachments
)
SELECT
  @ProjectName,
  Code,
  Description,
  UploadPath,
  GetDate(),
  Active,
  AccessType,
  CreatorUserId,
  ManagerUserId,
  AllowAttachments
FROM 
  Project
WHERE
  ProjectId = @ProjectId
  
DECLARE @NewProjectId INT
SET @NewProjectId = @@IDENTITY

-- Copy Versions / Milestones
INSERT Version
(
  ProjectId,
  Name,
  SortOrder
)
SELECT
  @NewProjectId,
  Name,
  SortOrder
FROM
  Version
WHERE
  ProjectId = @ProjectID  

-- Copy Project Members
INSERT UserProjects
(
  UserId,
  ProjectId,
  CreatedDate
)
SELECT
  UserId,
  @NewProjectId,
  GetDate()
FROM
  UserProjects
WHERE
  ProjectId = @ProjectId

-- Copy Project Roles
INSERT Roles
( 
	ProjectId,
	RoleName,
	Description,
	AutoAssign
)
SELECT 
	@NewProjectId,
	RoleName,
	Description,
	AutoAssign
FROM
	Roles
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
  Roles
WHERE
  ProjectId = @ProjectId
ORDER BY RoleId

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
  Roles
WHERE
  ProjectId = @NewProjectId
ORDER BY RoleId

INSERT UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId = NewRoleId
FROM #OldRoles INNER JOIN #NewRoles ON  OldRowNumber = NewRowNumber
INNER JOIN UserRoles UR ON UR.RoleId = OldRoleId

-- Copy Custom Fields
INSERT ProjectCustomFields
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
  ProjectCustomFields
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
  ProjectCustomFields
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
  ProjectCustomFields
WHERE
  ProjectId = @NewProjectId
ORDER BY CustomFieldId

INSERT ProjectCustomFieldSelection
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
FROM #OldCustomFields INNER JOIN #NewCustomFields ON  OldRowNumber = NewRowNumber
INNER JOIN ProjectCustomFieldSelection CFS ON CFS.CustomFieldId = OldCustomFieldId

-- Copy Project Mailboxes
INSERT ProjectMailbox
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
  ProjectMailBox
WHERE
  ProjectId = @ProjectId

-- Copy Categories
INSERT Component
(
  ProjectId,
  Name,
  ParentComponentId
)
SELECT
  @NewProjectId,
  Name,
  ParentComponentId
FROM
  Component
WHERE
  ProjectId = @ProjectId  


CREATE TABLE #OldCategories
(
  OldRowNumber INT IDENTITY,
  OldComponentId INT,
)

INSERT #OldCategories
(
  OldComponentId
)
SELECT
  ComponentId
FROM
  Component
WHERE
  ProjectId = @ProjectId
ORDER BY ComponentId

CREATE TABLE #NewCategories
(
  NewRowNumber INT IDENTITY,
  NewComponentId INT,
)

INSERT #NewCategories
(
  NewComponentId
)
SELECT
  ComponentId
FROM
  Component
WHERE
  ProjectId = @NewProjectId
ORDER BY ComponentId


UPDATE Component SET
  ParentComponentId = NewComponentId
FROM
  #OldCategories INNER JOIN #NewCategories ON OldRowNumber = NewRowNumber
WHERE
  ProjectId = @NewProjectId
  And ParentComponentID = OldComponentId 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Bug_GetRoadMapProgress]'
GO
ALTER PROCEDURE [dbo].[BugNet_Bug_GetRoadMapProgress]
	@ProjectId int,
	@FixedInVersionId int
AS
	/* SET NOCOUNT ON */ 
SELECT (SELECT Count(*) from BugsView 
WHERE ProjectId = @ProjectId AND FixedInVersionId = @FixedInVersionId AND StatusId In (4,5)) As ClosedCount , (SELECT Count(*) from BugsView 
WHERE ProjectId = @ProjectId AND FixedInVersionId = @FixedInVersionId) As TotalCount


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

INSERT INTO HostSettings(SettingName,SettingValue) Values('ApplicationTitle','BugNET Issue Tracker')
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
