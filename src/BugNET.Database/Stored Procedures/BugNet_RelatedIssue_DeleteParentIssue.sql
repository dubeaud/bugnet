CREATE PROCEDURE  [dbo].[BugNet_RelatedIssue_DeleteParentIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @SecondaryIssueId
	AND SecondaryIssueId = @PrimaryIssueId
	AND RelationType = @RelationType
