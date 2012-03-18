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

/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]    Script Date: 12/26/2011 13:51:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]    Script Date: 02/05/2012 15:45:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]    Script Date: 02/05/2012 15:45:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]
	@MilestoneId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE ((IssueMilestoneId = @MilestoneId) OR (IssueAffectedMilestoneId = @MilestoneId))
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0

GO

COMMIT

SET NOEXEC OFF
GO