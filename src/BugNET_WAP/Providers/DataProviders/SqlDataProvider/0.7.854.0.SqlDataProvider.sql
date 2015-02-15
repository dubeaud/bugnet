/*
Script created at 21/06/2007 8:07:15 PM
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

IF NOT EXISTS (SELECT UserId FROM UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
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

/*remove the assign issue permission from reporter */
DELETE FROM RolePermission WHERE RoleId IN (SELECT RoleId FROM Roles WHERE RoleName = 'Reporter') AND PermissionId = 3
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