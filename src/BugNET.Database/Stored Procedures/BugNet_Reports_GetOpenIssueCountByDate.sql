CREATE PROCEDURE [dbo].[BugNet_Reports_GetOpenIssueCountByDate] 
	@ProjectId int
AS
SELECT convert(char(10), IV.DateCreated, 120) as Date, COUNT(*) AS TotalOpened
FROM 
	BugNet_IssuesView IV
WHERE 
	 IV.ProjectId = @ProjectId AND IV.DateCreated  >  DATEADD (dd , -30,GETDATE()) GROUP BY convert(char(10), IV.DateCreated, 120)