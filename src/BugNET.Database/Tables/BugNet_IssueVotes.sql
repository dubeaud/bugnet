CREATE TABLE [dbo].[BugNet_IssueVotes] (
    [IssueVoteId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]     INT              NOT NULL,
    [UserId]      UNIQUEIDENTIFIER NOT NULL,
    [DateCreated] DATETIME         NOT NULL,
    CONSTRAINT [PK_BugNet_IssueVotes] PRIMARY KEY CLUSTERED ([IssueVoteId] ASC),
    CONSTRAINT [FK_BugNet_IssueVotes_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId])
);

