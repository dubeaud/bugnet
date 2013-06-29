CREATE PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

DELETE 
	BugNet_UserProjects
WHERE
	UserId = @UserId AND ProjectId = @ProjectId
