/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: January 07, 2010 20:14:22		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

UPDATE [dbo].[BugNet_StringResources] SET [resourceValue]=N'The following issue has been added to a project that you are monitoring. n\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]\n{0}' WHERE [resourceType]=N'Notification' AND [cultureCode]=N'en' AND [resourceKey]=N'IssueAdded'
UPDATE [dbo].[BugNet_StringResources] SET [resourceValue]=N'Issue {0} has been added to a project you are monitoring.' WHERE [resourceType]=N'Notification' AND [cultureCode]=N'en' AND [resourceKey]=N'IssueAddedSubject'
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'PasswordChangeError', N'There was an error changing the password.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem7.Text', N'Open Issues')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'Closed', N'closed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'Voted', N'voted')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'Votes', N'votes')
GO

ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level*/
declare @tmpTable table (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUsername nvarchar(50), NotificationDisplayName nvarchar(50), NotificationEmail nvarchar(50))
INSERT @tmpTable

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

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.UserId NotificationUserId,
	u.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	m.Email NotificationEmail
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	aspnet_Users u,
	aspnet_Membership m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT DISTINCT IssueId,NotificationUserId, NotificationUsername, NotificationDisplayName, NotificationEmail FROM @tmpTable

GO

ALTER PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
 @ProjectId	    INT,
 @PriorityName        NVARCHAR(50),
 @PriorityImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT PriorityId  FROM BugNet_ProjectPriorities WHERE LOWER(PriorityName)= LOWER(@PriorityName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectPriorities 
   	( 
		ProjectId, 
		PriorityName,
		PriorityImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@PriorityName,
		@PriorityImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN 0
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetOpenIssues] 
	@ProjectId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
ORDER BY
	IssueId Desc

GO

ALTER PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
	@ProjectId int
AS
SELECT 
	PM.SortOrder AS MilestoneSortOrder,IssueId, IssueTitle, IssueDescription, IssueStatusId, IssuePriorityId, IssueTypeId, IssueCategoryId, BugNet_IssuesView.ProjectId, IssueResolutionId, 
	IssueCreatorUserId, IssueAssignedUserId, IssueOwnerUserId, IssueDueDate, BugNet_IssuesView.IssueMilestoneId, IssueVisibility, BugNet_IssuesView.DateCreated, IssueEstimation, LastUpdate, 
	LastUpdateUserId, ProjectName, ProjectCode, PriorityName, IssueTypeName, CategoryName, StatusName, ResolutionName, BugNet_IssuesView.MilestoneName, BugNet_IssuesView.MilestoneDueDate,IssueAffectedMilestoneId, AffectedMilestoneName,
	AffectedMilestoneImageUrl,LastUpdateUserName, 
	AssignedUserName, AssignedDisplayName, CreatorUserName, CreatorDisplayName, OwnerUserName, OwnerDisplayName, LastUpdateDisplayName, 
	PriorityImageUrl, IssueTypeImageUrl, StatusImageUrl, BugNet_IssuesView.MilestoneImageUrl, ResolutionImageUrl, TimeLogged, IssueProgress, Disabled, IssueVotes
FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM on IssueMilestoneId = MilestoneId 
WHERE 
	BugNet_IssuesView.ProjectId = @ProjectId AND BugNet_IssuesView.Disabled = 0
AND 
	IssueMilestoneId IN (SELECT DISTINCT IssueMilestoneId FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId))
ORDER BY 
	(CASE WHEN PM.SortOrder IS NULL THEN 1 ELSE 0 END),PM.SortOrder , IssueStatusId ASC, IssueTypeId ASC,IssueCategoryId ASC, AssignedUserName ASC
GO


ALTER PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
	@ProjectId int,
	@MilestoneId int
AS
SELECT (SELECT COUNT(*) FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND BugNet_IssuesView.Disabled = 0 
	AND IssueMilestoneId = @MilestoneId 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)) As ClosedCount , 
(SELECT COUNT(*) FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND ProjectId = @ProjectId AND IssueMilestoneId = @MilestoneId) As TotalCount

GO

COMMIT

SET NOEXEC OFF
GO


