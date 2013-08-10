CREATE procedure [dbo].[BugNet_Role_GetRolesByUser] 
	@UserName       nvarchar(256)
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

SELECT	BugNet_Roles.RoleName,
		BugNet_Roles.ProjectId,
		BugNet_Roles.RoleDescription,
		BugNet_Roles.RoleId,
		BugNet_Roles.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN Users ON BugNet_UserRoles.UserId = Users.UserId
INNER JOIN BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId
WHERE  Users.UserId = @UserId
