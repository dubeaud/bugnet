CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectId = @ProjectId
