CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_Update]
	@CustomFieldSelectionId INT,
	@CustomFieldId INT,
	@CustomFieldSelectionName NVARCHAR(255),
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionSortOrder INT
AS

SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE 
	@OldSortOrder INT,
	@OldCustomFieldSelectionId INT,
	@OldSelectionValue NVARCHAR(255)

SELECT TOP 1 
	@OldSortOrder = CustomFieldSelectionSortOrder,
	@OldSelectionValue = CustomFieldSelectionValue
FROM BugNet_UserCustomFieldSelections 
WHERE CustomFieldSelectionId = @CustomFieldSelectionId

SET @OldCustomFieldSelectionId = (SELECT TOP 1 CustomFieldSelectionId FROM BugNet_UserCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId)

UPDATE 
	BugNet_UserCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_UserCustomFieldSelections 
SET CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId

/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
IF (@OldSelectionValue != @CustomFieldSelectionValue)
BEGIN
	UPDATE BugNet_UserCustomFieldValues
	SET CustomFieldValue = @CustomFieldSelectionValue
	WHERE CustomFieldId = @CustomFieldId AND CustomFieldValue = @OldSelectionValue
END
