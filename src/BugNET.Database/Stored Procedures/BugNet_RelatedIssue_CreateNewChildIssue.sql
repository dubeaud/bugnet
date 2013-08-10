CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewChildIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@PrimaryIssueId,
		@SecondaryIssueId,
		@RelationType
	)
END
