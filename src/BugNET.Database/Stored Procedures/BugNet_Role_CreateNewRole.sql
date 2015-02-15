CREATE PROCEDURE [dbo].[BugNet_Role_CreateNewRole]
  @ProjectId 	int,
  @RoleName 		nvarchar(256),
  @RoleDescription 	nvarchar(256),
  @AutoAssign	bit
AS
	INSERT BugNet_Roles
	(
		ProjectId,
		RoleName,
		RoleDescription,
		AutoAssign
	)
	VALUES
	(
		@ProjectId,
		@RoleName,
		@RoleDescription,
		@AutoAssign
	)
RETURN scope_identity()
