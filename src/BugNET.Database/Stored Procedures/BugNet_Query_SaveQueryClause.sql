
CREATE PROCEDURE [BugNet_Query_SaveQueryClause] 
  @QueryId INT,
  @BooleanOperator NVarChar(50),
  @FieldName NVarChar(50),
  @ComparisonOperator NVarChar(50),
  @FieldValue NVarChar(50),
  @DataType INT,
  @CustomFieldId INT = NULL
AS
INSERT BugNet_QueryClauses
(
  QueryId,
  BooleanOperator,
  FieldName,
  ComparisonOperator,
  FieldValue,
  DataType, 
  CustomFieldId
) 
VALUES (
  @QueryId,
  @BooleanOperator,
  @FieldName,
  @ComparisonOperator,
  @FieldValue,
  @DataType,
  @CustomFieldId
)
