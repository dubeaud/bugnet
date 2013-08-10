CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS 'Number' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueAssignedUserId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
