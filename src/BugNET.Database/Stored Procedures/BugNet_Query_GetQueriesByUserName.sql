CREATE PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
	@UserName NVarChar(255),
	@ProjectId Int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = Id FROM AspNetUsers WHERE UserName = @UserName

SELECT
	QueryId,
	QueryName + ' (' + DisplayName + ')' AS QueryName,
	IsPublic
FROM
	BugNet_Queries INNER JOIN
	AspNetUsers M ON BugNet_Queries.UserId = M.Id
WHERE
	IsPublic = 1 AND ProjectId = @ProjectId
UNION
SELECT
	QueryId,
	QueryName,
	IsPublic
FROM
	BugNet_Queries
WHERE
	UserId = @UserId
	AND ProjectId = @ProjectId
	AND IsPublic = 0
ORDER BY
	QueryName
