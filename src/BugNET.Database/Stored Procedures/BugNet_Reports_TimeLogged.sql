CREATE PROCEDURE [dbo].[BugNet_Reports_TimeLogged] 
 @Start  date   = '6/4/2008',
 @End  date   = '7/4/2012',
 @ProjectId  int = 0,
 @MilestoneId int = NULL,
 @AssignedUser nvarchar(256) = NULL
AS
BEGIN 
	SELECT SUM(Duration) as TotalHours, BugNet_UserProfiles.DisplayName, BugNet_IssueWorkReports.UserId, WorkDate, ProjectId  
	FROM BugNet_IssuesView 
	JOIN BugNet_IssueWorkReports ON BugNet_IssuesView.IssueId = BugNet_IssueWorkReports.IssueId 
	JOIN Users ON BugNet_IssueWorkReports.UserId = Users.UserId
	JOIN BugNet_UserProfiles ON Users.UserName = BugNet_UserProfiles.UserName
	WHERE 
		ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR IssueMilestoneId = @MilestoneId)
		AND WorkDate <= @End AND WorkDate >= @Start GROUP BY  BugNet_UserProfiles.DisplayName, WorkDate, BugNet_IssueWorkReports.UserId, ProjectId
END