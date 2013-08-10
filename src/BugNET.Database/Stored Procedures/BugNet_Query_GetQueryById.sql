CREATE PROCEDURE [dbo].[BugNet_Query_GetQueryById] 
	@QueryId Int
AS

SELECT
	QueryId,
	QueryName,
	IsPublic
FROM
	BugNet_Queries
WHERE
	QueryId = @QueryId
ORDER BY
	QueryName
