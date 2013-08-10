CREATE TABLE [dbo].[BugNet_IssueComments] (
    [IssueCommentId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]        INT              NOT NULL,
    [DateCreated]    DATETIME         CONSTRAINT [DF_BugNet_IssueComments_DateCreated] DEFAULT (getdate()) NOT NULL,
    [Comment]        NVARCHAR (MAX)   NOT NULL,
    [UserId]         UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BugNet_IssueComments] PRIMARY KEY CLUSTERED ([IssueCommentId] ASC),
    CONSTRAINT [FK_BugNet_IssueComments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

