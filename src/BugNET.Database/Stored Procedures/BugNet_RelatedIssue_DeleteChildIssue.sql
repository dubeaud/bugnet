CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteChildIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @PrimaryIssueId
	AND SecondaryIssueId = @SecondaryIssueId
	AND RelationType = @RelationType
