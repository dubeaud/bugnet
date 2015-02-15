CREATE PROCEDURE [dbo].[BugNet_Role_RoleExists]
    @RoleName   nvarchar(256),
    @ProjectId	int
AS
BEGIN
    IF (EXISTS (SELECT RoleName FROM BugNet_Roles WHERE @RoleName = RoleName AND ProjectId = @ProjectId))
        RETURN(1)
    ELSE
        RETURN(0)
END
