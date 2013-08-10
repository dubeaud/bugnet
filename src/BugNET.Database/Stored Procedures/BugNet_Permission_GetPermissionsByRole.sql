CREATE PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleId int
 AS
SELECT BugNet_Permissions.PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
INNER JOIN BugNet_RolePermissions on BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId
WHERE RoleId = @RoleId
