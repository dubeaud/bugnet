CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueById] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	IssueId = @IssueId
