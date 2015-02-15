CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateLastUpdated]
  @IssueId Int,
  @LastUpdateUserName NVARCHAR(255)
AS

SET NOCOUNT ON

DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @LastUpdateUserId = UserId FROM Users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
COMMIT TRAN
