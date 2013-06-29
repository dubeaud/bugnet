CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
  @ProjectId int,
  @CategoryName nvarchar(100),
  @ParentCategoryId int
AS
	INSERT BugNet_ProjectCategories
	(
		ProjectId,
		CategoryName,
		ParentCategoryId
	)
	VALUES
	(
		@ProjectId,
		@CategoryName,
		@ParentCategoryId
	)
RETURN scope_identity()
