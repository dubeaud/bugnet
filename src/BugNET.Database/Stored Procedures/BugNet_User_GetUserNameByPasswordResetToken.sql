CREATE PROCEDURE [dbo].[BugNet_User_GetUserNameByPasswordResetToken]
	@Token NVARCHAR(255),
	@UserName NVARCHAR(255) OUTPUT
AS

SET NOCOUNT ON

SELECT @UserName = UserName 
FROM BugNet_UserProfiles
WHERE PasswordVerificationToken = @Token