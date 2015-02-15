/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

ALTER TABLE BugNet_UserProfiles ADD SelectedIssueColumns NVARCHAR(50) NULL
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]
  @UserName nvarchar(255),
  @ExcludeClosedStatus bit
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF(@ExcludeClosedStatus = 1)
	SELECT 
		*
	FROM 
		BugNet_IssuesView
		INNER JOIN BugNet_IssueNotifications on BugNet_IssuesView.IssueId = BugNet_IssueNotifications.IssueId
		AND BugNet_IssueNotifications.UserId = @UserId 
	WHERE BugNet_IssuesView.IssueStatusId
		IN (SELECT PS.StatusId FROM BugNet_ProjectStatus PS WHERE PS.IsClosedState = 0)
ELSE
	SELECT 
		*
	FROM 
		BugNet_IssuesView
		INNER JOIN BugNet_IssueNotifications on BugNet_IssuesView.IssueId = BugNet_IssueNotifications.IssueId
		AND BugNet_IssueNotifications.UserId = @UserId 
GO



COMMIT
GO

SET NOEXEC OFF
GO