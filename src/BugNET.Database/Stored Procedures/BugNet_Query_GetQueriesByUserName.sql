CREATE PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
	@UserName NVarChar(255),
	@ProjectId Int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

SELECT
	QueryId,
	QueryName + ' (' + BugNet_UserProfiles.DisplayName + ')' AS QueryName,
	IsPublic
FROM
	BugNet_Queries INNER JOIN
	Users M ON BugNet_Queries.UserId = M.UserId JOIN
	BugNet_UserProfiles ON M.UserName = BugNet_UserProfiles.UserName
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
