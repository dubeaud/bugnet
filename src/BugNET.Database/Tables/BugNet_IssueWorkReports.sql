CREATE TABLE [dbo].[BugNet_IssueWorkReports] (
    [IssueWorkReportId] INT              IDENTITY (1, 1) NOT NULL,
    [IssueId]           INT              NOT NULL,
    [WorkDate]          DATETIME         NOT NULL,
    [Duration]          DECIMAL (4, 2)   NOT NULL,
    [IssueCommentId]    INT              NOT NULL,
    [UserId]            UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BugNet_IssueWorkReports] PRIMARY KEY CLUSTERED ([IssueWorkReportId] ASC),
    CONSTRAINT [FK_BugNet_IssueWorkReports_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE
);

