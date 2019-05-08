CREATE TABLE [dbo].[BugNet_WikiContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TitleId] [int] NOT NULL,
	[Source] [nvarchar](max) NOT NULL,
	[Version] [int] NOT NULL CONSTRAINT [DF_BugNet_WikiContent_Version]  DEFAULT ((1)),
	[VersionDate] [datetime] NOT NULL CONSTRAINT [DF_BugNet_WikiContent_VersionDate]  DEFAULT (getdate()),
	[UserId] UNIQUEIDENTIFIER NULL, 
    CONSTRAINT [PK_BugNet_WikiContent] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_BugNet_WikiContent_BugNet_WikiTitle] FOREIGN KEY([TitleId]) REFERENCES [dbo].[BugNet_WikiTitle] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_BugNet_WikiContent_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
)
