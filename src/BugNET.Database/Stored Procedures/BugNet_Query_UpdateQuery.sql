CREATE PROCEDURE [dbo].[BugNet_Query_UpdateQuery] 
	@QueryId Int,
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

UPDATE 
	BugNet_Queries 
SET
	UserId = @UserId,
	ProjectId = @ProjectId,
	QueryName = @QueryName,
	IsPublic = @IsPublic
WHERE 
	QueryId = @QueryId

DELETE FROM BugNet_QueryClauses WHERE QueryId = @QueryId
