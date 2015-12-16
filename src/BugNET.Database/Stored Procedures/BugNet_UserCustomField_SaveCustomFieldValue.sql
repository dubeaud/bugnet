CREATE PROCEDURE [dbo].[BugNet_UserCustomField_SaveCustomFieldValue]
	@UserId UNIQUEIDENTIFIER,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(MAX)
AS
UPDATE 
	BugNet_UserCustomFieldValues 
SET
	CustomFieldValue = @CustomFieldValue
WHERE
	UserId = @UserId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT BugNet_UserCustomFieldValues
	(
		UserId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@UserId,
		@CustomFieldId,
		@CustomFieldValue
	)
