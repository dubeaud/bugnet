CREATE TABLE [dbo].[BugNet_UserCustomFieldTypes] (
    [CustomFieldTypeId]   INT           IDENTITY (1, 1) NOT NULL,
    [CustomFieldTypeName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_BugNet_UserCustomFieldTypes] PRIMARY KEY CLUSTERED ([CustomFieldTypeId] ASC)
);

