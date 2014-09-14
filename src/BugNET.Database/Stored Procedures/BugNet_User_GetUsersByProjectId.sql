CREATE PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int,
	@ExcludeReadonlyUsers bit
AS
SELECT DISTINCT U.Id AS UserId, U.UserName, U.FirstName, U.LastName, U.DisplayName FROM 
	AspNetUsers U
JOIN BugNet_UserProjects
	ON U.Id = BugNet_UserProjects.UserId
LEFT JOIN BugNet_UserRoles UR
	ON U.Id = UR.UserId 
LEFT JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId AND R.ProjectId = @ProjectId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND U.IsApproved = 1
	AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only')
ORDER BY DisplayName ASC
