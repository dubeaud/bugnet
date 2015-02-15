/*
Please back up your database before running this script
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
PRINT N'Dropping foreign keys from [dbo].[ProjectRoles]'
GO
ALTER TABLE [dbo].[ProjectRoles] DROP
CONSTRAINT [FK_ProjectRoles_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[BugAttachment]'
GO
ALTER TABLE [dbo].[BugAttachment] DROP
CONSTRAINT [FK_BugAttachment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ProjectCustomFieldSelection]'
GO
ALTER TABLE [dbo].[ProjectCustomFieldSelection] DROP
CONSTRAINT [FK_ProjectCustomFieldSelection_ProjectCustomFields]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[BugTimeEntry]'
GO
ALTER TABLE [dbo].[BugTimeEntry] DROP
CONSTRAINT [FK_BugTimeEntry_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[Bug]'
GO
ALTER TABLE [dbo].[Bug] DROP
CONSTRAINT [FK_Bug_Priority],
CONSTRAINT [FK_Bug_Project],
CONSTRAINT [FK_Bug_Resolution],
CONSTRAINT [FK_Bug_Status],
CONSTRAINT [FK_Bug_Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[Version]'
GO
ALTER TABLE [dbo].[Version] DROP
CONSTRAINT [FK_Version_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[RelatedBug]'
GO
ALTER TABLE [dbo].[RelatedBug] DROP
CONSTRAINT [FK_RelatedBug_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[RolePermission]'
GO
ALTER TABLE [dbo].[RolePermission] DROP
CONSTRAINT [FK_RolePermission_Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[BugComment]'
GO
ALTER TABLE [dbo].[BugComment] DROP
CONSTRAINT [FK_BugComment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ProjectCustomFields]'
GO
ALTER TABLE [dbo].[ProjectCustomFields] DROP
CONSTRAINT [FK_ProjectCustomFields_Project],
CONSTRAINT [FK_ProjectCustomFields_ProjectCustomFieldType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[BugNotification]'
GO
ALTER TABLE [dbo].[BugNotification] DROP
CONSTRAINT [FK_BugNotification_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ProjectMailBox]'
GO
ALTER TABLE [dbo].[ProjectMailBox] DROP
CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ProjectCustomFieldValues]'
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] DROP
CONSTRAINT [FK_ProjectCustomFieldValues_Bug],
CONSTRAINT [FK_ProjectCustomFieldValues_ProjectCustomFields]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[BugHistory]'
GO
ALTER TABLE [dbo].[BugHistory] DROP
CONSTRAINT [FK_BugHistory_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[RolePermission]'
GO
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [PK_RolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[ProjectRoles]'
GO
ALTER TABLE [dbo].[ProjectRoles] DROP CONSTRAINT [PK_ProjectRoles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[BugNet_Role_RemoveRoleFromProject]'
GO
DROP PROCEDURE [dbo].[BugNet_Role_RemoveRoleFromProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[BugNet_Role_AddRoleToProject]'
GO
DROP PROCEDURE [dbo].[BugNet_Role_AddRoleToProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[ProjectRoles]'
GO
DROP TABLE [dbo].[ProjectRoles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserRoles]'
GO
CREATE TABLE [dbo].[UserRoles]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserRoles] on [dbo].[UserRoles]'
GO
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED  ([UserId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Roles]'
GO
CREATE TABLE [dbo].[Roles]
(
[RoleId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NULL,
[RoleName] [nvarchar] (256) NOT NULL,
[Description] [nvarchar] (256) NOT NULL,
[AutoAssign] [bit] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Roles] on [dbo].[Roles]'
GO
ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED  ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_CreateNewRole]'
GO
CREATE PROCEDURE dbo.BugNet_Role_CreateNewRole
  @ProjectId 	int,
  @Name 		nvarchar(256),
  @Description 	nvarchar(256),
  @AutoAssign	bit
AS
	INSERT Roles
	(
		ProjectID,
		RoleName,
		Description,
		AutoAssign
	)
	VALUES
	(
		@ProjectId,
		@Name,
		@Description,
		@AutoAssign
	)
RETURN scope_identity()
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[RolePermission]'
GO
CREATE TABLE [dbo].[tmp_rg_xx_RolePermission]
(
[RolePermissionId] [int] NOT NULL IDENTITY(1, 1),
[RoleId] [int] NOT NULL,
[PermissionId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_RolePermission] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_RolePermission] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DROP TABLE [dbo].[RolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
sp_rename N'[dbo].[tmp_rg_xx_RolePermission]', N'RolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_RolePermission] on [dbo].[RolePermission]'
GO
ALTER TABLE [dbo].[RolePermission] ADD CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED  ([RolePermissionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_DeleteRole]'
GO
CREATE PROCEDURE dbo.BugNet_Role_DeleteRole
	@RoleId Int 
AS
DELETE 
	Roles
WHERE
	RoleId = @RoleId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_GetRoleById]'
GO
CREATE PROCEDURE dbo.BugNet_Role_GetRoleById
	@RoleId int
AS
SELECT RoleId, ProjectId,RoleName,Description,AutoAssign 
FROM Roles
WHERE RoleId = @RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Permission_GetRolePermission]'
GO
ALTER PROCEDURE  [dbo].[BugNet_Permission_GetRolePermission]  AS

SELECT R.RoleId, R.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName
FROM RolePermission RP 
JOIN
Permission P ON RP.PermissionId = P.PermissionId
JOIN
Roles R ON RP.RoleId = R.RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_UpdateRole]'
GO
CREATE PROCEDURE dbo.BugNet_Role_UpdateRole
	@RoleId 		int,
	@Name			nvarchar(256),
	@Description 	nvarchar(256)
AS
UPDATE Roles SET
	RoleName = @Name,
	Description = @Description
WHERE
	RoleId = @RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Permission_DeleteRolePermission]'
GO
ALTER PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId Int,
	@RoleId Int 
AS
DELETE 
	RolePermission
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_RoleHasPermission]'
GO
CREATE PROCEDURE dbo.BugNet_Role_RoleHasPermission 
	@ProjectID 		int,
	@Role 			nvarchar(256),
	@PermissionKey	nvarchar(50)
AS

SELECT COUNT(*) FROM RolePermission INNER JOIN Roles ON Roles.RoleId = RolePermission.RoleId INNER JOIN
Permission ON RolePermission.PermissionId = Permission.PermissionId

WHERE ProjectId = @ProjectID 
AND 
PermissionKey = @PermissionKey
AND 
Roles.RoleName = @Role
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_GetAllRoles]'
GO
CREATE PROCEDURE dbo.BugNet_Role_GetAllRoles
AS
SELECT RoleId, RoleName,Description,ProjectId,AutoAssign FROM Roles

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_CustomField_DeleteCustomField]'
GO


ALTER PROCEDURE [dbo].[BugNet_CustomField_DeleteCustomField]
 @CustomIdToDelete INT
AS
DELETE FROM ProjectCustomFields WHERE CustomFieldId = @CustomIdToDelete

DELETE FROM ProjectCustomFieldValues WHERE CustomFieldId = @CustomIdToDelete



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Permission_AddRolePermission]'
GO
ALTER PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId int,
	@RoleId int
AS
IF NOT EXISTS (SELECT PermissionId FROM RolePermission WHERE PermissionId = @PermissionId AND RoleId = @RoleId)
BEGIN
	INSERT  RolePermission
	(
		PermissionId,
		RoleId
	)
	VALUES
	(
		@PermissionId,
		@RoleId
	)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_RoleExists]'
GO
CREATE PROCEDURE dbo.BugNet_Role_RoleExists
    @RoleName   nvarchar(256),
    @ProjectId	int
AS
BEGIN
    IF (EXISTS (SELECT RoleName FROM dbo.Roles WHERE @RoleName = RoleName AND ProjectId = @ProjectId))
        RETURN(1)
    ELSE
        RETURN(0)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Role_GetRolesByProject]'
GO
ALTER PROCEDURE dbo.BugNet_Role_GetRolesByProject
	@ProjectId int
AS
SELECT RoleId,ProjectId, RoleName, Description, AutoAssign
FROM Roles
WHERE ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[Bug]'
GO
ALTER TABLE [dbo].[Bug] ALTER COLUMN [DueDate] [datetime] NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_GetProjectRolesByUser]'
GO
CREATE procedure [dbo].[BugNet_Role_GetProjectRolesByUser] 
	@UserName       nvarchar(256),
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	Roles.RoleName,
		Roles.ProjectId,
		Roles.Description,
		Roles.RoleId,
		Roles.AutoAssign
FROM	UserRoles
INNER JOIN aspnet_users ON UserRoles.UserId = aspnet_users.UserId
INNER JOIN Roles ON UserRoles.RoleId = Roles.RoleId
WHERE  aspnet_users.UserId = @UserId
AND    (Roles.ProjectId IS NULL OR Roles.ProjectId = @ProjectId)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Role_GetRolesByUser]'
GO
ALTER procedure [dbo].[BugNet_Role_GetRolesByUser] 
	@UserName       nvarchar(256)
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	Roles.RoleName,
		Roles.ProjectId,
		Roles.Description,
		Roles.RoleId,
		Roles.AutoAssign
FROM	UserRoles
INNER JOIN aspnet_users ON UserRoles.UserId = aspnet_users.UserId
INNER JOIN Roles ON UserRoles.RoleId = Roles.RoleId
WHERE  aspnet_users.UserId = @UserId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Permission_GetPermissionsByRole]'
GO
ALTER PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleId int
 AS
SELECT Permission.PermissionId,PermissionKey, Name  FROM Permission
Inner join RolePermission on RolePermission.PermissionId = Permission.PermissionId
WHERE RoleId = @RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[Project]'
GO
ALTER TABLE [dbo].[Project] ADD
[AllowAttachments] [bit] NOT NULL CONSTRAINT [DF_Project_AllowAttachments] DEFAULT ((1))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_IsUserInRole]'
GO
CREATE procedure dbo.BugNet_Role_IsUserInRole 
	@UserName		nvarchar(256),
	@RoleId			int,
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	UserRoles.UserId,
		UserRoles.RoleId
FROM	UserRoles
INNER JOIN Roles ON UserRoles.RoleId = Roles.RoleId
WHERE	UserRoles.UserId = @UserId
AND		UserRoles.RoleId = @RoleId
AND		Roles.ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_RemoveUserFromRole]'
GO
CREATE PROCEDURE dbo.BugNet_Role_RemoveUserFromRole
	@UserName	nvarchar(256),
	@RoleId		Int 
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE 
	UserRoles
WHERE
	UserId = @UserId
	AND RoleId = @RoleId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BugNet_Role_AddUserToRole]'
GO
CREATE PROCEDURE dbo.BugNet_Role_AddUserToRole
	@UserName nvarchar(256),
	@RoleId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

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
                      dbo.Bug.FixedInVersionId, ISNULL(FixedInVersion.Name, 'Unassigned') AS FixedInVersionName, dbo.Bug.Visibility
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
FixedInVersionId <> -1 
ORDER BY FixedInVersion.SortOrder ASC,Bug.StatusID ASC,ComponentName ASC, TypeName ASC, AssignedToUserName ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Attachment_CreateNewAttachment]'
GO
ALTER PROCEDURE [dbo].[BugNet_Attachment_CreateNewAttachment]
  @BugId int,
  @FileName nvarchar(100),
  @Description nvarchar(80),
  @FileSize Int,
  @ContentType nvarchar(50),
  @UploadedUserName nvarchar(255)
AS
-- Get Uploaded UserID
DECLARE @UploadedUserId UniqueIdentifier
SELECT @UploadedUserId = UserId FROM aspnet_users WHERE Username = @UploadedUserName
	INSERT BugAttachment
	(
		BugID,
		FileName,
		Description,
		FileSize,
		Type,
		UploadedDate,
		UploadedUserId
	)
	VALUES
	(
		@BugId,
		@FileName,
		@Description,
		@FileSize,
		@ContentType,
		GetDate(),
		@UploadedUserId
	)
	RETURN scope_identity()
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_BugNotification_CreateNewBugNotification]'
GO
ALTER PROCEDURE [dbo].[BugNet_BugNotification_CreateNewBugNotification]
	@BugId Int,
	@NotificationUsername NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUsername
IF NOT EXISTS( SELECT BugNotificationId FROM BugNotification WHERE CreatedUserId = @UserId AND BugId = @BugId)
BEGIN
	INSERT BugNotification
	(
		BugId,
		CreatedUserId
	)
	VALUES
	(
		@BugId,
		@UserId
	)
	RETURN scope_identity()
END

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
SELECT     dbo.Bug.BugID, dbo.Bug.Summary, dbo.Bug.Description, dbo.Bug.ReportedDate, dbo.Bug.StatusID, dbo.Bug.PriorityID, dbo.Bug.TypeID, 
                      dbo.Bug.ComponentID, dbo.Bug.ProjectID, dbo.Bug.ResolutionID, dbo.Bug.VersionID, dbo.Bug.LastUpdate, dbo.Bug.ReporterUserId, 
                      dbo.Bug.AssignedToUserId, dbo.Bug.LastUpdateUserId, dbo.Status.Name AS StatusName, dbo.Component.Name AS ComponentName, 
                      dbo.Priority.Name AS PriorityName, dbo.Project.Name AS ProjectName, dbo.Project.Code AS ProjectCode, dbo.Resolution.Name AS ResolutionName, 
                      dbo.Type.Name AS TypeName, ISNULL(dbo.Version.Name, 'Unassigned') AS VersionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ReportedUsers.UserName AS ReporterUserName, ISNULL(AssignedUsers.UserName, 'Unassigned') AS AssignedToUserName, dbo.Bug.DueDate, 
                      dbo.Bug.FixedInVersionId, ISNULL(FixedInVersion.Name, 'Unassigned') AS FixedInVersionName, dbo.Bug.Visibility
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

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_GetAllProjects]'
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName,
	AllowAttachments
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
	ORDER BY Name ASC	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_GetProjectById]'
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName,
	AllowAttachments
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE
	ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_GetPublicProjects]'
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName,
	AllowAttachments
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE 
	AccessType = 1 AND Project.Active = 1
ORDER BY Name ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[BugNet_Project_GetProjectByCode]'
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
 	@ProjectCode nvarchar(3)
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName,
	AllowAttachments
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE
	Code = @ProjectCode
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
 @Description 		nvarchar(80),
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
PRINT N'Altering [dbo].[BugNet_Project_GetProjectsByUserName]'
GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectsByUserName]
	@UserName nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT DISTINCT
	Project.ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName,
	AllowAttachments
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
	Left JOIN UserProjects ON UserProjects.ProjectId = Project.ProjectId
WHERE
	 (Project.AccessType = 1 AND Project.Active = @ActiveOnly) OR
              (Project.AccessType = 2 AND Project.Active = @ActiveOnly AND UserProjects.UserId = @UserId)
              
ORDER BY Name ASC
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
 @Description 	nvarchar(80),
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
PRINT N'Adding foreign keys to [dbo].[Bug]'
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD
CONSTRAINT [FK_Bug_Project] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Project] ([ProjectID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Component]'
GO
ALTER TABLE [dbo].[Component] WITH NOCHECK ADD
CONSTRAINT [FK_Component_Component] FOREIGN KEY ([ComponentID]) REFERENCES [dbo].[Component] ([ComponentID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ProjectMailBox]'
GO
ALTER TABLE [dbo].[ProjectMailBox] WITH NOCHECK ADD
CONSTRAINT [FK_ProjectMailBox_Project] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RolePermission]'
GO
ALTER TABLE [dbo].[RolePermission] WITH NOCHECK ADD
CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[Permission] ([PermissionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Version]'
GO
ALTER TABLE [dbo].[Version] WITH NOCHECK ADD
CONSTRAINT [FK_Version_Project] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Project] ([ProjectID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BugAttachment]'
GO
ALTER TABLE [dbo].[BugAttachment] ADD
CONSTRAINT [FK_BugAttachment_Bug] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ProjectCustomFieldSelection]'
GO
ALTER TABLE [dbo].[ProjectCustomFieldSelection] ADD
CONSTRAINT [FK_ProjectCustomFieldSelection_ProjectCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[ProjectCustomFields] ([CustomFieldId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BugTimeEntry]'
GO
ALTER TABLE [dbo].[BugTimeEntry] ADD
CONSTRAINT [FK_BugTimeEntry_Bug] FOREIGN KEY ([BugId]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


/* Migrating Component Data */
PRINT N'Migrating Components'
DECLARE @ProjectId int
DECLARE @RowNum int
DECLARE @ProjectCount int
DECLARE @ComponentCount int
DECLARE @RC int

