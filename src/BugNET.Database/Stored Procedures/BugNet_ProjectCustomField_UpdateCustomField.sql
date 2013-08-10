CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_UpdateCustomField]
	@CustomFieldId Int,
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
UPDATE 
	BugNet_ProjectCustomFields 
SET
	ProjectId = @ProjectId,
	CustomFieldName = @CustomFieldName,
	CustomFieldDataType = @CustomFieldDataType,
	CustomFieldRequired = @CustomFieldRequired,
	CustomFieldTypeId = @CustomFieldTypeId
WHERE 
	CustomFieldId = @CustomFieldId
