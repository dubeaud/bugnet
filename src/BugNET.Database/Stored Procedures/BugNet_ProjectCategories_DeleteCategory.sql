CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId Int 
AS
UPDATE BugNet_ProjectCategories SET
	[Disabled] = 1
WHERE
	CategoryId = @CategoryId
