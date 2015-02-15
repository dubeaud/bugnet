CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
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
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder
