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


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueHistory_IssueId_UserId_DateCreated] ON [dbo].[BugNet_IssueHistory]
(
	[IssueId] ASC,
	[UserId] ASC,
	[DateCreated] ASC
)
INCLUDE 
( 	
	[IssueHistoryId],
	[FieldChanged],
	[OldValue],
	[NewValue]
)
GO
CREATE STATISTICS [ST_1442104178_6_2] ON [dbo].[BugNet_IssueHistory]([DateCreated], [IssueId])
GO
CREATE STATISTICS [ST_1442104178_7_2_6] ON [dbo].[BugNet_IssueHistory]([UserId], [IssueId], [DateCreated])
GO
CREATE STATISTICS [ST_1442104178_7_3_5_4] ON [dbo].[BugNet_IssueHistory]([UserId], [FieldChanged], [NewValue], [OldValue])
GO
CREATE STATISTICS [ST_1442104178_2_7_3_5] ON [dbo].[BugNet_IssueHistory]([IssueId], [UserId], [FieldChanged], [NewValue])
GO
CREATE STATISTICS [ST_1442104178_2_3_5_4_7] ON [dbo].[BugNet_IssueHistory]([IssueId], [FieldChanged], [NewValue], [OldValue], [UserId])