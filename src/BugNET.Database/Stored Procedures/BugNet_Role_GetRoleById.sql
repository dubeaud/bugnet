CREATE PROCEDURE [dbo].[BugNet_Role_GetRoleById]
	@RoleId int
AS
SELECT RoleId, ProjectId, RoleName, RoleDescription, AutoAssign 
FROM BugNet_Roles
WHERE RoleId = @RoleId
