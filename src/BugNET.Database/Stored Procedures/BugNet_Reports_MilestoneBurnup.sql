CREATE PROCEDURE [dbo].[BugNet_Reports_MilestoneBurnup] 
	@ProjectId int
AS
SELECT SUM(IssueEstimation) - SUM(TimeLogged) AS TotalHours, SUM(TimeLogged) AS TotalComplete, BugNet_IssuesView.MilestoneName  FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM ON IssueMilestoneId = MilestoneId 
WHERE 
	BugNet_IssuesView.ProjectId= @ProjectId
GROUP BY BugNet_IssuesView.MilestoneName