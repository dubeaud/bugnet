CREATE TABLE [dbo].[BugNet_IssueHistory] (
    [IssueHistoryId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]        INT              NOT NULL,
    [FieldChanged]   NVARCHAR (50)    NOT NULL,
    [OldValue]       NVARCHAR (50)    NOT NULL,
    [NewValue]       NVARCHAR (50)    NOT NULL,
    [DateCreated]    DATETIME         CONSTRAINT [DF_BugNet_IssueHistory_DateCreated] DEFAULT (getdate()) NOT NULL,
    [UserId]         UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BugNet_IssueHistory] PRIMARY KEY CLUSTERED ([IssueHistoryId] ASC),
    CONSTRAINT [FK_BugNet_IssueHistory_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

