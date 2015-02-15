CREATE TABLE [dbo].[BugNet_ProjectCustomFields] (
    [CustomFieldId]       INT           IDENTITY (1, 1) NOT NULL,
    [ProjectId]           INT           NOT NULL,
    [CustomFieldName]     NVARCHAR (50) NOT NULL,
    [CustomFieldRequired] BIT           NOT NULL,
    [CustomFieldDataType] INT           NOT NULL,
    [CustomFieldTypeId]   INT           NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectCustomFields] PRIMARY KEY CLUSTERED ([CustomFieldId] ASC),
    CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType] FOREIGN KEY ([CustomFieldTypeId]) REFERENCES [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

