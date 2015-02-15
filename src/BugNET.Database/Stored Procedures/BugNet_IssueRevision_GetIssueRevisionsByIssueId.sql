CREATE PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssueRevisions
WHERE
	IssueId = @IssueId
