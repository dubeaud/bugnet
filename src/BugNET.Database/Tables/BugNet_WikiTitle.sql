CREATE TABLE [dbo].[BugNet_WikiTitle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Slug] [nvarchar](255) NOT NULL,
	CONSTRAINT [PK_BugNet_WikiTitle] PRIMARY KEY CLUSTERED ([Id] ASC)
)