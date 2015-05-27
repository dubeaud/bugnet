
CREATE PROCEDURE [dbo].[BugNet_UserCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN
	/*Copied from BugNet_ProjectCustomField_DeleteCustomField but this field not point at BugNet_UserCustomField_DeleteCustomField, the field should be renamed in BugNet_QueryClauses? */
	/*DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete*/
	
	DELETE 
	FROM BugNet_UserCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_UserCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
