CREATE PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
AS
SELECT * FROM 
	BugNet_ProjectsView
WHERE 
	ProjectAccessType = 1 AND ProjectDisabled = 0
ORDER BY ProjectName ASC
