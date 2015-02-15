CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
SELECT 
	s.StatusName,COUNT(nt.IssueStatusId) as 'Number', s.StatusId, s.StatusImageUrl
FROM 
	BugNet_ProjectStatus s 
LEFT OUTER JOIN 
(SELECT  
		IssueStatusId, ProjectId 
	FROM   
	BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId)) nt  
	ON 
		s.StatusId = nt.IssueStatusId AND nt.ProjectId = @ProjectId
	WHERE 
		s.ProjectId = @ProjectId
	GROUP BY 
		s.StatusName, s.StatusId, s.StatusImageUrl, s.SortOrder
	ORDER BY
		s.SortOrder