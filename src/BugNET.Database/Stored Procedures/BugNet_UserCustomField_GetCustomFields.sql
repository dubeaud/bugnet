CREATE PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFields] 
AS

SELECT
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_UserCustomFields Fields
