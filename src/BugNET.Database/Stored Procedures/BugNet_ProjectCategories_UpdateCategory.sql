CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_UpdateCategory]
	@CategoryId int,
	@ProjectId int,
	@CategoryName nvarchar(100),
	@ParentCategoryId int
AS


UPDATE BugNet_ProjectCategories SET
	ProjectId = @ProjectId,
	CategoryName = @CategoryName,
	ParentCategoryId = @ParentCategoryId
WHERE CategoryId = @CategoryId
