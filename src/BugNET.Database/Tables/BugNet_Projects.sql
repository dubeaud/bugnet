CREATE TABLE [dbo].[BugNet_Projects] (
    [ProjectId]               INT              IDENTITY (1, 1) NOT NULL,
    [ProjectName]             NVARCHAR (50)    NOT NULL,
    [ProjectCode]             NVARCHAR (50)    NOT NULL,
    [ProjectDescription]      NVARCHAR (MAX)   NOT NULL,
    [AttachmentUploadPath]    NVARCHAR (256)   NOT NULL,
    [DateCreated]             DATETIME         CONSTRAINT [DF_BugNet_Projects_DateCreated] DEFAULT (getdate()) NOT NULL,
    [ProjectDisabled]         BIT              CONSTRAINT [DF_BugNet_Projects_Active] DEFAULT ((0)) NOT NULL,
    [ProjectAccessType]       INT              NOT NULL,
    [ProjectManagerUserId]    UNIQUEIDENTIFIER NOT NULL,
    [ProjectCreatorUserId]    UNIQUEIDENTIFIER NOT NULL,
    [AllowAttachments]        BIT              CONSTRAINT [DF_BugNet_Projects_AllowAttachments] DEFAULT ((1)) NOT NULL,
	[AttachmentStorageType]   INT              NULL,
    [SvnRepositoryUrl]        NVARCHAR (255)   NULL,
    [AllowIssueVoting]        BIT              CONSTRAINT [DF_BugNet_Projects_AllowIssueVoting] DEFAULT ((1)) NOT NULL,
    [ProjectImageFileContent] VARBINARY (MAX)  NULL,
    [ProjectImageFileName]    NVARCHAR (150)   NULL,
    [ProjectImageContentType] NVARCHAR (50)    NULL,
    [ProjectImageFileSize]    BIGINT           NULL,
    CONSTRAINT [PK_BugNet_Projects] PRIMARY KEY CLUSTERED ([ProjectId] ASC),
    CONSTRAINT [FK_BugNet_Projects_Users] FOREIGN KEY ([ProjectCreatorUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_BugNet_Projects_Users1] FOREIGN KEY ([ProjectManagerUserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE STATISTICS [ST_1813581499_7_8] ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectAccessType])
GO
CREATE STATISTICS [ST_1813581499_10_9_8] ON [dbo].[BugNet_Projects]([ProjectCreatorUserId], [ProjectManagerUserId], [ProjectAccessType])
GO
CREATE STATISTICS [ST_1813581499_9_1_7] ON [dbo].[BugNet_Projects]([ProjectManagerUserId], [ProjectId], [ProjectDisabled])
GO
CREATE STATISTICS [ST_1813581499_8_9_7_10] ON [dbo].[BugNet_Projects]([ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId])
GO
CREATE STATISTICS [ST_1813581499_1_10_9_7] ON [dbo].[BugNet_Projects]([ProjectId], [ProjectCreatorUserId], [ProjectManagerUserId], [ProjectDisabled])
GO
CREATE STATISTICS [ST_1813581499_7_1_8_10] ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectId], [ProjectAccessType], [ProjectCreatorUserId])
GO
CREATE STATISTICS [ST_1813581499_2_1_8_9_7] ON [dbo].[BugNet_Projects]([ProjectName], [ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled])
GO
CREATE STATISTICS [ST_1813581499_1_8_9_7_10_2] ON [dbo].[BugNet_Projects]([ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId], [ProjectName])