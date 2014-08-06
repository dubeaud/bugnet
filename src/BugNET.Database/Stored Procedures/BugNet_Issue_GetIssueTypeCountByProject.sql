CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS

SELECT 
	t.IssueTypeName, COUNT(nt.IssueTypeId) AS 'Number', t.IssueTypeId, t.IssueTypeImageUrl
FROM  
	BugNet_ProjectIssueTypes t 
LEFT OUTER JOIN 
(SELECT  
		IssueTypeId, ProjectId 
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt  
	ON 
		t.IssueTypeId = nt.IssueTypeId AND nt.ProjectId = @ProjectId
	WHERE 
		t.ProjectId = @ProjectId
	GROUP BY 
		t.IssueTypeName, t.IssueTypeId, t.IssueTypeImageUrl, t.SortOrder
	ORDER BY
		t.SortOrder
