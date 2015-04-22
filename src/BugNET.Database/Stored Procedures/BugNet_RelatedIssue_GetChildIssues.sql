CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetChildIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName,
	ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl,
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
