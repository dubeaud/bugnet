CREATE TABLE [dbo].[BugNet_UserCustomFieldSelections] (
    [CustomFieldSelectionId]        INT            IDENTITY (1, 1) NOT NULL,
    [CustomFieldId]                 INT            NOT NULL,
    [CustomFieldSelectionValue]     NVARCHAR (255) NOT NULL,
    [CustomFieldSelectionName]      NVARCHAR (255) NOT NULL,
    [CustomFieldSelectionSortOrder] INT            CONSTRAINT [DF_BugNet_UserCustomFieldSelections_CustomFieldSelectionSortOrder] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_UserCustomFieldSelections] PRIMARY KEY CLUSTERED ([CustomFieldSelectionId] ASC),
    CONSTRAINT [FK_BugNet_UserCustomFieldSelections_BugNet_UserCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BugNet_UserCustomFields] ([CustomFieldId]) ON DELETE CASCADE
);

