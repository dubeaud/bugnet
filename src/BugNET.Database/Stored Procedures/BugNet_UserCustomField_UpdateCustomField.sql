CREATE PROCEDURE [dbo].[BugNet_UserCustomField_UpdateCustomField]
	@CustomFieldId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId Int
AS
UPDATE 
	BugNet_UserCustomFields 
SET
	CustomFieldName = @CustomFieldName,
	CustomFieldDataType = @CustomFieldDataType,
	CustomFieldRequired = @CustomFieldRequired,
	CustomFieldTypeId = @CustomFieldTypeId
WHERE 
	CustomFieldId = @CustomFieldId
