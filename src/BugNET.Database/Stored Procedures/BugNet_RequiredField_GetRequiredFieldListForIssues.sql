CREATE PROCEDURE [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RequiredFieldId, FieldName, FieldValue FROM BugNet_RequiredFieldList
END
