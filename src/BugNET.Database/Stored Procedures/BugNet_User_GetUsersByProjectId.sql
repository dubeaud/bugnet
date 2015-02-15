CREATE PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int,
	@ExcludeReadonlyUsers bit
AS
SELECT DISTINCT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  Memberships M 
	ON U.UserId = M.UserId
LEFT JOIN BugNet_UserRoles UR
	ON U.UserId = UR.UserId 
LEFT JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId AND R.ProjectId = @ProjectId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1
	AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only')
ORDER BY DisplayName ASC
