CREATE PROCEDURE [dbo].[BugNet_Role_GetAllRoles]
AS
SELECT RoleId, RoleName,RoleDescription,ProjectId,AutoAssign FROM BugNet_Roles
