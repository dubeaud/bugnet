CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_UserCustomFieldSelections
WHERE
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder
