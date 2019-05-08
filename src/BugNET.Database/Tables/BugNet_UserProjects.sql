CREATE TABLE [dbo].[BugNet_UserProjects] (
    [UserId]               UNIQUEIDENTIFIER NOT NULL,
    [ProjectId]            INT              NOT NULL,
    [UserProjectId]        INT              IDENTITY (1, 1) NOT NULL,
    [DateCreated]          DATETIME         NOT NULL,
    [SelectedIssueColumns] NVARCHAR (255)   CONSTRAINT [DF_BugNet_UserProjects_SelectedIssueColumns] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BugNet_UserProjects] PRIMARY KEY CLUSTERED ([UserId] ASC, [ProjectId] ASC),
    CONSTRAINT [FK_BugNet_UserProjects_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

