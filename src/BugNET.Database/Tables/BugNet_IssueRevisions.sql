CREATE TABLE [dbo].[BugNet_IssueRevisions] (
    [IssueRevisionId] INT            IDENTITY (1, 1) NOT NULL,
    [Revision]        INT            NOT NULL,
    [IssueId]         INT            NOT NULL,
    [Repository]      NVARCHAR (400) NOT NULL,
    [RevisionAuthor]  NVARCHAR (100) NOT NULL,
    [RevisionDate]    NVARCHAR (100) NOT NULL,
    [RevisionMessage] NVARCHAR (MAX) NOT NULL,
    [DateCreated]     DATETIME       NOT NULL,
    [Branch]          NVARCHAR (255) NULL,
    [Changeset]       NVARCHAR (100) NULL,
    CONSTRAINT [PK_BugNet_IssueRevisions] PRIMARY KEY CLUSTERED ([IssueRevisionId] ASC),
    CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

