CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]
	@IssueTypeIdToDelete INT
AS
DELETE 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
