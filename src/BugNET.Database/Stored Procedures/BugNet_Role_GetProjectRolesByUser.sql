CREATE procedure [dbo].[BugNet_Role_GetProjectRolesByUser] 
	@UserName       nvarchar(256),
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

SELECT	R.RoleName,
		R.ProjectId,
		R.RoleDescription,
		R.RoleId,
		R.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN Users ON BugNet_UserRoles.UserId = Users.UserId
INNER JOIN BugNet_Roles R ON BugNet_UserRoles.RoleId = R.RoleId
WHERE  Users.UserId = @UserId
AND    (R.ProjectId IS NULL OR R.ProjectId = @ProjectId)
