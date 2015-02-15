CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPriorityById]
	@PriorityId int
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
	PriorityId = @PriorityId
