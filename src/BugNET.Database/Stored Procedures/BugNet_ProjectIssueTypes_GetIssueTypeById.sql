CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]
 @IssueTypeId INT
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	IssueTypeImageUrl,
	SortOrder
FROM 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeId
