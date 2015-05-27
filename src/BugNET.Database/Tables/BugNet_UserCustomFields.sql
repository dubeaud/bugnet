CREATE TABLE [dbo].[BugNet_UserCustomFields] (
    [CustomFieldId]       INT              IDENTITY (1, 1) NOT NULL,
    [CustomFieldName]     NVARCHAR (50)    NOT NULL,
    [CustomFieldRequired] BIT              NOT NULL,
    [CustomFieldDataType] INT              NOT NULL,
    [CustomFieldTypeId]   INT              NOT NULL,
    CONSTRAINT [PK_BugNet_UserCustomFields] PRIMARY KEY CLUSTERED ([CustomFieldId] ASC),
    CONSTRAINT [FK_BugNet_UserCustomFields_BugNet_UserCustomFieldType] FOREIGN KEY ([CustomFieldTypeId]) REFERENCES [dbo].[BugNet_UserCustomFieldTypes] ([CustomFieldTypeId]) ON DELETE CASCADE
);

