CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
	@ProjectId int,
	@MilestoneId int
AS
SELECT (SELECT COUNT(*) FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND BugNet_IssuesView.Disabled = 0 
	AND IssueMilestoneId = @MilestoneId 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)) As ClosedCount , 
(SELECT COUNT(*) FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND ProjectId = @ProjectId AND IssueMilestoneId = @MilestoneId) As TotalCount
