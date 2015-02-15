CREATE PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
@UserName nvarchar(255),
@ProjectId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT  BugNet_UserProjects
	(
		UserId,
		ProjectId,
		DateCreated
	)
	VALUES
	(
		@UserId,
		@ProjectId,
		getdate()
	)
END
