CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId] 
	@ProjectId Int
AS
SELECT
	ProjectId,
	CustomFieldId,
	CustomFieldName,
	CustomFieldDataType,
	CustomFieldRequired,
	'' CustomFieldValue,
	CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields
WHERE
	ProjectId = @ProjectId
