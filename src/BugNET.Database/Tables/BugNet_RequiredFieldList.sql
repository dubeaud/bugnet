CREATE TABLE [dbo].[BugNet_RequiredFieldList] (
    [RequiredFieldId] INT           NOT NULL,
    [FieldName]       NVARCHAR (50) NOT NULL,
    [FieldValue]      NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_BugNet_RequiredFieldList] PRIMARY KEY CLUSTERED ([RequiredFieldId] ASC)
);

