CREATE PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
	@ProjectId Int
AS

SELECT ISNULL(AspNetUsers.DisplayName, AspNetUsers.UserName) as DisplayName, BugNet_Roles.RoleName
FROM
	AspNetUsers INNER JOIN
	BugNet_UserProjects ON AspNetUsers.Id = BugNet_UserProjects.UserId INNER JOIN
	BugNet_UserRoles ON AspNetUsers.Id = BugNet_UserRoles.UserId INNER JOIN
	BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY DisplayName, RoleName ASC
