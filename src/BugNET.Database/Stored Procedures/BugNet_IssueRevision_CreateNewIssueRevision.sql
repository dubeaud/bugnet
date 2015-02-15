CREATE PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId int,
	@Revision int,
	@Repository nvarchar(400),
	@RevisionDate nvarchar(100),
	@RevisionAuthor nvarchar(100),
	@RevisionMessage ntext,
	@Changeset nvarchar(100),
	@Branch nvarchar(255)
AS

IF (NOT EXISTS(SELECT IssueRevisionId FROM BugNet_IssueRevisions WHERE IssueId = @IssueId AND Revision = @Revision 
	AND RevisionDate = @RevisionDate AND Repository = @Repository AND RevisionAuthor = @RevisionAuthor))
BEGIN
	INSERT BugNet_IssueRevisions
	(
		Revision,
		IssueId,
		Repository,
		RevisionAuthor,
		RevisionDate,
		RevisionMessage,
		Changeset,
		Branch,
		DateCreated
	) 
	VALUES 
	(
		@Revision,
		@IssueId,
		@Repository,
		@RevisionAuthor,
		@RevisionDate,
		@RevisionMessage,
		@Changeset,
		@Branch,
		GetDate()
	)

	RETURN scope_identity()
END