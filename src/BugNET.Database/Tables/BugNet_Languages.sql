CREATE TABLE [dbo].[BugNet_Languages] (
    [LanguageId]      INT            IDENTITY (1, 1) NOT NULL,
    [CultureCode]     NVARCHAR (50)  NOT NULL,
    [CultureName]     NVARCHAR (200) NOT NULL,
    [FallbackCulture] NVARCHAR (50)  NULL,
    CONSTRAINT [PK_BugNet_Languages] PRIMARY KEY CLUSTERED ([LanguageId] ASC)
);

