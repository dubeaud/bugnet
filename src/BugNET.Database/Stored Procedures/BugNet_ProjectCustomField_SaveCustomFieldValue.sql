CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]
	@IssueId Int,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(MAX)
AS
UPDATE 
	BugNet_ProjectCustomFieldValues 
SET
	CustomFieldValue = @CustomFieldValue
WHERE
	IssueId = @IssueId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT BugNet_ProjectCustomFieldValues
	(
		IssueId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@IssueId,
		@CustomFieldId,
		@CustomFieldValue
	)
