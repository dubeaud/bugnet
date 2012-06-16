IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_GetMonitoredIssuesByUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_GetMonitoredIssuesByUserName]
GO

CREATE PROCEDURE [BugNet_Issue_GetMonitoredIssuesByUserName]
  @UserName NVARCHAR(255),
  @ExcludeClosedStatus BIT
AS

SET NOCOUNT ON

DECLARE @NotificationUserId  UNIQUEIDENTIFIER

EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @UserName, @UserId = @NotificationUserId OUTPUT

SELECT
	iv.*,
	bin.UserId AS NotificationUserId, 
	uv.UserName AS NotificationUserName, 
    uv.DisplayName AS NotificationDisplayName
FROM BugNet_IssuesView iv 
INNER JOIN BugNet_IssueNotifications bin ON iv.IssueId = bin.IssueId 
INNER JOIN BugNet_UserView uv ON bin.UserId = uv.UserId
WHERE bin.UserId = @NotificationUserId
AND iv.[Disabled] = 0
AND iv.ProjectDisabled = 0
AND ((@ExcludeClosedStatus = 0) OR (iv.IsClosed = 0))
GO