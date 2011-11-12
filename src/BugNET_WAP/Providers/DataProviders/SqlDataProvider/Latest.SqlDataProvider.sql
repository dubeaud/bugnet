/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO
/* Create new category disabled column */
ALTER TABLE [dbo].[BugNet_ProjectCategories] ADD [Disabled] [bit] DEFAULT 0 NOT NULL
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_DeleteCategory]    Script Date: 02/16/2011 13:01:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId Int 
AS
UPDATE BugNet_ProjectCategories SET
	[Disabled] = 1
WHERE
	CategoryId = @CategoryId
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]    Script Date: 02/16/2011 13:01:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount,
	Disabled
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId AND [Disabled] = 0
ORDER BY CategoryName


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]    Script Date: 02/16/2011 13:02:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
c.ParentCategoryId = @CategoryId AND [Disabled] = 0
ORDER BY CategoryName


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]    Script Date: 02/16/2011 13:03:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId AND c.ParentCategoryId = 0 AND [Disabled] = 0
ORDER BY CategoryName

GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]    Script Date: 02/16/2011 12:44:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]
	@MailBox nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeID int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM aspnet_users WHERE Username = @AssignToUserName
	
INSERT BugNet_ProjectMailBoxes 
(
	MailBox,
	ProjectId,
	AssignToUserId,
	IssueTypeID
)
VALUES
(
	@MailBox,
	@ProjectId,
	@AssignToUserId,
	@IssueTypeId
)
RETURN scope_identity()
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]    Script Date: 02/16/2011 12:44:55 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]
	@ProjectMailboxId int
AS
DELETE  
	BugNet_ProjectMailBoxes 
WHERE
	ProjectMailboxId = @ProjectMailboxId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]    Script Date: 02/16/2011 12:45:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId int
AS

SELECT BugNet_ProjectMailboxes.*,
	u.Username AssignToUserName,
	p.DisplayName AssignToDisplayName,
	BugNet_ProjectIssueTypes.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes ON BugNet_ProjectIssueTypes.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]    Script Date: 02/16/2011 12:45:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
    (
    @mailbox nvarchar(256)
    )
    
AS
    SET NOCOUNT ON
    
SELECT     BugNet_ProjectMailBoxes.MailBox, BugNet_ProjectMailBoxes.ProjectMailboxId, BugNet_ProjectMailBoxes.ProjectId,
                      BugNet_ProjectMailBoxes.IssueTypeId, Users.UserName AS AssignToName, BugNet_ProjectMailBoxes.AssignToUserId,
                      BugNet_ProjectIssueTypes.IssueTypeName
FROM         BugNet_Projects INNER JOIN
                      BugNet_ProjectMailBoxes ON BugNet_ProjectMailBoxes.ProjectId = BugNet_Projects.ProjectId INNER JOIN
                      aspnet_Users AS Users ON BugNet_ProjectMailBoxes.AssignToUserId = Users.UserId INNER JOIN
                      BugNet_ProjectIssueTypes ON BugNet_Projects.ProjectId = BugNet_ProjectIssueTypes.ProjectId AND
                      BugNet_ProjectMailBoxes.IssueTypeId = BugNet_ProjectIssueTypes.IssueTypeId
WHERE     (BugNet_ProjectMailBoxes.MailBox = @mailbox)


GO

