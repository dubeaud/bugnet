CREATE PROCEDURE [dbo].[BugNet_Reports_Burndown] 
 @i   int    = 0, 
 @Start  date   = '6/4/2012',
 @End  date   = '7/4/2012',
 @dayRange int    = 0,
 @ProjectId  int = 0,
 @MilestoneId int = 0,
 @currentDay date   = '01/01/0001'
AS
BEGIN
 DECLARE @Burndown TABLE ([Date] date, Remaining float, Ideal float)
 SET @dayRange = DATEDIFF(DAY, @Start, @End)
    WHILE (@i <= @dayRange) 
 BEGIN
  SET NOCOUNT ON
    INSERT INTO @Burndown ([Date], Remaining, Ideal) 
    SELECT @Start as Dte
     ,ISNULL((SUM(IssueEstimation) - ISNULL((SELECT SUM(TimeLogged)FROM BugNet_IssuesView RIGHT JOIN BugNet_IssueWorkReports ON BugNet_IssuesView.IssueId = BugNet_IssueWorkReports.IssueId  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND BugNet_IssuesView.IssueMilestoneId = @MilestoneId 
		AND WorkDate <= @Start),0)),0) as Rem 
     ,ISNULL((SUM(IssueEstimation) - ((SUM(IssueEstimation) / @dayRange) * @i)), 0) as Act 
     FROM BugNet_IssuesView
     WHERE
     BugNet_IssuesView.ProjectId = @ProjectId
     AND BugNet_IssuesView.IssueMilestoneId = @MilestoneId
     --AND (LastUpdate <= @Start AND LastUpdate >= @currentDay)
  SET @Start = DATEADD(day, 1, @Start) 
  SET @i = @i + 1 
  IF @Start >= GETDATE() SET @currentDay = @End 
 END 
 
SELECT * FROM @Burndown 
END