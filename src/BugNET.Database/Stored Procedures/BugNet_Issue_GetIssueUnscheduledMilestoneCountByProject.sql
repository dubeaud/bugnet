CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS 'Number' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueMilestoneId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
