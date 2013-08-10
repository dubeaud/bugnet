CREATE PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId Int,
	@RoleId Int 
AS
DELETE 
	BugNet_RolePermissions
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
