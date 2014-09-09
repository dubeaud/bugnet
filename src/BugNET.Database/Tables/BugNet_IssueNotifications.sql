CREATE TABLE [dbo].[BugNet_IssueNotifications] (
    [IssueNotificationId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]             INT              NOT NULL,
    [UserId]              UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BugNet_IssueNotifications] PRIMARY KEY CLUSTERED ([IssueNotificationId] ASC),
    CONSTRAINT [FK_BugNet_IssueNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

