CREATE TABLE [dbo].[BugNet_ApplicationLog] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Date]      DATETIME       NOT NULL,
    [Thread]    VARCHAR (255)  NOT NULL,
    [Level]     VARCHAR (50)   NOT NULL,
    [Logger]    VARCHAR (255)  NOT NULL,
    [User]      NVARCHAR (50)  NOT NULL,
    [Message]   VARCHAR (4000) NOT NULL,
    [Exception] VARCHAR (2000) NULL,
    CONSTRAINT [PK_BugNet_ApplicationLog] PRIMARY KEY CLUSTERED ([Id] ASC)
);

