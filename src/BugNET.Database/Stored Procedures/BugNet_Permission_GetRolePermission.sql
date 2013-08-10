CREATE PROCEDURE  [dbo].[BugNet_Permission_GetRolePermission]  AS

SELECT R.RoleId, R.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName, P.PermissionName
FROM BugNet_RolePermissions RP
JOIN
BugNet_Permissions P ON RP.PermissionId = P.PermissionId
JOIN
BugNet_Roles R ON RP.RoleId = R.RoleId
