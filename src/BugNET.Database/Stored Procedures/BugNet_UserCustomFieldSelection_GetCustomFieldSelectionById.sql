CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById] 
	@CustomFieldSelectionId Int
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
	CustomFieldSelectionId = @CustomFieldSelectionId
ORDER BY CustomFieldSelectionSortOrder
