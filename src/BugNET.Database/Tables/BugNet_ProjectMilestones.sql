CREATE TABLE [dbo].[BugNet_ProjectMilestones] (
    [MilestoneId]          INT            IDENTITY (1, 1) NOT NULL,
    [ProjectId]            INT            NOT NULL,
    [MilestoneName]        NVARCHAR (50)  NOT NULL,
    [MilestoneImageUrl]    NVARCHAR (50)  NOT NULL,
    [SortOrder]            INT            NOT NULL,
    [DateCreated]          DATETIME       CONSTRAINT [DF_BugNet_ProjectMilestones_CreateDate] DEFAULT (getdate()) NOT NULL,
    [MilestoneDueDate]     DATETIME       NULL,
    [MilestoneReleaseDate] DATETIME       NULL,
    [MilestoneNotes]       NVARCHAR (MAX) NULL,
    [MilestoneCompleted]   BIT            CONSTRAINT [DF_BugNet_ProjectMilestones_Completed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectMilestones] PRIMARY KEY CLUSTERED ([MilestoneId] ASC),
    CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

