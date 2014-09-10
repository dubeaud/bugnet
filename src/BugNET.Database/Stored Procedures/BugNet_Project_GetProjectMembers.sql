CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId Int
AS
SELECT UserName
FROM 
	AspNetUsers
LEFT OUTER JOIN
	BugNet_UserProjects
ON
	AspNetUsers.Id = BugNet_UserProjects.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY UserName ASC
