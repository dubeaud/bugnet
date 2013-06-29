CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS

SELECT 
	MilestoneName,
	Number,	
	MilestoneId,
	MilestoneImageUrl
FROM BugNet_IssueMilestoneCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
