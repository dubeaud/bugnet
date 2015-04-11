CREATE TABLE [dbo].[BugNet_ProjectMailBoxes] (
    [ProjectMailboxId] INT              IDENTITY (1, 1) NOT NULL,
    [MailBox]          NVARCHAR (100)   NOT NULL,
    [ProjectId]        INT              NOT NULL,
    [AssignToUserId]   UNIQUEIDENTIFIER NULL,
    [IssueTypeId]      INT              NULL,
	[CategoryId]      INT              NULL,
    CONSTRAINT [PK_BugNet_ProjectMailBoxes] PRIMARY KEY CLUSTERED ([ProjectMailboxId] ASC),
    CONSTRAINT [FK_BugNet_ProjectMailBoxes_Users] FOREIGN KEY ([AssignToUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes] FOREIGN KEY ([IssueTypeId]) REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId]),
    CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[BugNet_ProjectCategories] ([CategoryId]),
    CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