/****** Object:  StoredProcedure [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]    Script Date: 02/16/2011 12:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]
	@ProjectMailboxId int,
	@MailBoxEmailAddress nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeId int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM aspnet_users WHERE Username = @AssignToUserName

UPDATE BugNet_ProjectMailBoxes SET
	MailBox = @MailBoxEmailAddress,
	ProjectId = @ProjectId,
	AssignToUserId = @AssignToUserId,
	IssueTypeId = @IssueTypeId
WHERE ProjectMailboxId = @ProjectMailboxId
GO

UPDATE BugNet_HostSettings SET SettingName = 'UserRegistration' WHERE SettingName = 'DisableUserRegistration'
UPDATE BugNet_HostSettings SET SettingValue = '0' WHERE SettingName ='UserRegistration'
UPDATE BugNet_HostSettings SET SettingName = 'AnonymousAccess' WHERE SettingName = 'DisableAnonymousAccess'
UPDATE BugNet_HostSettings SET SettingValue = 'False' WHERE SettingName ='AnonymousAccess'
GO

DROP TABLE BugNet_StringResources 
GO

CREATE TABLE [BugNet_Languages] (
		[LanguageId]          int NOT NULL IDENTITY(1, 1),
		[CultureCode]         nvarchar(50) NOT NULL,
		[CultureName]         nvarchar(200) NOT NULL,
		[FallbackCulture]     nvarchar(50) NULL
)
GO

ALTER TABLE [BugNet_Languages]
	ADD
	CONSTRAINT [PK_BugNet_Languages]
	PRIMARY KEY
	([LanguageId])
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_BugNet_Languages ON BugNet_Languages ( CultureCode )
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Languages_GetInstalledLanguages]    Script Date: 04/15/2011 12:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Languages_GetInstalledLanguages]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT cultureCode FROM BugNet_Languages
END
GO

DROP PROCEDURE BugNet_StringResources_GetInstalledLanguageResources
GO



/****** Object:  Table [dbo].[BugNet_ProjectIssueFields]    Script Date: 04/27/2011 14:33:13 
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BugNet_ProjectIssueFields](
	[ProjectIssueFieldId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[IssueFieldId] [nvarchar](50) NOT NULL,
	[Required] [bit] NOT NULL,
	[ShowOnNewIssue] [bit] NOT NULL,
	[ShowOnEditIssue] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectIssueFields] PRIMARY KEY CLUSTERED 
(
	[ProjectIssueFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[BugNet_ProjectIssueFields]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectIssueFields_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
GO

ALTER TABLE [dbo].[BugNet_ProjectIssueFields] CHECK CONSTRAINT [FK_BugNet_ProjectIssueFields_BugNet_Projects]
GO
******/


INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('ApplicationDefaultLanguage','en-US')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('Pop3ProcessAttachments','False')

PRINT N'Updating Permission keys'
UPDATE BugNet_Permissions SET PermissionKey = 'CloseIssue' WHERE PermissionId = 1
UPDATE BugNet_Permissions SET PermissionKey = 'AddIssue' WHERE PermissionId = 2
UPDATE BugNet_Permissions SET PermissionKey = 'AssignIssue' WHERE PermissionId = 3
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssue' WHERE PermissionId = 4
UPDATE BugNet_Permissions SET PermissionKey = 'SubscribeIssue' WHERE PermissionId = 5
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteIssue' WHERE PermissionId = 6
UPDATE BugNet_Permissions SET PermissionKey = 'AddComment' WHERE PermissionId = 7
UPDATE BugNet_Permissions SET PermissionKey = 'EditComment' WHERE PermissionId = 8
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteComment' WHERE PermissionId = 9
UPDATE BugNet_Permissions SET PermissionKey = 'AddAttachment' WHERE PermissionId = 10
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteAttachment' WHERE PermissionId = 11
UPDATE BugNet_Permissions SET PermissionKey = 'AddRelated' WHERE PermissionId = 12
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteRelated' WHERE PermissionId = 13
UPDATE BugNet_Permissions SET PermissionKey = 'ReopenIssue' WHERE PermissionId = 14
UPDATE BugNet_Permissions SET PermissionKey = 'OwnerEditComment' WHERE PermissionId = 15
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssueDescription' WHERE PermissionId = 16
UPDATE BugNet_Permissions SET PermissionKey = 'EditIssueTitle' WHERE PermissionId = 17
UPDATE BugNet_Permissions SET PermissionKey = 'AdminEditProject' WHERE PermissionId = 18
UPDATE BugNet_Permissions SET PermissionKey = 'AddTimeEntry' WHERE PermissionId = 19
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteTimeEntry' WHERE PermissionId = 20
UPDATE BugNet_Permissions SET PermissionKey = 'AdminCreateProject' WHERE PermissionId = 21
UPDATE BugNet_Permissions SET PermissionKey = 'AddQuery' WHERE PermissionId = 22
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteQuery' WHERE PermissionId = 23
UPDATE BugNet_Permissions SET PermissionKey = 'AdminCloneProject' WHERE PermissionId = 24
UPDATE BugNet_Permissions SET PermissionKey = 'AddSubIssue' WHERE PermissionId = 25
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteSubIssue' WHERE PermissionId = 26
UPDATE BugNet_Permissions SET PermissionKey = 'AddParentIssue' WHERE PermissionId = 27
UPDATE BugNet_Permissions SET PermissionKey = 'DeleteParentIssue' WHERE PermissionId = 28
UPDATE BugNet_Permissions SET PermissionKey = 'AdminDeleteProject' WHERE PermissionId = 29
UPDATE BugNet_Permissions SET PermissionKey = 'ViewProjectCalendar' WHERE PermissionId = 30
UPDATE BugNet_Permissions SET PermissionKey = 'ChangeIssueStatus' WHERE PermissionId = 31
UPDATE BugNet_Permissions SET PermissionKey = 'EditQuery' WHERE PermissionId = 32
GO

COMMIT

SET NOEXEC OFF
GO