CREATE PROCEDURE [dbo].[BugNet_UserCustomField_CreateNewCustomField]
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId Int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM BugNet_UserCustomFields WHERE LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT BugNet_UserCustomFields
	(
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		CustomFieldTypeId
	)
	VALUES
	(
		@CustomFieldName,
		@CustomFieldDataType,
		@CustomFieldRequired,
		@CustomFieldTypeId
	)

	RETURN scope_identity()
END
RETURN 0
