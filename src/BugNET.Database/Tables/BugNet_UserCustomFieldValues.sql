CREATE TABLE [dbo].[BugNet_UserCustomFieldValues] (
    [CustomFieldValueId] INT              IDENTITY (1, 1) NOT NULL,
    [UserId]           	 UNIQUEIDENTIFIER NOT NULL,
    [CustomFieldId]      INT              NOT NULL,
    [CustomFieldValue]   NVARCHAR (MAX)   NOT NULL,
    CONSTRAINT [PK_BugNet_UserCustomFieldValues] PRIMARY KEY CLUSTERED ([CustomFieldValueId] ASC),
    CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_UserCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BugNet_UserCustomFields] ([CustomFieldId])
);

