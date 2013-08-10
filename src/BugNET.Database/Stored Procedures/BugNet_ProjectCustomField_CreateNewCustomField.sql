CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectId AND LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT BugNet_ProjectCustomFields
	(
		ProjectId,
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		CustomFieldTypeId
	)
	VALUES
	(
		@ProjectId,
		@CustomFieldName,
		@CustomFieldDataType,
		@CustomFieldRequired,
		@CustomFieldTypeId
	)

	RETURN scope_identity()
END
RETURN 0
