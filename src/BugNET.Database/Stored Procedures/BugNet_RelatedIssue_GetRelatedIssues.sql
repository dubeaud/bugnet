CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
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
	BugNet_Issues
	LEFT JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	LEFT JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId 
WHERE
	IssueId IN (SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE SecondaryIssueId = @IssueId AND RelationType = @RelationType)
	OR IssueId IN (SELECT SecondaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @IssueId AND RelationType = @RelationType)
ORDER BY
	IssueId
