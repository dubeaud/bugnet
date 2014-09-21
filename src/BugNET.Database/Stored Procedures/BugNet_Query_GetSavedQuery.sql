
CREATE PROCEDURE [dbo].[BugNet_Query_GetSavedQuery] 
  @QueryId INT
AS

SELECT 
	BooleanOperator,
	FieldName,
	ComparisonOperator,
	FieldValue,
	DataType,
	CustomFieldId
FROM 
	BugNet_QueryClauses
WHERE 
	QueryId = @QueryId;
