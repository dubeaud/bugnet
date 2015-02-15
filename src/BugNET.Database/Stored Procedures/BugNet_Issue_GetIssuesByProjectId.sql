CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId
	AND Disabled = 0
Order By IssuePriorityId, IssueStatusId ASC
