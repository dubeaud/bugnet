CREATE TABLE [dbo].[BugNet_ProjectNotifications] (
    [ProjectNotificationId] INT              IDENTITY (1, 1) NOT NULL,
    [ProjectId]             INT              NOT NULL,
    [UserId]                UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectNotifications] PRIMARY KEY CLUSTERED ([ProjectNotificationId] ASC),
    CONSTRAINT [FK_BugNet_ProjectNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

