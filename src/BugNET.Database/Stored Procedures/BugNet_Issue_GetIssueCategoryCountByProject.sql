CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]
	@ProjectId int,
	@CategoryId int = NULL
AS

SELECT 
	COUNT(IssueId)
FROM
	BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND 
		(
			(@CategoryId IS NULL AND IssueCategoryId IS NULL) OR 
			(IssueCategoryId = @CategoryId)
		) 
	AND [Disabled] = 0
	AND IsClosed = 0
