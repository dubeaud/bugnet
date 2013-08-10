CREATE TABLE [dbo].[BugNet_ProjectResolutions] (
    [ResolutionId]       INT           IDENTITY (1, 1) NOT NULL,
    [ProjectId]          INT           NOT NULL,
    [ResolutionName]     NVARCHAR (50) NOT NULL,
    [ResolutionImageUrl] NVARCHAR (50) NOT NULL,
    [SortOrder]          INT           NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectResolutions] PRIMARY KEY CLUSTERED ([ResolutionId] ASC),
    CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

