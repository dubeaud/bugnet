CREATE PROCEDURE [dbo].[BugNet_Role_RoleHasPermission] 
	@ProjectID 		int,
	@Role 			nvarchar(256),
	@PermissionKey	nvarchar(50)
AS

SELECT COUNT(*) FROM BugNet_RolePermissions INNER JOIN BugNet_Roles ON BugNet_Roles.RoleId = BugNet_RolePermissions.RoleId INNER JOIN
BugNet_Permissions ON BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId

WHERE ProjectId = @ProjectID 
AND 
PermissionKey = @PermissionKey
AND 
BugNet_Roles.RoleName = @Role
