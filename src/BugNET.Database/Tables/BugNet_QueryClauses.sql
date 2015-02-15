CREATE TABLE [dbo].[BugNet_QueryClauses] (
    [QueryClauseId]      INT           IDENTITY (1, 1) NOT NULL,
    [QueryId]            INT           NOT NULL,
    [BooleanOperator]    NVARCHAR (50) NOT NULL,
    [FieldName]          NVARCHAR (50) NOT NULL,
    [ComparisonOperator] NVARCHAR (50) NOT NULL,
    [FieldValue]         NVARCHAR (50) NOT NULL,
    [DataType]           INT           NOT NULL,
    [CustomFieldId]      INT           NULL,
    CONSTRAINT [PK_BugNet_QueryClauses] PRIMARY KEY CLUSTERED ([QueryClauseId] ASC),
    CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries] FOREIGN KEY ([QueryId]) REFERENCES [dbo].[BugNet_Queries] ([QueryId]) ON DELETE CASCADE
);

