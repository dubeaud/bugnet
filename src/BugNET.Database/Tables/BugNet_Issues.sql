CREATE TABLE [dbo].[BugNet_Issues] (
    [IssueId]                  INT              IDENTITY (1, 1) NOT NULL,
    [IssueTitle]               NVARCHAR (500)   NOT NULL,
    [IssueDescription]         NVARCHAR (MAX)   NOT NULL,
    [IssueStatusId]            INT              NULL,
    [IssuePriorityId]          INT              NULL,
    [IssueTypeId]              INT              NULL,
    [IssueCategoryId]          INT              NULL,
    [ProjectId]                INT              NOT NULL,
    [IssueAffectedMilestoneId] INT              NULL,
    [IssueResolutionId]        INT              NULL,
    [IssueCreatorUserId]       UNIQUEIDENTIFIER NOT NULL,
    [IssueAssignedUserId]      UNIQUEIDENTIFIER NULL,
    [IssueOwnerUserId]         UNIQUEIDENTIFIER NULL,
    [IssueDueDate]             DATETIME         CONSTRAINT [DF_BugNet_Issues_DueDate] DEFAULT ('1/1/1900 12:00:00 AM') NULL,
    [IssueMilestoneId]         INT              NULL,
    [IssueVisibility]          INT              NOT NULL,
    [IssueEstimation]          DECIMAL (5, 2)   CONSTRAINT [DF_BugNet_Issues_Estimation] DEFAULT ((0)) NOT NULL,
    [IssueProgress]            INT              CONSTRAINT [DF_BugNet_Issues_IssueProgress] DEFAULT ((0)) NOT NULL,
    [DateCreated]              DATETIME         CONSTRAINT [DF_BugNet_Issues_DateCreated] DEFAULT (getdate()) NOT NULL,
    [LastUpdate]               DATETIME         NOT NULL,
    [LastUpdateUserId]         UNIQUEIDENTIFIER NOT NULL,
    [Disabled]                 BIT              CONSTRAINT [DF_BugNet_Issues_Disabled] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_Issues] PRIMARY KEY CLUSTERED ([IssueId] ASC),
    CONSTRAINT [FK_BugNet_Issues_Users] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Issues_Users1] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Issues_Users2] FOREIGN KEY ([LastUpdateUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Issues_Users3] FOREIGN KEY ([IssueCreatorUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories] FOREIGN KEY ([IssueCategoryId]) REFERENCES [dbo].[BugNet_ProjectCategories] ([CategoryId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes] FOREIGN KEY ([IssueTypeId]) REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones] FOREIGN KEY ([IssueMilestoneId]) REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1] FOREIGN KEY ([IssueAffectedMilestoneId]) REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities] FOREIGN KEY ([IssuePriorityId]) REFERENCES [dbo].[BugNet_ProjectPriorities] ([PriorityId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions] FOREIGN KEY ([IssueResolutionId]) REFERENCES [dbo].[BugNet_ProjectResolutions] ([ResolutionId]),
    CONSTRAINT [FK_BugNet_Issues_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus] FOREIGN KEY ([IssueStatusId]) REFERENCES [dbo].[BugNet_ProjectStatus] ([StatusId])
);


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20] ON [dbo].[BugNet_Issues]
(
	[IssueAssignedUserId] ASC,
	[Disabled] ASC,
	[IssueId] ASC,
	[IssueMilestoneId] ASC,
	[IssueAffectedMilestoneId] ASC,
	[ProjectId] ASC,
	[IssueTypeId] ASC,
	[IssuePriorityId] ASC,
	[IssueCategoryId] ASC,
	[IssueStatusId] ASC,
	[IssueResolutionId] ASC,
	[LastUpdateUserId] ASC,
	[IssueCreatorUserId] ASC,
	[IssueOwnerUserId] ASC
)
INCLUDE 
( 	
	[IssueTitle],
	[IssueDescription],
	[IssueDueDate],
	[IssueVisibility],
	[IssueEstimation],
	[IssueProgress],
	[DateCreated],
	[LastUpdate])
GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20] ON [dbo].[BugNet_Issues]
(
	[ProjectId] ASC,
	[Disabled] ASC,
	[IssueId] ASC,
	[IssueOwnerUserId] ASC,
	[IssueCreatorUserId] ASC,
	[LastUpdateUserId] ASC,
	[IssueAssignedUserId] ASC,
	[IssueResolutionId] ASC,
	[IssueMilestoneId] ASC,
	[IssueAffectedMilestoneId] ASC,
	[IssueStatusId] ASC,
	[IssueCategoryId] ASC,
	[IssuePriorityId] ASC,
	[IssueTypeId] ASC
)
INCLUDE 
( 	
	[IssueTitle],
	[IssueDescription],
	[IssueDueDate],
	[IssueVisibility],
	[IssueEstimation],
	[IssueProgress],
	[DateCreated],
	[LastUpdate]
) 
GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueId_ProjectId_Disabled] ON [dbo].[BugNet_Issues]
(
	[IssueId] DESC,
	[ProjectId] ASC,
	[Disabled] ASC
)
INCLUDE 
(
	[IssueStatusId]
) 
GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId] ON [dbo].[BugNet_Issues]
(
	[IssueCategoryId] ASC,
	[ProjectId] ASC,
	[Disabled] ASC,
	[IssueStatusId] ASC
)
GO
CREATE STATISTICS [ST_914102297_1_9] ON [dbo].[BugNet_Issues]([IssueId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_12_4] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_21_1] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueId])
GO
CREATE STATISTICS [ST_914102297_13_12] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueAssignedUserId])
GO
CREATE STATISTICS [ST_914102297_5_1] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueId])
GO
CREATE STATISTICS [ST_914102297_4_8_11] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_15_8_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [ProjectId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_10_8_11] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_10_1_4] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_15_4_8] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueStatusId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_4_8_7] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_22_12_13] ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [IssueOwnerUserId])
GO
CREATE STATISTICS [ST_914102297_5_8_11] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_4_8_13] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueOwnerUserId])
GO
CREATE STATISTICS [ST_914102297_7_8_13] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueOwnerUserId])
GO
CREATE STATISTICS [ST_914102297_5_8_22] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_1_4_22] ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_7_1_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_22_15_4] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_22_7_4] ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_4_1_22] ON [dbo].[BugNet_Issues]([IssueStatusId], [IssueId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_10_8_13] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueOwnerUserId])
GO
CREATE STATISTICS [ST_914102297_6_8_13] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueOwnerUserId])
GO
CREATE STATISTICS [ST_914102297_8_13_22_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_11_10_15_9] ON [dbo].[BugNet_Issues]([IssueCreatorUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_12_10_15_9] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_15] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_7_22_4] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCategoryId], [Disabled], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_22_5_8_4] ON [dbo].[BugNet_Issues]([Disabled], [IssuePriorityId], [ProjectId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_8_22_4_6] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueStatusId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_22_12_8_15] ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [ProjectId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_15_9_12] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId])
GO
CREATE STATISTICS [ST_914102297_1_4_6_5] ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_6_12_8_22] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [ProjectId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_15_9_4_8] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_12_22_21_11] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [Disabled], [LastUpdateUserId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_4_8_22_15] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_15_9_8_11] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_15_9_8_13_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueOwnerUserId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_6_12_22_15_9] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_15_9_4_8] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_8_12_22_1_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_10_15_9_11] ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_1_12_8_22_15] ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_12_22_6_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueTypeId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_13_22_12_21] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueAssignedUserId], [LastUpdateUserId])
GO
CREATE STATISTICS [ST_914102297_8_11_22_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_13_11_21_12_8] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_1_8_22_10_15] ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_10_15_9_12] ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId])
GO
CREATE STATISTICS [ST_914102297_13_10_15_9_22] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_5_8_12_22_1_4] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_12_8_22_1_21_11] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [LastUpdateUserId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_4_8_22_1_10_15] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_13_22_6_10_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_15_9_12_8_22_1] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId])
GO
CREATE STATISTICS [ST_914102297_6_8_11_22_10_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_12_15_9_22_8_6] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [ProjectId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_6_4_8_22_1_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_4_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_6_8_12_22_10_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_9_15_1_6_5_7] ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_12_8_22_1_6_15_9] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_10_8_22_1_13_11_21] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId])
GO
CREATE STATISTICS [ST_914102297_8_11_22_5_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_12_21_11_13_4_8_22] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueStatusId], [ProjectId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_7_8_12_22_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_5_8_12_22_10_15_9] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_6_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_5_4_8_22_1_15_9] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_13_8_10_15_9_6] ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_8_12_22_1_7_4_6] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueCategoryId], [IssueStatusId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_10_22_13_11_21_12_15] ON [dbo].[BugNet_Issues]([IssueResolutionId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_10_1_6_5_7_4_9] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_22_1_13_11_21_12_10_15] ON [dbo].[BugNet_Issues]([Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_8_13_22_7_10_15_9_6] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueCategoryId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_4_8_12_22_15_9_6_5] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_5_10_15_9_4] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_5_12_8_22_1_15_9_4] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_7_8_11_22_10_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_7_4_8_22_1_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_7_8_12_22_10_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_4_8_12_22_10_15_9_6_5] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_8_11_22_4_10_15_9_6_5] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_10_8_12_22_15_9_6_5_7] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_9_15_8_12_22_1_4_6_5] ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_22_8_10_15_9_1_4_6_5] ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_8_22_13_11_21_12_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_7_12_8_22_1_15_9_4_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_15_9_8_22_1_13_11_21_12] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId])
GO
CREATE STATISTICS [ST_914102297_8_13_22_4_10_15_9_6_5] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_10_12_8_22_1_15_9_4_6_5] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_10_8_12_22_1_4_6_5_7_9] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAffectedMilestoneId])
GO
CREATE STATISTICS [ST_914102297_6_22_13_11_21_12_10_15_9_1] ON [dbo].[BugNet_Issues]([IssueTypeId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_4_13_11_21_12_10_15] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_1_12_21_11_13_6_5_7_4_9_15] ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId])
GO
CREATE STATISTICS [ST_914102297_5_22_13_11_21_12_10_15_9_1_8] ON [dbo].[BugNet_Issues]([IssuePriorityId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5] ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [ProjectId], [IssueOwnerUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
CREATE STATISTICS [ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssuePriorityId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11] ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6] ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId])
GO
CREATE STATISTICS [ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8] ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [IssueId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5] ON [dbo].[BugNet_Issues]([Disabled], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId])
GO
CREATE STATISTICS [ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId])
GO
CREATE STATISTICS [ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
CREATE STATISTICS [ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId])
GO
CREATE STATISTICS [ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAssignedUserId], [LastUpdateUserId], [IssueOwnerUserId], [IssueId], [Disabled])
GO
CREATE STATISTICS [ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId])