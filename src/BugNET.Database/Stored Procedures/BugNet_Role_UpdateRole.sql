CREATE PROCEDURE [dbo].[BugNet_Role_UpdateRole]
	@RoleId 			int,
	@RoleName			nvarchar(256),
	@RoleDescription 	nvarchar(256),
	@AutoAssign			bit,
	@ProjectId			int
AS
UPDATE BugNet_Roles SET
	RoleName = @RoleName,
	RoleDescription = @RoleDescription,
	AutoAssign = @AutoAssign,
	ProjectId = @ProjectId	
WHERE
	RoleId = @RoleId
