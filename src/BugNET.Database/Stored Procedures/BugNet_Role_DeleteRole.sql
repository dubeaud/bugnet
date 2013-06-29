CREATE PROCEDURE [dbo].[BugNet_Role_DeleteRole]
	@RoleId Int 
AS
DELETE 
	BugNet_Roles
WHERE
	RoleId = @RoleId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
