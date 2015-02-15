/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: May 2nd, 2010 		
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

TRUNCATE TABLE BugNet_RequiredFieldList
GO

INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(1, N'-- Select Field --', N'0')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(2, N'Issue Id', N'IssueId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(3, N'Title', N'IssueTitle')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(4, N'Description', N'IssueDescription')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(5, N'Type', N'IssueTypeId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(6, N'Category', N'IssueCategoryId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(7, N'Priority', N'IssuePriorityId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(8, N'Milestone', N'IssueMilestoneId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(9, N'Status', N'IssueStatusId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(10, N'Assigned', N'IssueAssignedUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(11, N'Owner', N'IssueOwnerUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(12, N'Creator', N'IssueCreatorUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(13, N'Date Created', N'DateCreated')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(14, N'Last Update', N'LastUpdate')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(15, N'Resolution', N'IssueResolutionId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(16, N'Affected Milestone', N'IssueAffectedMilestoneId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(17, N'Due Date', N'IssueDueDate')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(18, N'Custom Fields', N'CustomFieldName')
GO

ALTER PROCEDURE [dbo].[BugNet_RelatedIssue_GetParentIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON PrimaryIssueId = IssueId
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	SecondaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	PrimaryIssueId
GO

ALTER PROCEDURE [dbo].[BugNet_RelatedIssue_GetChildIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON SecondaryIssueId = IssueId
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	PrimaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	SecondaryIssueId
GO

COMMIT

SET NOEXEC OFF
GO