CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById] 
	@CustomFieldSelectionId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_ProjectCustomFieldSelections
WHERE
	CustomFieldSelectionId = @CustomFieldSelectionId
ORDER BY CustomFieldSelectionSortOrder
