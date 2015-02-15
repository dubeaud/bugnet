CREATE TABLE [dbo].[BugNet_Permissions] (
    [PermissionId]   INT           NOT NULL,
    [PermissionKey]  NVARCHAR (50) NOT NULL,
    [PermissionName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_BugNet_Permissions] PRIMARY KEY CLUSTERED ([PermissionId] ASC)
);

