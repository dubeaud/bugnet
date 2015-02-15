CREATE PROCEDURE [dbo].[BugNet_Issue_Delete]
	@IssueId Int
AS
UPDATE BugNet_Issues SET
	Disabled = 1
WHERE
	IssueId = @IssueId
