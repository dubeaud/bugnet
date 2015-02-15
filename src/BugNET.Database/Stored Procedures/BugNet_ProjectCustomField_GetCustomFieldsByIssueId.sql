CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId] 
	@IssueId Int
AS
DECLARE @ProjectId Int
SELECT @ProjectId = ProjectId FROM BugNet_Issues WHERE IssueId = @IssueId

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
	LEFT OUTER JOIN BugNet_ProjectCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId AND FieldValues.IssueId = @IssueId)
WHERE
	Fields.ProjectId = @ProjectId
