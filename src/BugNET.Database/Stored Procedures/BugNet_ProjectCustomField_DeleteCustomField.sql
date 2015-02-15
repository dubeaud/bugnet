
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN

	DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
