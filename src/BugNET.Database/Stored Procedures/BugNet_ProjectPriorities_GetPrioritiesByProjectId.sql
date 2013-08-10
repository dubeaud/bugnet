CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]
	@ProjectId int
AS
SELECT
	PriorityId,
	ProjectId,
	PriorityName,
	SortOrder,
	PriorityImageUrl
FROM 
	BugNet_ProjectPriorities
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder
