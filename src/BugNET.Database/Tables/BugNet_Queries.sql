CREATE TABLE [dbo].[BugNet_Queries] (
    [QueryId]   INT              IDENTITY (1, 1) NOT NULL,
    [UserId]    UNIQUEIDENTIFIER NOT NULL,
    [ProjectId] INT              NOT NULL,
    [QueryName] NVARCHAR (255)   NOT NULL,
    [IsPublic]  BIT              CONSTRAINT [DF_BugNet_Queries_IsPublic] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_Queries] PRIMARY KEY CLUSTERED ([QueryId] ASC),
    CONSTRAINT [FK_BugNet_Queries_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Queries_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

