
CREATE PROCEDURE [dbo].[BugNet_DefaultValues_GetByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_DefaultValView 
WHERE 
	ProjectId= @ProjectId
	

