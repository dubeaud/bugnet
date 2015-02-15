CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	( (PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId) OR (PrimaryIssueId = @SecondaryIssueId AND SecondaryIssueId = @PrimaryIssueId) )
	AND RelationType = @RelationType
