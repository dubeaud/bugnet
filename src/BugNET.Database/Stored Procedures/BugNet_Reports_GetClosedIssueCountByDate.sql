CREATE PROCEDURE [dbo].[BugNet_Reports_GetClosedIssueCountByDate] 
	@ProjectId int
AS
SELECT convert(char(10), LastUpdate, 120) as Date, COUNT(*) AS TotalClosed
FROM 
	BugNet_Issues
LEFT OUTER JOIN 
	BugNet_ProjectStatus PS ON IssueStatusId = PS.StatusId 
WHERE 
	 BugNet_Issues.ProjectId = @ProjectId
	 AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId) AND LastUpdate  >  DATEADD (dd , -30,GETDATE()) GROUP BY convert(char(10), LastUpdate, 120)