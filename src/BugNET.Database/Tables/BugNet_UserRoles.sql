CREATE TABLE [dbo].[BugNet_UserRoles] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] INT              NOT NULL,
    CONSTRAINT [PK_BugNet_UserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_BugNet_UserRoles_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[BugNet_Roles] ([RoleId]) ON DELETE CASCADE
);

