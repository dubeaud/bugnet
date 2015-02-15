CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
	@CustomFieldSelectionIdToDelete INT
AS

SET XACT_ABORT ON

DECLARE
	@CustomFieldId INT

SET @CustomFieldId = (SELECT TOP 1 CustomFieldId 
						FROM BugNet_ProjectCustomFieldSelections 
						WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete)

BEGIN TRAN
	UPDATE BugNet_ProjectCustomFieldValues
	SET CustomFieldValue = NULL
	WHERE CustomFieldId = @CustomFieldId
							
	DELETE 
	FROM BugNet_ProjectCustomFieldSelections 
	WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete
COMMIT TRAN
