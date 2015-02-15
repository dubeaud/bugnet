CREATE PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions] AS

SELECT PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
