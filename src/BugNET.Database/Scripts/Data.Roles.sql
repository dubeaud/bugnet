SET IDENTITY_INSERT BugNet_Roles ON 
GO 
-- Reference Data for BugNet_Languages 
MERGE INTO BugNet_Roles AS Target 
USING (VALUES 
	(1, NULL, N'Super Users', N'A role for application super users', 0)
) 
AS Source ([RoleId], [ProjectId], [RoleName], [RoleDescription], [AutoAssign]) 
ON Target.RoleId = Source.RoleId

-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT ([RoleId], [ProjectId], [RoleName], [RoleDescription], [AutoAssign]) 
VALUES ([RoleId], [ProjectId], [RoleName], [RoleDescription], [AutoAssign]); 

SET IDENTITY_INSERT BugNet_Roles OFF 
GO 