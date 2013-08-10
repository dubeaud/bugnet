CREATE PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@UserName	nvarchar(255),
 	@ProjectId	int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

IF EXISTS( SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1
