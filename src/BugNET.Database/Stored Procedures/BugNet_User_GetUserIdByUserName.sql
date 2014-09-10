CREATE PROCEDURE [dbo].[BugNet_User_GetUserIdByUserName]
	@UserName NVARCHAR(255),
	@UserId UNIQUEIDENTIFIER OUTPUT
AS

SET NOCOUNT ON

SELECT @UserId = Id FROM AspNetUsers WHERE UserName = @UserName

GO
