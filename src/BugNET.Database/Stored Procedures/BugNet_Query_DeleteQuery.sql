CREATE PROCEDURE [dbo].[BugNet_Query_DeleteQuery] 
  @QueryId Int
AS
DELETE BugNet_Queries WHERE QueryId = @QueryId
DELETE BugNet_QueryClauses WHERE QueryId = @QueryId
