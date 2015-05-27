CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]
	@CustomFieldSelectionIdToDelete INT
AS

SET XACT_ABORT ON

DECLARE
	@CustomFieldId INT

SET @CustomFieldId = (SELECT TOP 1 CustomFieldId 
						FROM BugNet_UserCustomFieldSelections 
						WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete)

BEGIN TRAN
	UPDATE BugNet_UserCustomFieldValues
	SET CustomFieldValue = NULL
	WHERE CustomFieldId = @CustomFieldId
							
	DELETE 
	FROM BugNet_UserCustomFieldSelections 
	WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete
COMMIT TRAN