SET @RowNum = 0
SELECT @ProjectCount = COUNT(ProjectId) FROM Project
SELECT TOP 1 @ProjectId = ProjectId FROM Project

WHILE @RowNum < @ProjectCount

BEGIN 
	SET @RowNum = @RowNum +1
	SELECT @ComponentCount = COUNT(ComponentId) FROM Bug WHERE ComponentId = 0 AND ProjectId = @ProjectId
	PRINT @ComponentCount
	IF @ComponentCount > 0
	BEGIN
		EXEC @RC = BugNet_Component_CreateNewComponent @ProjectId, 'All', 0
		UPDATE Bug SET ComponentId = @RC WHERE ComponentId = 0 AND ProjectId = @ProjectId
	END

	SELECT TOP 1 @ProjectId=ProjectId FROM Project WHERE ProjectId > @ProjectId
END 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


PRINT N'Adding foreign keys to [dbo].[Bug]'
GO
ALTER TABLE [dbo].[Bug] ADD
CONSTRAINT [FK_Bug_Component] FOREIGN KEY ([ComponentID]) REFERENCES [dbo].[Component] ([ComponentID]) ON DELETE CASCADE,
CONSTRAINT [FK_Bug_Priority] FOREIGN KEY ([PriorityID]) REFERENCES [dbo].[Priority] ([PriorityID]),
CONSTRAINT [FK_Bug_Resolution] FOREIGN KEY ([ResolutionID]) REFERENCES [dbo].[Resolution] ([ResolutionID]),
CONSTRAINT [FK_Bug_Status] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Status] ([StatusID]),
CONSTRAINT [FK_Bug_Type] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[Type] ([TypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RolePermission]'
GO
ALTER TABLE [dbo].[RolePermission] ADD
CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BugComment]'
GO
ALTER TABLE [dbo].[BugComment] ADD
CONSTRAINT [FK_BugComment_Bug] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[UserRoles]'
GO
ALTER TABLE [dbo].[UserRoles] ADD
CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ProjectCustomFields]'
GO
ALTER TABLE [dbo].[ProjectCustomFields] ADD
CONSTRAINT [FK_ProjectCustomFields_Project] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectID]) ON DELETE CASCADE,
CONSTRAINT [FK_ProjectCustomFields_ProjectCustomFieldType] FOREIGN KEY ([CustomFieldTypeId]) REFERENCES [dbo].[ProjectCustomFieldType] ([CustomFieldTypeId]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BugNotification]'
GO
ALTER TABLE [dbo].[BugNotification] ADD
CONSTRAINT [FK_BugNotification_Bug] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RelatedBug]'
GO
ALTER TABLE [dbo].[RelatedBug] ADD
CONSTRAINT [FK_RelatedBug_Bug] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ProjectCustomFieldValues]'
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] ADD
CONSTRAINT [FK_ProjectCustomFieldValues_Bug] FOREIGN KEY ([BugId]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BugHistory]'
GO
ALTER TABLE [dbo].[BugHistory] ADD
CONSTRAINT [FK_BugHistory_Bug] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bug] ([BugID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Roles]'
GO
ALTER TABLE [dbo].[Roles] ADD
CONSTRAINT [FK_Roles_Project] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


/*

Start Role & Permission Migration 

For each project in the projects table create a new role and permissions
*/
PRINT N'Migrating Adding Roles for Existing Projects'
GO
EXEC BugNet_Role_CreateNewRole @ProjectId = NULL, @Name = 'Super Users', @Description = 'A role for project super users', @AutoAssign = 0
GO
declare @pId int
declare @RowNum int
declare @ProjectCount int
	
set @RowNum = 0 

select @ProjectCount = count(ProjectId) from Project
select top 1 @pId = ProjectId from Project


WHILE @RowNum < @ProjectCount

BEGIN
	SET @RowNum = @RowNum + 1
	exec BugNet_Role_CreateNewRole @ProjectId = @pID, @Name = 'Project Administrators', @Description = 'Project Administrators', @AutoAssign = 0
	exec BugNet_Role_CreateNewRole @ProjectId = @pID, @Name = 'Read Only', @Description = 'Read Only', @AutoAssign = 0
	exec BugNet_Role_CreateNewRole @ProjectId = @pID, @Name = 'Reporter', @Description = 'Reporter', @AutoAssign = 0
	exec BugNet_Role_CreateNewRole @ProjectId = @pID, @Name = 'Developer', @Description = 'Developer', @AutoAssign = 0
	exec BugNet_Role_CreateNewRole @ProjectId = @pID, @Name = 'Quality Assurance', @Description = 'Quality Assurance', @AutoAssign = 0
	SELECT TOP 1 @pId=ProjectId FROM Project WHERE ProjectId > @pID 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding permissions for roles'
GO
declare @rId int
declare @RowNum int
declare @RoleCount int
DECLARE @RoleName nvarchar(256)

set @RowNum = 0 

select @RoleCount = count(RoleId) from Roles
select top 1 @rId = RoleId from Roles

WHILE @RowNum < @RoleCount
BEGIN
	SET @RowNum = @RowNum + 1
	SELECT @RoleName = RoleName FROM Roles WHERE RoleId = @rId
	
	IF @RoleName = 'Project Administrators'
	BEGIN
		EXEC dbo.BugNet_Permission_AddRolePermission 1, @rId 
		EXEC dbo.BugNet_Permission_AddRolePermission 2, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 3, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 4, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 5, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 6, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 7, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 8, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 9, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 10, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 11, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 12, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 13, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 14, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 15, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 16, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 17, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 18, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 19, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 20, @rId
	END
	IF @RoleName = 'Read Only'
	BEGIN
		EXEC dbo.BugNet_Permission_AddRolePermission 5, @rId
	END

	IF @RoleName = 'Reporter'
	BEGIN
		EXEC dbo.BugNet_Permission_AddRolePermission 2, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 7, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 10, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 12, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 15, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 3, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 5, @rId
	END

	IF @RoleName = 'Developer'
	BEGIN
		EXEC dbo.BugNet_Permission_AddRolePermission 2, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 7, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 10, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 12, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 15, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 3, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 4, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 5, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 19, @rId
	END

	IF @RoleName = 'Quality Assurance'
	BEGIN
		EXEC dbo.BugNet_Permission_AddRolePermission 2, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 7, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 10, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 12, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 15, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 3, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 4, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 5, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 19, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 17, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 14, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 1, @rId
		EXEC dbo.BugNet_Permission_AddRolePermission 6, @rId
	END
	SELECT TOP 1 @rId=RoleId FROM Roles WHERE RoleId > @rID 
END
GO
/* End Role Permission migration*/
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT 'Updating Host Settings'
UPDATE HostSettings SET SettingValue = '@VERSION@.0' WHERE SettingName = 'Version'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding Administrator to Super Users Role'
EXEC dbo.BugNet_Role_AddUserToRole 'Admin',1
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
