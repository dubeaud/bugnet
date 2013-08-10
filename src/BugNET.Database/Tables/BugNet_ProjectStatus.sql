CREATE TABLE [dbo].[BugNet_ProjectStatus] (
    [StatusId]       INT           IDENTITY (1, 1) NOT NULL,
    [ProjectId]      INT           NOT NULL,
    [StatusName]     NVARCHAR (50) NOT NULL,
    [StatusImageUrl] NVARCHAR (50) NOT NULL,
    [SortOrder]      INT           NOT NULL,
    [IsClosedState]  BIT           NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectStatus] PRIMARY KEY CLUSTERED ([StatusId] ASC),
    CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

