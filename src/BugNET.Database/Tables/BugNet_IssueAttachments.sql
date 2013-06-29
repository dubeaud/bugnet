CREATE TABLE [dbo].[BugNet_IssueAttachments] (
    [IssueAttachmentId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]           INT              NOT NULL,
    [FileName]          NVARCHAR (250)   NOT NULL,
    [Description]       NVARCHAR (80)    NOT NULL,
    [FileSize]          INT              NOT NULL,
    [ContentType]       NVARCHAR (50)    NOT NULL,
    [DateCreated]       DATETIME         CONSTRAINT [DF_BugNet_IssueAttachments_DateCreated] DEFAULT (getdate()) NOT NULL,
    [UserId]            UNIQUEIDENTIFIER NOT NULL,
    [Attachment]        VARBINARY (MAX)  NULL,
    CONSTRAINT [PK_BugNet_IssueAttachments] PRIMARY KEY CLUSTERED ([IssueAttachmentId] ASC),
    CONSTRAINT [FK_BugNet_IssueAttachments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

