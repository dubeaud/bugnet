CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
  @ProjectId int,
  @CategoryName nvarchar(100),
  @ParentCategoryId int
AS
IF NOT EXISTS(SELECT CategoryId  FROM BugNet_ProjectCategories WHERE LOWER(CategoryName)= LOWER(@CategoryName) AND ProjectId = @ProjectId)
BEGIN
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
	RETURN SCOPE_IDENTITY()
END
RETURN -1
