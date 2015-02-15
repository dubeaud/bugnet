CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId INT,
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionName NVARCHAR(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM BugNet_ProjectCustomFieldSelections

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT BugNet_ProjectCustomFieldSelections
	(
		CustomFieldId,
		CustomFieldSelectionValue,
		CustomFieldSelectionName,
		CustomFieldSelectionSortOrder
	)
	VALUES
	(
		@CustomFieldId,
		@CustomFieldSelectionValue,
		@CustomFieldSelectionName,
		@CustomFieldSelectionSortOrder
		
	)

	RETURN scope_identity()
END
RETURN 0
