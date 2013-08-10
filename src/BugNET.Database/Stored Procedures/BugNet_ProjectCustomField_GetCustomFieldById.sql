CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldById] 
	@CustomFieldId Int
AS

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
WHERE
	Fields.CustomFieldId = @CustomFieldId
