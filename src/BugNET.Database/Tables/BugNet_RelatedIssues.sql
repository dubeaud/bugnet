CREATE TABLE [dbo].[BugNet_RelatedIssues] (
    [PrimaryIssueId]   INT NOT NULL,
    [SecondaryIssueId] INT NOT NULL,
    [RelationType]     INT NOT NULL,
	CONSTRAINT [PK_BugNet_RelatedIssues] PRIMARY KEY CLUSTERED ([PrimaryIssueId] ASC, [SecondaryIssueId] ASC, [RelationType] ASC),
    CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues] FOREIGN KEY ([PrimaryIssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1] FOREIGN KEY ([SecondaryIssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId])
);

