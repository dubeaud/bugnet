IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_Issue_UpdateLastUpdated]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_Issue_UpdateLastUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_Issue_UpdateLastUpdated]
  @IssueId Int,
  @LastUpdateUserName NVARCHAR(255)
AS

SET NOCOUNT ON

DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
COMMIT TRAN
GO