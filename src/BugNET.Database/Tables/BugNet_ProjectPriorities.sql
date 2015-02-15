CREATE TABLE [dbo].[BugNet_ProjectPriorities] (
    [PriorityId]       INT           IDENTITY (1, 1) NOT NULL,
    [ProjectId]        INT           NOT NULL,
    [PriorityName]     NVARCHAR (50) NOT NULL,
    [PriorityImageUrl] NVARCHAR (50) NOT NULL,
    [SortOrder]        INT           NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectPriorities] PRIMARY KEY CLUSTERED ([PriorityId] ASC),
    CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

