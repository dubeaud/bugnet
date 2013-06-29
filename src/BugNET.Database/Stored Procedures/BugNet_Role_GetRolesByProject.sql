CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
	@ProjectId int
AS
SELECT RoleId,ProjectId, RoleName, RoleDescription, AutoAssign
FROM BugNet_Roles
WHERE ProjectId = @ProjectId
