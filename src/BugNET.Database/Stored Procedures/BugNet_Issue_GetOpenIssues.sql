CREATE PROCEDURE [dbo].[BugNet_Issue_GetOpenIssues] 
	@ProjectId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
ORDER BY
	IssueId Desc
