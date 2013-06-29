CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount,
	(SELECT COUNT(*) FROM BugNet_IssuesView where IssueCategoryId = c.CategoryId AND [Disabled] = 0 AND IsClosed = 0) AS IssueCount,
	[Disabled]
FROM BugNet_ProjectCategories c
WHERE c.ParentCategoryId = @CategoryId 
AND [Disabled] = 0
ORDER BY CategoryName
