CREATE PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFields] 
	@UserId UNIQUEIDENTIFIER
AS

SELECT
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_UserCustomFields Fields
	LEFT OUTER JOIN BugNet_UserCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId)
