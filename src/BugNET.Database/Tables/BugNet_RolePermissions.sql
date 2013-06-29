CREATE TABLE [dbo].[BugNet_RolePermissions] (
    [PermissionId] INT NOT NULL,
    [RoleId]       INT NOT NULL,
    CONSTRAINT [PK_BugNet_RolePermissions] PRIMARY KEY CLUSTERED ([RoleId] ASC, [PermissionId] ASC),
    CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[BugNet_Permissions] ([PermissionId]),
    CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[BugNet_Roles] ([RoleId]) ON DELETE CASCADE
);

