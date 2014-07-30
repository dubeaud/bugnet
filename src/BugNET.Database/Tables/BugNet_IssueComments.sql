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


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueComments_IssueId_UserId_DateCreated] ON [dbo].[BugNet_IssueComments]
(
	[IssueId] ASC,
	[UserId] ASC,
	[DateCreated] ASC
)
INCLUDE 
(
	[IssueCommentId], 
	[Comment]
)
GO
CREATE STATISTICS [ST_1474104292_3_2] ON [dbo].[BugNet_IssueComments]([DateCreated], [IssueId])
GO
CREATE STATISTICS [ST_1474104292_1_5] ON [dbo].[BugNet_IssueComments]([IssueCommentId], [UserId])
GO
CREATE STATISTICS [ST_1474104292_2_1] ON [dbo].[BugNet_IssueComments]([IssueId], [IssueCommentId])
GO
CREATE STATISTICS [ST_1474104292_5_2_3] ON [dbo].[BugNet_IssueComments]([UserId], [IssueId], [DateCreated])