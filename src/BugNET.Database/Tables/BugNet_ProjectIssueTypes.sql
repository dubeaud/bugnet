CREATE TABLE [dbo].[BugNet_ProjectIssueTypes] (
    [IssueTypeId]       INT           IDENTITY (1, 1) NOT NULL,
    [ProjectId]         INT           NOT NULL,
    [IssueTypeName]     NVARCHAR (50) NOT NULL,
    [IssueTypeImageUrl] NVARCHAR (50) NOT NULL,
    [SortOrder]         INT           NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectIssueTypes] PRIMARY KEY CLUSTERED ([IssueTypeId] ASC),
    CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

