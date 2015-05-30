CREATE TABLE [dbo].[BugNet_ProjectCustomFieldValues] (
    [CustomFieldValueId] INT            IDENTITY (1, 1) NOT NULL,
    [IssueId]            INT            NOT NULL,
    [CustomFieldId]      INT            NOT NULL,
    [CustomFieldValue]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_BugNet_ProjectCustomFieldValues] PRIMARY KEY CLUSTERED ([CustomFieldValueId] ASC),
    CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BugNet_Issues] ([IssueId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId])
);

