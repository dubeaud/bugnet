CREATE PROCEDURE [dbo].[BugNet_Reports_IssueTrend] 
 @i   int    = 0, 
 @Start  date   = '6/4/2008',
 @End  date   = '7/4/2012',
 @dayRange int    = 0,
 @ProjectId  int = 0,
 @MilestoneId int = NULL,
 @currentDay date   = '01/01/0001'
AS
BEGIN 
 DECLARE @IssueTrend TABLE ([Date] date, CumulativeOpened int, CumulativeClosed int, TotalActive int)
 SET @dayRange = DATEDIFF(DAY, @Start, @End)
    WHILE (@i <= @dayRange) 
 BEGIN
  SET NOCOUNT ON
    INSERT INTO @IssueTrend ([Date],  CumulativeOpened, CumulativeClosed, TotalActive) 
    SELECT @Start as Dte
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS Date) = @Start),0) as Opened 
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS Date) = @Start
		AND IsClosed = 1),0) as Closed
     ,COUNT(*)
     FROM BugNet_IssuesView
     WHERE
     BugNet_IssuesView.ProjectId = @ProjectId
     AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
     AND IsClosed = 0
     --AND (LastUpdate <= @Start AND LastUpdate >= @currentDay)
  SET @Start = DATEADD(day, 1, @Start) 
  SET @i = @i + 1 
  IF @Start >= GETDATE() SET @currentDay = @End 
 END 
 
SELECT * FROM @IssueTrend
END