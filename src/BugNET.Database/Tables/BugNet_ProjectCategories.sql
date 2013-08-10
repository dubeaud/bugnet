CREATE TABLE [dbo].[BugNet_ProjectCategories] (
    [CategoryId]       INT            IDENTITY (1, 1) NOT NULL,
    [CategoryName]     NVARCHAR (100) NOT NULL,
    [ProjectId]        INT            NOT NULL,
    [ParentCategoryId] INT            CONSTRAINT [DF_BugNet_ProjectCategories_ParentCategoryId] DEFAULT ((0)) NOT NULL,
    [Disabled]         BIT            CONSTRAINT [DF_BugNet_ProjectCategories_Disabled] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BugNet_ProjectCategories] PRIMARY KEY CLUSTERED ([CategoryId] ASC),
    CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BugNet_Projects] ([ProjectId]) ON DELETE CASCADE
);

