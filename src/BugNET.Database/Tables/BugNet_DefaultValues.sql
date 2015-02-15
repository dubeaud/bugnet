CREATE TABLE [dbo].[BugNet_DefaultValues] (
    [ProjectId]                INT              NOT NULL,
    [DefaultType]              INT              NULL,
    [StatusId]                 INT              NULL,
    [IssueOwnerUserId]         UNIQUEIDENTIFIER NULL,
    [IssuePriorityId]          INT              NULL,
    [IssueAffectedMilestoneId] INT              NULL,
    [IssueAssignedUserId]      UNIQUEIDENTIFIER NULL,
    [IssueVisibility]          INT              NULL,
    [IssueCategoryId]          INT              NULL,
    [IssueDueDate]             INT              NULL,
    [IssueProgress]            INT              NULL,
    [IssueMilestoneId]         INT              NULL,
    [IssueEstimation]          DECIMAL (5, 2)   NULL,
    [IssueResolutionId]        INT              NULL,
    [OwnedByNotify]            BIT              CONSTRAINT [DF_BugNet_DefaultValues_OwnedByNotify] DEFAULT ((1)) NULL,
    [AssignedToNotify]         BIT              CONSTRAINT [DF_BugNet_DefaultValues_AssignedTo] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_BugNet_DefaultValues] PRIMARY KEY CLUSTERED ([ProjectId] ASC),
    CONSTRAINT [FK_BugNet_DefaultValues_Users] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_DefaultValues_Users1] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_DefaultValues_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

