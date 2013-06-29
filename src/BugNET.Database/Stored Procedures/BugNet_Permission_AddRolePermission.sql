CREATE PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId int,
	@RoleId int
AS
IF NOT EXISTS (SELECT PermissionId FROM BugNet_RolePermissions WHERE PermissionId = @PermissionId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_RolePermissions
	(
		PermissionId,
		RoleId
	)
	VALUES
	(
		@PermissionId,
		@RoleId
	)
END
