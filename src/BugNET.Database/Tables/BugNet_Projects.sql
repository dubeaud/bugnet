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

