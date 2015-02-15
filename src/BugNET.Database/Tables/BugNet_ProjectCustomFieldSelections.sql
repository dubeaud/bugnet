CREATE TABLE [dbo].[BugNet_ProjectCustomFieldSelections] (
    [CustomFieldSelectionId]        INT            IDENTITY (1, 1) NOT NULL,
    [CustomFieldId]                 INT            NOT NULL,
    [CustomFieldSelectionValue]     NVARCHAR (255) NOT NULL,
    [CustomFieldSelectionName]      NVARCHAR (255) NOT NULL,
    [CustomFieldSelectionSortOrder] INT            CONSTRAINT [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectCustomFieldSelections] PRIMARY KEY CLUSTERED ([CustomFieldSelectionId] ASC),
    CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId]) ON DELETE CASCADE
);

