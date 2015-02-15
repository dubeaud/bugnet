CREATE PROCEDURE [dbo].[BugNet_IssueRevision_DeleteIssueRevisions] 
  @IssueRevisionId Int
AS
DELETE FROM
	BugNet_IssueRevisions
WHERE
	IssueRevisionId = @IssueRevisionId
