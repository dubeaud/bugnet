CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
	@ProjectId int
AS

SELECT 
	PriorityName,
	Number,	
	PriorityId,
	PriorityImageUrl
FROM BugNet_IssuePriorityCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
