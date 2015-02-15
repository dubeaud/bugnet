CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND c.ProjectId = @ProjectId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE ProjectId = @ProjectId 
AND c.ParentCategoryId = 0 
AND [Disabled] = 0
ORDER BY CategoryName
