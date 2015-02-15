CREATE TABLE [dbo].[BugNet_Roles] (
    [RoleId]          INT            IDENTITY (1, 1) NOT NULL,
    [ProjectId]       INT            NULL,
    [RoleName]        NVARCHAR (256) NOT NULL,
    [RoleDescription] NVARCHAR (256) NOT NULL,
    [AutoAssign]      BIT            NOT NULL,
    CONSTRAINT [PK_BugNet_Roles] PRIMARY KEY CLUSTERED ([RoleId] ASC),
    CONSTRAINT [FK_BugNet_Roles_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

