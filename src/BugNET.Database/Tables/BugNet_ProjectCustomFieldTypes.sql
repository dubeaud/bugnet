CREATE TABLE [dbo].[BugNet_ProjectCustomFieldTypes] (
    [CustomFieldTypeId]   INT           IDENTITY (1, 1) NOT NULL,
    [CustomFieldTypeName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectCustomFieldTypes] PRIMARY KEY CLUSTERED ([CustomFieldTypeId] ASC)
);

