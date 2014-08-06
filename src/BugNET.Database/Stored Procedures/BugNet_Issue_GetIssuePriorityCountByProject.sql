CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
	@ProjectId int
AS
SELECT 
	p.PriorityName, COUNT(nt.IssuePriorityId) AS 'Number', p.PriorityId,  p.PriorityImageUrl
FROM   
	BugNet_ProjectPriorities p	
LEFT OUTER JOIN 
	(SELECT  
		IssuePriorityId, ProjectId 
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt
ON 
	p.PriorityId = nt.IssuePriorityId AND nt.ProjectId = @ProjectId
WHERE 
	p.ProjectId = @ProjectId
GROUP BY 
	p.PriorityName, p.PriorityId, p.PriorityImageUrl, p.SortOrder
ORDER BY p.SortOrder
