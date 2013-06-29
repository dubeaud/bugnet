CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]
	@ProjectId int
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	SortOrder,
	IssueTypeImageUrl
FROM 
	BugNet_ProjectIssueTypes
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder
