CREATE PROCEDURE [dbo].[BugNet_Reports_IssuesByPriority] 
 @Start  date   = '6/4/2012',
 @End  date   = '7/4/2012',
 @ProjectId  int = 0,
 @MilestoneId int = NULL
AS
BEGIN

SELECT * FROM BugNet_IssuesView IV 
	WHERE IV.ProjectId = @ProjectId 
		AND (@MilestoneId IS NULL OR IssueMilestoneId = @MilestoneId) 
		AND IV.IsClosed = 0 
		AND IV.LastUpdate <= @End AND IV.LastUpdate >= @Start
END