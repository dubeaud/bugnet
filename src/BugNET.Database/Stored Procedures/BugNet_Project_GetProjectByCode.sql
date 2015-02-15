CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
@ProjectCode nvarchar(50)
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectCode = @ProjectCode
