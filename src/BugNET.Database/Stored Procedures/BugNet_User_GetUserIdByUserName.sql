CREATE PROCEDURE [dbo].[BugNet_User_GetUserIdByUserName]
	@UserName NVARCHAR(75),
	@UserId UNIQUEIDENTIFIER OUTPUT
AS

SET NOCOUNT ON

SELECT @UserId = UserId
FROM Users
WHERE UserName = @UserName

GO
