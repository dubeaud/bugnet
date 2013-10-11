/****** Object:  Table [dbo].[Applications]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationName] [nvarchar](235) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Memberships](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
	[Comment] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [nvarchar](4000) NOT NULL,
	[PropertyValueStrings] [nvarchar](4000) NOT NULL,
	[PropertyValueBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 5/19/2013 4:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipApplication]
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipUser]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [UserProfile]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [RoleApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleApplication]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [UserApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [UserApplication]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleRole]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleUser]
GO


INSERT INTO dbo.Applications (ApplicationName, ApplicationId, Description)
	SELECT ApplicationName, ApplicationId, Description FROM dbo.aspnet_Applications
GO
 
INSERT INTO dbo.Roles (ApplicationId, RoleId, RoleName, Description)
	SELECT ApplicationId, RoleId, RoleName, Description FROM dbo.aspnet_Roles
GO
 
INSERT INTO dbo.Users (ApplicationId, UserId, UserName, IsAnonymous, LastActivityDate)
	SELECT ApplicationId, UserId, cast(UserName as nvarchar(50)), IsAnonymous, LastActivityDate FROM dbo.aspnet_Users
GO
 
INSERT INTO dbo.Memberships (ApplicationId, UserId, Password, 
	PasswordFormat, PasswordSalt, Email, PasswordQuestion, PasswordAnswer, 
	IsApproved, IsLockedOut, CreateDate, LastLoginDate, LastPasswordChangedDate, 
	LastLockoutDate, FailedPasswordAttemptCount, 
	FailedPasswordAttemptWindowStart, FailedPasswordAnswerAttemptCount, 
	FailedPasswordAnswerAttemptWindowsStart, Comment) 
	SELECT ApplicationId, UserId, Password, 
	1, PasswordSalt, Email, NULL, NULL, 
	IsApproved, IsLockedOut, CreateDate, LastLoginDate, LastPasswordChangedDate, 
	LastLockoutDate, FailedPasswordAttemptCount, 
	FailedPasswordAttemptWindowStart, FailedPasswordAnswerAttemptCount, 
	FailedPasswordAnswerAttemptWindowStart, Comment FROM dbo.aspnet_Membership
GO
 
INSERT INTO dbo.UsersInRoles SELECT * FROM dbo.aspnet_UsersInRoles
GO


PRINT N'Altering [dbo].[BugNet_UserProfiles]...';


GO
ALTER TABLE [dbo].[BugNet_UserProfiles]
    ADD [PasswordVerificationToken]               NVARCHAR (128) NULL,
        [PasswordVerificationTokenExpirationDate] DATETIME       NULL;


GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_User_GetUserNameByPasswordResetToken]
	@Token NVARCHAR(255),
	@UserName NVARCHAR(255) OUTPUT
AS

SET NOCOUNT ON

SELECT @UserName = UserName 
FROM BugNet_UserProfiles
WHERE PasswordVerificationToken = @Token
GO

-- Begin Upgrade BugNET Tables to Universal Providers

PRINT N'Dropping FK_BugNet_Queries_aspnet_Users...';
GO
ALTER TABLE [dbo].[BugNet_Queries] DROP CONSTRAINT [FK_BugNet_Queries_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_UserProjects_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_UserProjects] DROP CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_DefaultValues_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValues] DROP CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_DefaultValues_aspnet_Users1...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValues] DROP CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users1];


GO
PRINT N'Dropping FK_BugNet_UserRoles_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_UserRoles] DROP CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_ProjectMailBoxes_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_Issues_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_Issues_aspnet_Users1...';


GO
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users1];


GO
PRINT N'Dropping FK_BugNet_Issues_aspnet_Users2...';


GO
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users2];


GO
PRINT N'Dropping FK_BugNet_Issues_aspnet_Users3...';


GO
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users3];


GO
PRINT N'Dropping FK_BugNet_IssueNotifications_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueNotifications] DROP CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_IssueWorkReports_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueWorkReports] DROP CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_IssueAttachments_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueAttachments] DROP CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_IssueHistory_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueHistory] DROP CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_IssueComments_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueComments] DROP CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_IssueVotes_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueVotes] DROP CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_Projects_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [FK_BugNet_Projects_aspnet_Users];


GO
PRINT N'Dropping FK_BugNet_Projects_aspnet_Users1...';


GO
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [FK_BugNet_Projects_aspnet_Users1];


GO
PRINT N'Dropping FK_BugNet_ProjectNotifications_aspnet_Users...';


GO
ALTER TABLE [dbo].[BugNet_ProjectNotifications] DROP CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users];


GO
PRINT N'Creating PK_BugNet_RelatedIssues...';


GO
ALTER TABLE [dbo].[BugNet_RelatedIssues]
    ADD CONSTRAINT [PK_BugNet_RelatedIssues] PRIMARY KEY CLUSTERED ([PrimaryIssueId] ASC, [SecondaryIssueId] ASC);


GO
PRINT N'Creating FK_BugNet_DefaultValues_Users...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_DefaultValues_Users] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_DefaultValues_Users1...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_DefaultValues_Users1] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_IssueAttachments_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueAttachments] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueAttachments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_IssueComments_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueComments] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueComments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_IssueHistory_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueHistory] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueHistory_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_IssueNotifications_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueNotifications] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_Issues_Users...';


GO
ALTER TABLE [dbo].[BugNet_Issues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Issues_Users] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_Issues_Users1...';


GO
ALTER TABLE [dbo].[BugNet_Issues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Issues_Users1] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_Issues_Users2...';


GO
ALTER TABLE [dbo].[BugNet_Issues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Issues_Users2] FOREIGN KEY ([LastUpdateUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_Issues_Users3...';


GO
ALTER TABLE [dbo].[BugNet_Issues] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Issues_Users3] FOREIGN KEY ([IssueCreatorUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_IssueVotes_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueVotes] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueVotes_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_IssueWorkReports_Users...';


GO
ALTER TABLE [dbo].[BugNet_IssueWorkReports] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_IssueWorkReports_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_ProjectMailBoxes_Users...';


GO
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_ProjectMailBoxes_Users] FOREIGN KEY ([AssignToUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_ProjectNotifications_Users...';


GO
ALTER TABLE [dbo].[BugNet_ProjectNotifications] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_ProjectNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_Projects_Users...';


GO
ALTER TABLE [dbo].[BugNet_Projects] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Projects_Users] FOREIGN KEY ([ProjectCreatorUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_Projects_Users1...';


GO
ALTER TABLE [dbo].[BugNet_Projects] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Projects_Users1] FOREIGN KEY ([ProjectManagerUserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_Queries_Users...';


GO
ALTER TABLE [dbo].[BugNet_Queries] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_Queries_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Creating FK_BugNet_UserProjects_Users...';


GO
ALTER TABLE [dbo].[BugNet_UserProjects] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_UserProjects_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_BugNet_UserRoles_Users...';


GO
ALTER TABLE [dbo].[BugNet_UserRoles] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_UserRoles_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Altering [dbo].[BugNet_DefaultValView]...';


GO

ALTER VIEW [dbo].[BugNet_DefaultValView]
AS
SELECT     dbo.BugNet_DefaultValues.DefaultType, dbo.BugNet_DefaultValues.StatusId, dbo.BugNet_DefaultValues.IssueOwnerUserId, 
                      dbo.BugNet_DefaultValues.IssuePriorityId, dbo.BugNet_DefaultValues.IssueAffectedMilestoneId, dbo.BugNet_DefaultValues.ProjectId, 
                      ISNULL(OwnerUsers.UserName, N'none') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
                      ISNULL(AssignedUsers.UserName, N'none') AS AssignedUserName, ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
                      dbo.BugNet_DefaultValues.IssueAssignedUserId, dbo.BugNet_DefaultValues.IssueCategoryId, dbo.BugNet_DefaultValues.IssueVisibility, 
                      dbo.BugNet_DefaultValues.IssueDueDate, dbo.BugNet_DefaultValues.IssueProgress, dbo.BugNet_DefaultValues.IssueMilestoneId, 
                      dbo.BugNet_DefaultValues.IssueEstimation, dbo.BugNet_DefaultValues.IssueResolutionId, dbo.BugNet_DefaultValuesVisibility.StatusVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.PriorityVisibility, dbo.BugNet_DefaultValuesVisibility.OwnedByVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.AssignedToVisibility, dbo.BugNet_DefaultValuesVisibility.PrivateVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.CategoryVisibility, dbo.BugNet_DefaultValuesVisibility.DueDateVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.TypeVisibility, dbo.BugNet_DefaultValuesVisibility.PercentCompleteVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.MilestoneVisibility, dbo.BugNet_DefaultValuesVisibility.ResolutionVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.EstimationVisibility, dbo.BugNet_DefaultValuesVisibility.AffectedMilestoneVisibility, 
                      dbo.BugNet_DefaultValues.OwnedByNotify, dbo.BugNet_DefaultValues.AssignedToNotify
FROM         dbo.BugNet_DefaultValues LEFT OUTER JOIN
                      dbo.Users AS OwnerUsers ON dbo.BugNet_DefaultValues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.Users AS AssignedUsers ON dbo.BugNet_DefaultValues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_DefaultValuesVisibility ON dbo.BugNet_DefaultValues.ProjectId = dbo.BugNet_DefaultValuesVisibility.ProjectId
GO
PRINT N'Altering [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]...';


GO
ALTER VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
AS
SELECT     
	dbo.BugNet_Issues.IssueId, 
	dbo.BugNet_Issues.Disabled, 
	dbo.BugNet_Issues.IssueTitle, 
	dbo.BugNet_Issues.IssueDescription, 
	dbo.BugNet_Issues.IssueStatusId,
	dbo.BugNet_Issues.IssuePriorityId, 
	dbo.BugNet_Issues.IssueTypeId, 
	dbo.BugNet_Issues.IssueCategoryId, 
	dbo.BugNet_Issues.ProjectId, 
	dbo.BugNet_Issues.IssueResolutionId, 
	dbo.BugNet_Issues.IssueCreatorUserId, 
	dbo.BugNet_Issues.IssueAssignedUserId, 
	dbo.BugNet_Issues.IssueAffectedMilestoneId, 
	dbo.BugNet_Issues.IssueOwnerUserId, 
	dbo.BugNet_Issues.IssueDueDate, 
	dbo.BugNet_Issues.IssueMilestoneId, 
	dbo.BugNet_Issues.IssueVisibility, 
	dbo.BugNet_Issues.IssueEstimation, 
	dbo.BugNet_Issues.DateCreated, 
	dbo.BugNet_Issues.LastUpdate, 
	dbo.BugNet_Issues.LastUpdateUserId, 
	dbo.BugNet_Projects.ProjectName, 
	dbo.BugNet_Projects.ProjectCode, 
	ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'none') AS PriorityName, 
	ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName,N'none') AS IssueTypeName, 
	ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'none') AS CategoryName, 
	ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'none') AS StatusName ,
	ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'none') AS MilestoneName, 
	ISNULL(AffectedMilestone.MilestoneName, N'none') AS AffectedMilestoneName, 
	ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'none') AS ResolutionName, 
	LastUpdateUsers.UserName AS LastUpdateUserName, 
	ISNULL(AssignedUsers.UserName, N'none') AS AssignedUserName, 
	ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
	CreatorUsers.UserName AS CreatorUserName, 
	ISNULL(CreatorUsersProfile.DisplayName, N'none') AS CreatorDisplayName, 
	ISNULL(OwnerUsers.UserName, 'none') AS OwnerUserName, 
	ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
	ISNULL(LastUpdateUsersProfile.DisplayName, 'none') AS LastUpdateDisplayName, 
	ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
	ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, 
	ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
	ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, 
	ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, 
	ISNULL(AffectedMilestone.MilestoneImageUrl, '') 
	AS AffectedMilestoneImageUrl, ISNULL
		((SELECT     SUM(Duration) AS Expr1
			FROM         dbo.BugNet_IssueWorkReports AS WR
			WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
		((SELECT     COUNT(IssueId) AS Expr1
			FROM         dbo.BugNet_IssueVotes AS V
			WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes,
	dbo.BugNet_ProjectCustomFields.CustomFieldName, 
	dbo.BugNet_ProjectCustomFieldValues.CustomFieldValue, 
	dbo.BugNet_Issues.IssueProgress, 
	dbo.BugNet_ProjectMilestones.MilestoneDueDate, 
	dbo.BugNet_Projects.ProjectDisabled, 
	CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) AS IsClosed
FROM         
	dbo.BugNet_ProjectCustomFields 
INNER JOIN
	dbo.BugNet_ProjectCustomFieldValues ON dbo.BugNet_ProjectCustomFields.CustomFieldId = dbo.BugNet_ProjectCustomFieldValues.CustomFieldId 
RIGHT OUTER JOIN
	dbo.BugNet_Issues ON dbo.BugNet_ProjectCustomFieldValues.IssueId = dbo.BugNet_Issues.IssueId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId 
LEFT OUTER JOIN
    dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId 
LEFT OUTER JOIN
    dbo.Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId 
LEFT OUTER JOIN
    dbo.Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName 
LEFT OUTER JOIN
    dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
GO
PRINT N'Altering [dbo].[BugNet_IssuesView]...';


GO


ALTER VIEW [dbo].[BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, dbo.BugNet_Issues.IssueOwnerUserId, 
                      dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                      dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, 
                      dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') 
                      AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, 
                      N'Unassigned') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N'Unassigned') AS AssignedUserName, ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 
                      'Unassigned') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, 
                      'Unassigned') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') 
                      AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate, dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) 
                      AS IsClosed, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.LastUpdate, 112) AS DATETIME) AS LastUpdateAsDate, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.DateCreated, 112) AS DATETIME) AS DateCreatedAsDate
FROM         dbo.BugNet_Issues LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                      dbo.Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                      dbo.Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
GO
PRINT N'Altering [dbo].[BugNet_ProjectsView]...';


GO
ALTER VIEW [dbo].[BugNet_ProjectsView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_Projects.ProjectId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, dbo.BugNet_Projects.ProjectDescription, 
                      dbo.BugNet_Projects.AttachmentUploadPath, dbo.BugNet_Projects.ProjectManagerUserId, dbo.BugNet_Projects.ProjectCreatorUserId, 
                      dbo.BugNet_Projects.DateCreated, dbo.BugNet_Projects.ProjectDisabled, dbo.BugNet_Projects.ProjectAccessType, Managers.UserName AS ManagerUserName, 
                      ISNULL(ManagerUsersProfile.DisplayName, N'none') AS ManagerDisplayName, Creators.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, 
                      N'none') AS CreatorDisplayName, dbo.BugNet_Projects.AllowAttachments, dbo.BugNet_Projects.AttachmentStorageType, dbo.BugNet_Projects.SvnRepositoryUrl, 
                      dbo.BugNet_Projects.AllowIssueVoting
FROM         dbo.BugNet_Projects INNER JOIN
                      dbo.Users AS Managers ON Managers.UserId = dbo.BugNet_Projects.ProjectManagerUserId INNER JOIN
                      dbo.Users AS Creators ON Creators.UserId = dbo.BugNet_Projects.ProjectCreatorUserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON Creators.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS ManagerUsersProfile ON Managers.UserName = ManagerUsersProfile.UserName
ORDER BY dbo.BugNet_Projects.ProjectName
GO
PRINT N'Altering [dbo].[BugNet_UserView]...';


GO
ALTER VIEW [dbo].[BugNet_UserView]
AS
SELECT     dbo.Users.UserId, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.Users.UserName, dbo.Memberships.Email, 
                      dbo.Memberships.IsApproved, dbo.Memberships.IsLockedOut, dbo.Users.IsAnonymous,
                      dbo.Users.LastActivityDate, dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
FROM         dbo.Users INNER JOIN
                      dbo.Memberships ON dbo.Users.UserId = dbo.Memberships.UserId INNER JOIN
                      dbo.BugNet_UserProfiles ON dbo.Users.UserName = dbo.BugNet_UserProfiles.UserName
GROUP BY dbo.Users.UserId, dbo.Users.UserName, dbo.Memberships.Email, dbo.Memberships.IsApproved, dbo.Memberships.IsLockedOut, dbo.Users.IsAnonymous, 
                      dbo.Users.LastActivityDate, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
GO
PRINT N'Refreshing [dbo].[BugNet_Issue_IssueTypeCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_IssueTypeCountView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAssignedToCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAssignedToCountView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueCommentsView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueCommentsView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueMilestoneCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueMilestoneCountView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssuePriorityCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssuePriorityCountView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueStatusCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueStatusCountView]';


GO
PRINT N'Altering [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]
 @IssueAttachmentId INT
AS
SELECT
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueAttachmentId = @IssueAttachmentId
GO
PRINT N'Altering [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
GO
PRINT N'Altering [dbo].[BugNet_IssueComment_GetIssueCommentById]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
 @IssueCommentId INT
AS
SELECT
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueCommentId = @IssueCommentId
GO
PRINT N'Altering [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
GO
PRINT N'Altering [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
	@IssueId int
AS
 SELECT
	IssueHistoryId,
	IssueId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FieldChanged,
	OldValue,
	NewValue,
	DateCreated
FROM 
	BugNet_IssueHistory
	INNER JOIN Users U ON BugNet_IssueHistory.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE 
	IssueId = @IssueId
ORDER BY
	DateCreated DESC
GO
PRINT N'Altering [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]...';


GO

ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS


SET NOCOUNT ON
DECLARE @DefaultCulture NVARCHAR(50)
SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

DECLARE @tmpTable TABLE (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUserName nvarchar(50), NotificationDisplayName nvarchar(50), NotificationEmail nvarchar(50), NotificationCulture NVARCHAR(50))
INSERT @tmpTable

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN Memberships M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles UP ON U.UserName = UP.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.UserId NotificationUserId,
	u.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	m.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	Users u,
	Memberships m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT DISTINCT IssueId,NotificationUserId, NotificationUserName, NotificationDisplayName, NotificationEmail, NotificationCulture FROM @tmpTable ORDER BY NotificationDisplayName
GO
PRINT N'Altering [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]
	@IssueId INT
AS
SELECT      
	IssueWorkReportId,
	BugNet_IssueWorkReports.IssueId,
	WorkDate,
	Duration,
	BugNet_IssueWorkReports.IssueCommentId,
	BugNet_IssueWorkReports.UserId CreatorUserId, 
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
    ISNULL(BugNet_IssueComments.Comment, '') Comment
FROM         
	BugNet_IssueWorkReports
	INNER JOIN Users U ON BugNet_IssueWorkReports.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
	LEFT OUTER JOIN BugNet_IssueComments ON BugNet_IssueComments.IssueCommentId =  BugNet_IssueWorkReports.IssueCommentId
WHERE
	 BugNet_IssueWorkReports.IssueId = @IssueId
ORDER BY WorkDate DESC
GO
PRINT N'Altering [dbo].[BugNet_Project_GetMemberRolesByProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
	@ProjectId Int
AS

SELECT ISNULL(UsersProfile.DisplayName, Users.UserName) as DisplayName, BugNet_Roles.RoleName
FROM
	Users INNER JOIN
	BugNet_UserProjects ON Users.UserId = BugNet_UserProjects.UserId INNER JOIN
	BugNet_UserRoles ON Users.UserId = BugNet_UserRoles.UserId INNER JOIN
	BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId LEFT OUTER JOIN
	BugNet_UserProfiles AS UsersProfile ON Users.UserName = UsersProfile.UserName

WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY DisplayName, RoleName ASC
GO
PRINT N'Altering [dbo].[BugNet_ProjectMailbox_GetMailboxById]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxById]
    @ProjectMailboxId int
AS

SET NOCOUNT ON
    
SELECT 
	BugNet_ProjectMailboxes.*,
	u.UserName AssignToUserName,
	p.DisplayName AssignToDisplayName,
	BugNet_ProjectIssueTypes.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes ON BugNet_ProjectIssueTypes.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.ProjectMailboxId = @ProjectMailboxId
GO
PRINT N'Altering [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]...';


GO
ALTER  PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId int
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.UserName AssignToUserName,
	p.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId		
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId
GO
PRINT N'Altering [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
    @mailbox nvarchar(100) 
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.UserName AssignToUserName,
	p.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.MailBox = @mailbox
GO
PRINT N'Altering [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId] 
	@ProjectId Int
AS

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN Memberships M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	P.ProjectId = @ProjectId
ORDER BY
	DisplayName
GO
PRINT N'Altering [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUserName] 
	@UserName nvarchar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUserName,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN Memberships M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	U.UserId = @UserId
ORDER BY
	DisplayName
GO
PRINT N'Altering [dbo].[BugNet_Query_GetQueriesByUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
	@UserName NVarChar(255),
	@ProjectId Int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

SELECT
	QueryId,
	QueryName + ' (' + BugNet_UserProfiles.DisplayName + ')' AS QueryName,
	IsPublic
FROM
	BugNet_Queries INNER JOIN
	Users M ON BugNet_Queries.UserId = M.UserId JOIN
	BugNet_UserProfiles ON M.UserName = BugNet_UserProfiles.UserName
WHERE
	IsPublic = 1 AND ProjectId = @ProjectId
UNION
SELECT
	QueryId,
	QueryName,
	IsPublic
FROM
	BugNet_Queries
WHERE
	UserId = @UserId
	AND ProjectId = @ProjectId
	AND IsPublic = 0
ORDER BY
	QueryName
GO
PRINT N'Altering [dbo].[BugNet_User_GetUsersByProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int,
	@ExcludeReadonlyUsers bit
AS
SELECT DISTINCT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  Memberships M 
	ON U.UserId = M.UserId
JOIN BugNet_UserRoles UR
	ON U.UserId = UR.UserId
JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1 AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only')
ORDER BY DisplayName ASC
GO
PRINT N'Altering [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueAssignedUserId = @UserId
ORDER BY
	IssueId Desc
GO
PRINT N'Altering [dbo].[BugNet_Issue_GetIssuesByCreatorUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuesByCreatorUserName] 
  @ProjectId Int,
  @UserName NVarChar(255)
AS
DECLARE @CreatorId UniqueIdentifier
SELECT @CreatorId = UserId FROM Users WHERE UserName = @UserName
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueCreatorUserId = @CreatorId
ORDER BY
	IssueId Desc
GO
PRINT N'Altering [dbo].[BugNet_Issue_GetIssuesByOwnerUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuesByOwnerUserName] 
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueOwnerUserId = @UserId
ORDER BY
	IssueId Desc
GO
PRINT N'Altering [dbo].[BugNet_Issue_GetIssuesByRelevancy]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuesByRelevancy] 
	@ProjectId int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
	
SELECT 
	*
FROM
	BugNet_IssuesView 
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND (IssueCreatorUserId = @UserId OR IssueAssignedUserId = @UserId OR IssueOwnerUserId = @UserId)
ORDER BY
	IssueId Desc
GO
PRINT N'Altering [dbo].[BugNet_Project_GetProjectsByMemberUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUserName]
	@UserName nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @Disabled bit
SET @Disabled = 1
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
IF @ActiveOnly = 1
BEGIN
	SET @Disabled = 0
END
SELECT DISTINCT 
	[BugNet_ProjectsView].ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	[BugNet_ProjectsView].DateCreated,
	ProjectDisabled,
	ProjectAccessType,
	ManagerUserName,
	ManagerDisplayName,
	CreatorUserName,
	CreatorDisplayName,
	AllowAttachments,
	AllowAttachments,
	AttachmentStorageType,
	SvnRepositoryUrl,
	AllowIssueVoting
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
     (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND (UP.UserId = @UserId  or ProjectManagerUserId=@UserId ))
 
ORDER BY ProjectName ASC
GO
PRINT N'Altering [dbo].[BugNet_DefaultValues_Set]...';


GO
ALTER PROCEDURE [dbo].[BugNet_DefaultValues_Set]
	@Type nvarchar(50),
	@ProjectId Int,
	@StatusId Int,
	@IssueOwnerUserName NVarChar(255),
	@IssuePriorityId Int,
	@IssueAssignedUserName NVarChar(255),
	@IssueVisibility int,
	@IssueCategoryId Int,
	@IssueAffectedMilestoneId Int,
	@IssueDueDate int,
	@IssueProgress Int,
	@IssueMilestoneId Int,
	@IssueEstimation decimal(5,2),
	@IssueResolutionId Int,
	@StatusVisibility		 Bit,
	@OwnedByVisibility		 Bit,
	@PriorityVisibility		 Bit,
	@AssignedToVisibility	 Bit,
	@PrivateVisibility		 Bit,
	@CategoryVisibility		 Bit,
	@DueDateVisibility		 Bit,
	@TypeVisibility			 Bit,
	@PercentCompleteVisibility Bit,
	@MilestoneVisibility	Bit, 
	@EstimationVisibility	 Bit,
	@ResolutionVisibility	 Bit,
	@AffectedMilestoneVisibility Bit,
	@OwnedByNotify Bit,
	@AssignedToNotify Bit
AS
DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName
SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
BEGIN
	BEGIN TRAN
		DECLARE @defVisExists int
		SELECT @defVisExists = COUNT(*) 
		FROM BugNet_DefaultValuesVisibility
			WHERE BugNet_DefaultValuesVisibility.ProjectId = @ProjectId
				IF(@defVisExists>0)
					BEGIN
						UPDATE BugNet_DefaultValuesVisibility
						SET 								
							StatusVisibility = @StatusVisibility,			
							OwnedByVisibility = @OwnedByVisibility,				
							PriorityVisibility = @PriorityVisibility,			
							AssignedToVisibility = @AssignedToVisibility,			
							PrivateVisibility= @PrivateVisibility,			
							CategoryVisibility= @CategoryVisibility,			
							DueDateVisibility= @DueDateVisibility,				
							TypeVisibility	= @TypeVisibility,				
							PercentCompleteVisibility = @PercentCompleteVisibility,		
							MilestoneVisibility	= @MilestoneVisibility,			
							EstimationVisibility = @EstimationVisibility,			
							ResolutionVisibility = @ResolutionVisibility,
							AffectedMilestoneVisibility = @AffectedMilestoneVisibility		
					WHERE ProjectId = @ProjectId							
					END
				ELSE
					BEGIN
					INSERT INTO BugNet_DefaultValuesVisibility
					VALUES 
					(
						@ProjectId				 ,  
						@StatusVisibility		 ,
						@OwnedByVisibility		 ,
						@PriorityVisibility		 ,
						@AssignedToVisibility	 ,
						@PrivateVisibility		 ,
						@CategoryVisibility		 ,
						@DueDateVisibility		 ,
						@TypeVisibility			 ,
						@PercentCompleteVisibility,
						@MilestoneVisibility	,	 
						@EstimationVisibility	 ,
						@ResolutionVisibility	,
						@AffectedMilestoneVisibility	  					
					)
					END


		DECLARE @defExists int
		SELECT @defExists = COUNT(*) 
			FROM BugNet_DefaultValues
			WHERE BugNet_DefaultValues.ProjectId = @ProjectId
		
		IF (@defExists > 0)
		BEGIN
			UPDATE BugNet_DefaultValues 
				SET DefaultType = @Type,
					StatusId = @StatusId,
					IssueOwnerUserId = @IssueOwnerUserId,
					IssuePriorityId = @IssuePriorityId,
					IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
					IssueAssignedUserId = @IssueAssignedUserId,
					IssueVisibility = @IssueVisibility,
					IssueCategoryId = @IssueCategoryId,
					IssueDueDate = @IssueDueDate,
					IssueProgress = @IssueProgress,
					IssueMilestoneId = @IssueMilestoneId,
					IssueEstimation = @IssueEstimation,
					IssueResolutionId = @IssueResolutionId,
					OwnedByNotify = @OwnedByNotify,
					AssignedToNotify = @AssignedToNotify
				WHERE ProjectId = @ProjectId
		END
		ELSE
		BEGIN
			INSERT INTO BugNet_DefaultValues 
				VALUES (
					@ProjectId,
					@Type,
					@StatusId,
					@IssueOwnerUserId,
					@IssuePriorityId,
					@IssueAffectedMilestoneId,
					@IssueAssignedUserId,
					@IssueVisibility,
					@IssueCategoryId,
					@IssueDueDate,
					@IssueProgress,
					@IssueMilestoneId,
					@IssueEstimation,
					@IssueResolutionId,
					@OwnedByNotify,
					@AssignedToNotify 
				)
		END
	COMMIT TRAN
END
GO
PRINT N'Altering [dbo].[BugNet_GetProjectSelectedColumnsWithUserIdAndProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_GetProjectSelectedColumnsWithUserIdAndProjectId]
	@UserName	nvarchar(255),
 	@ProjectId	int,
 	@ReturnValue nvarchar(255) OUT
AS
DECLARE 
	@UserId UNIQUEIDENTIFIER	
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	SET @ReturnValue = (SELECT [SelectedIssueColumns] FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId);
	
END
GO
PRINT N'Altering [dbo].[BugNet_Issue_CreateNewIssue]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM Users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName

	INSERT BugNet_Issues
	(
		IssueTitle,
		IssueDescription,
		IssueCreatorUserId,
		DateCreated,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		IssueAssignedUserId,
		ProjectId,
		IssueResolutionId,
		IssueMilestoneId,
		IssueAffectedMilestoneId,
		LastUpdateUserId,
		LastUpdate,
		IssueDueDate,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		IssueOwnerUserId
	)
	VALUES
	(
		@IssueTitle,
		@IssueDescription,
		@IssueCreatorUserId,
		GetDate(),
		@IssueStatusId,
		@IssuePriorityId,
		@IssueTypeId,
		@IssueCategoryId,
		@IssueAssignedUserId,
		@ProjectId,
		@IssueResolutionId,
		@IssueMilestoneId,
		@IssueAffectedMilestoneId,
		@IssueCreatorUserId,
		GetDate(),
		@IssueDueDate,
		@IssueVisibility,
		@IssueEstimation,
		@IssueProgress,
		@IssueOwnerUserId
	)
RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_Issue_UpdateIssue]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
  @IssueId Int,
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @LastUpdateUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER
DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM Users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName
SELECT @LastUpdateUserId = UserId FROM Users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		IssueTitle = @IssueTitle,
		IssueCategoryId = @IssueCategoryId,
		ProjectId = @ProjectId,
		IssueStatusId = @IssueStatusId,
		IssuePriorityId = @IssuePriorityId,
		IssueMilestoneId = @IssueMilestoneId,
		IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
		IssueAssignedUserId = @IssueAssignedUserId,
		IssueOwnerUserId = @IssueOwnerUserId,
		IssueTypeId = @IssueTypeId,
		IssueResolutionId = @IssueResolutionId,
		IssueDueDate = @IssueDueDate,
		IssueVisibility = @IssueVisibility,
		IssueEstimation = @IssueEstimation,
		IssueProgress = @IssueProgress,
		IssueDescription = @IssueDescription,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
	
	/*EXEC BugNet_IssueHistory_CreateNewHistory @IssueId, @IssueCreatorId*/
COMMIT TRAN
GO
PRINT N'Altering [dbo].[BugNet_Issue_UpdateLastUpdated]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Issue_UpdateLastUpdated]
  @IssueId Int,
  @LastUpdateUserName NVARCHAR(255)
AS

SET NOCOUNT ON

DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @LastUpdateUserId = UserId FROM Users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
COMMIT TRAN
GO
PRINT N'Altering [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
  @IssueId int,
  @FileName nvarchar(100),
  @FileSize Int,
  @ContentType nvarchar(50),
  @CreatorUserName nvarchar(255),
  @Description nvarchar(80),
  @Attachment Image
AS
-- Get Uploaded UserID
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatorUserName
INSERT BugNet_IssueAttachments
(
	IssueId,
	FileName,
	Description,
	FileSize,
	ContentType,
	DateCreated,
	UserId,
	Attachment
)
VALUES
(
	@IssueId,
	@FileName,
	@Description,
	@FileSize,
	@ContentType,
	GetDate(),
	@UserId,
	@Attachment
	
)
RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_IssueComment_CreateNewIssueComment]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueComment_CreateNewIssueComment]
	@IssueId int,
	@CreatorUserName NVarChar(255),
	@Comment ntext
AS
-- Get Last Update UserID
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatorUserName
INSERT BugNet_IssueComments
(
	IssueId,
	UserId,
	DateCreated,
	Comment
) 
VALUES 
(
	@IssueId,
	@UserId,
	GetDate(),
	@Comment
)

/* Update the LastUpdate fields of this bug*/
UPDATE BugNet_Issues SET LastUpdate = GetDate(),LastUpdateUserId = @UserId WHERE IssueId = @IssueId

RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_IssueComment_UpdateIssueComment]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
	@IssueCommentId int,
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@Comment ntext
AS

DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatorUserName

UPDATE BugNet_IssueComments SET
	IssueId = @IssueId,
	UserId = @UserId,
	Comment = @Comment
WHERE IssueCommentId= @IssueCommentId
GO
PRINT N'Altering [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
  @IssueId int,
  @CreatedUserName nvarchar(255),
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatedUserName

	INSERT BugNet_IssueHistory
	(
		IssueId,
		UserId,
		FieldChanged,
		OldValue,
		NewValue,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
	@IssueId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @NotificationUserName

IF (NOT EXISTS(SELECT IssueNotificationId FROM BugNet_IssueNotifications WHERE UserId = @UserId AND IssueId = @IssueId) AND @UserId IS NOT NULL)
BEGIN
	INSERT BugNet_IssueNotifications
	(
		IssueId,
		UserId
	)
	VALUES
	(
		@IssueId,
		@UserId
	)
	RETURN scope_identity()
END
GO
PRINT N'Altering [dbo].[BugNet_IssueNotification_DeleteIssueNotification]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
	@IssueId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
DELETE 
	BugNet_IssueNotifications
WHERE
	IssueId = @IssueId
	AND UserId = @UserId
GO
PRINT N'Altering [dbo].[BugNet_IssueVote_CreateNewIssueVote]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @VoteUserName

IF NOT EXISTS( SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
BEGIN
	INSERT BugNet_IssueVotes
	(
		IssueId,
		UserId,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		GETDATE()
	)
	RETURN scope_identity()
END
GO
PRINT N'Altering [dbo].[BugNet_IssueVote_HasUserVoted]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @VoteUserName

BEGIN
    IF EXISTS(SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
PRINT N'Altering [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@IssueCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM Users WHERE UserName = @CreatorUserName
INSERT BugNet_IssueWorkReports
(
	IssueId,
	UserId,
	WorkDate,
	Duration,
	IssueCommentId
) 
VALUES 
(
	@IssueId,
	@CreatorUserId,
	@WorkDate,
	@Duration,
	@IssueCommentId
)
RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_Project_AddUserToProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
@UserName nvarchar(255),
@ProjectId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT  BugNet_UserProjects
	(
		UserId,
		ProjectId,
		DateCreated
	)
	VALUES
	(
		@UserId,
		@ProjectId,
		getdate()
	)
END
GO
PRINT N'Altering [dbo].[BugNet_Role_AddUserToRole]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Role_AddUserToRole]
	@UserName nvarchar(256),
	@RoleId int
AS

DECLARE @ProjectId int
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName
SELECT	@ProjectId = ProjectId FROM BugNet_Roles WHERE RoleId = @RoleId

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId) AND @RoleId <> 1
BEGIN
 EXEC BugNet_Project_AddUserToProject @UserName, @ProjectId
END

IF NOT EXISTS (SELECT UserId FROM BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_UserRoles
	(
		UserId,
		RoleId
	)
	VALUES
	(
		@UserId,
		@RoleId
	)
END
GO
PRINT N'Altering [dbo].[BugNet_Project_CreateNewProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @ProjectName nvarchar(50),
 @ProjectCode nvarchar(50),
 @ProjectDescription 	nvarchar(1000),
 @ProjectManagerUserName nvarchar(255),
 @AttachmentUploadPath nvarchar(80),
 @ProjectAccessType int,
 @ProjectCreatorUserName nvarchar(255),
 @AllowAttachments int,
 @AttachmentStorageType	int,
 @SvnRepositoryUrl	nvarchar(255),
 @AllowIssueVoting bit,
 @ProjectImageFileContent varbinary(max),
 @ProjectImageFileName nvarchar(150),
 @ProjectImageContentType nvarchar(50),
 @ProjectImageFileSize bigint
AS
IF NOT EXISTS( SELECT ProjectId,ProjectCode  FROM BugNet_Projects WHERE LOWER(ProjectName) = LOWER(@ProjectName) OR LOWER(ProjectCode) = LOWER(@ProjectCode) )
BEGIN
	DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
	DECLARE @ProjectCreatorUserId UNIQUEIDENTIFIER
	SELECT @ProjectManagerUserId = UserId FROM Users WHERE UserName = @ProjectManagerUserName
	SELECT @ProjectCreatorUserId = UserId FROM Users WHERE UserName = @ProjectCreatorUserName
	
	INSERT BugNet_Projects 
	(
		ProjectName,
		ProjectCode,
		ProjectDescription,
		AttachmentUploadPath,
		ProjectManagerUserId,
		DateCreated,
		ProjectCreatorUserId,
		ProjectAccessType,
		AllowAttachments,
		AttachmentStorageType,
		SvnRepositoryUrl,
		AllowIssueVoting,
		ProjectImageFileContent,
		ProjectImageFileName,
		ProjectImageContentType,
		ProjectImageFileSize
	) 
	VALUES
	(
		@ProjectName,
		@ProjectCode,
		@ProjectDescription,
		@AttachmentUploadPath,
		@ProjectManagerUserId ,
		GetDate(),
		@ProjectCreatorUserId,
		@ProjectAccessType,
		@AllowAttachments,
		@AttachmentStorageType,
		@SvnRepositoryUrl,
		@AllowIssueVoting,
		@ProjectImageFileContent,
		@ProjectImageFileName,
		@ProjectImageContentType,
		@ProjectImageFileSize
	)
 	RETURN scope_identity()
END
ELSE
  RETURN 0
GO
PRINT N'Altering [dbo].[BugNet_Project_GetProjectMembers]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId Int
AS
SELECT UserName
FROM 
	Users
LEFT OUTER JOIN
	BugNet_UserProjects
ON
	Users.UserId = BugNet_UserProjects.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY UserName ASC
GO
PRINT N'Altering [dbo].[BugNet_Project_IsUserProjectMember]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@UserName	nvarchar(255),
 	@ProjectId	int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

IF EXISTS( SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1
GO
PRINT N'Altering [dbo].[BugNet_Project_RemoveUserFromProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

DELETE 
	BugNet_UserProjects
WHERE
	UserId = @UserId AND ProjectId = @ProjectId
GO
PRINT N'Altering [dbo].[BugNet_Project_UpdateProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_UpdateProject]
 @ProjectId 				int,
 @ProjectName				nvarchar(50),
 @ProjectCode				nvarchar(50),
 @ProjectDescription 		nvarchar(1000),
 @ProjectManagerUserName	nvarchar(255),
 @AttachmentUploadPath 		nvarchar(80),
 @ProjectAccessType			int,
 @ProjectDisabled			int,
 @AllowAttachments			bit,
 @AttachmentStorageType		int,
 @SvnRepositoryUrl	nvarchar(255),
 @AllowIssueVoting bit,
 @ProjectImageFileContent varbinary(max),
 @ProjectImageFileName nvarchar(150),
 @ProjectImageContentType nvarchar(50),
 @ProjectImageFileSize bigint
AS
DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
SELECT @ProjectManagerUserId = UserId FROM Users WHERE UserName = @ProjectManagerUserName

IF @ProjectImageFileContent IS NULL
	UPDATE BugNet_Projects SET
		ProjectName = @ProjectName,
		ProjectCode = @ProjectCode,
		ProjectDescription = @ProjectDescription,
		ProjectManagerUserId = @ProjectManagerUserId,
		AttachmentUploadPath = @AttachmentUploadPath,
		ProjectAccessType = @ProjectAccessType,
		ProjectDisabled = @ProjectDisabled,
		AllowAttachments = @AllowAttachments,
		AttachmentStorageType = @AttachmentStorageType,
		SvnRepositoryUrl = @SvnRepositoryUrl,
		AllowIssueVoting = @AllowIssueVoting
	WHERE
		ProjectId = @ProjectId
ELSE
	UPDATE BugNet_Projects SET
		ProjectName = @ProjectName,
		ProjectCode = @ProjectCode,
		ProjectDescription = @ProjectDescription,
		ProjectManagerUserId = @ProjectManagerUserId,
		AttachmentUploadPath = @AttachmentUploadPath,
		ProjectAccessType = @ProjectAccessType,
		ProjectDisabled = @ProjectDisabled,
		AllowAttachments = @AllowAttachments,
		AttachmentStorageType = @AttachmentStorageType,
		SvnRepositoryUrl = @SvnRepositoryUrl,
		ProjectImageFileContent = @ProjectImageFileContent,
		ProjectImageFileName = @ProjectImageFileName,
		ProjectImageContentType = @ProjectImageContentType,
		ProjectImageFileSize = @ProjectImageFileSize,
		AllowIssueVoting = @AllowIssueVoting
	WHERE
		ProjectId = @ProjectId
GO
PRINT N'Altering [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]
	@MailBox nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeId int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM Users WHERE UserName = @AssignToUserName
	
INSERT BugNet_ProjectMailBoxes 
(
	MailBox,
	ProjectId,
	AssignToUserId,
	IssueTypeId
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
PRINT N'Altering [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]
	@ProjectMailboxId int,
	@MailBoxEmailAddress nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeId int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM Users WHERE UserName = @AssignToUserName

UPDATE BugNet_ProjectMailBoxes SET
	MailBox = @MailBoxEmailAddress,
	ProjectId = @ProjectId,
	AssignToUserId = @AssignToUserId,
	IssueTypeId = @IssueTypeId
WHERE ProjectMailboxId = @ProjectMailboxId
GO
PRINT N'Altering [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
	@ProjectId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @NotificationUserName

IF NOT EXISTS( SELECT ProjectNotificationId FROM BugNet_ProjectNotifications WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT BugNet_ProjectNotifications
	(
		ProjectId,
		UserId
	)
	VALUES
	(
		@ProjectId,
		@UserId
	)
	RETURN scope_identity()
END
GO
PRINT N'Altering [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
DELETE 
	BugNet_ProjectNotifications
WHERE
	ProjectId = @ProjectId
	AND UserId = @UserId
GO
PRINT N'Altering [dbo].[BugNet_Query_SaveQuery]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Query_SaveQuery] 
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

IF EXISTS(SELECT QueryName FROM BugNet_Queries WHERE QueryName = @QueryName AND UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	RETURN 0
END

INSERT BugNet_Queries
(
	UserId,
	ProjectId,
	QueryName,
	IsPublic
)
VALUES
(
	@UserId,
	@ProjectId,
	@QueryName,
	@IsPublic
)
RETURN scope_identity()
GO
PRINT N'Altering [dbo].[BugNet_Query_UpdateQuery]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Query_UpdateQuery] 
	@QueryId Int,
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName

UPDATE 
	BugNet_Queries 
SET
	UserId = @UserId,
	ProjectId = @ProjectId,
	QueryName = @QueryName,
	IsPublic = @IsPublic
WHERE 
	QueryId = @QueryId

DELETE FROM BugNet_QueryClauses WHERE QueryId = @QueryId
GO
PRINT N'Altering [dbo].[BugNet_Role_GetProjectRolesByUser]...';


GO
ALTER procedure [dbo].[BugNet_Role_GetProjectRolesByUser] 
	@UserName       nvarchar(256),
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

SELECT	R.RoleName,
		R.ProjectId,
		R.RoleDescription,
		R.RoleId,
		R.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN Users ON BugNet_UserRoles.UserId = Users.UserId
INNER JOIN BugNet_Roles R ON BugNet_UserRoles.RoleId = R.RoleId
WHERE  Users.UserId = @UserId
AND    (R.ProjectId IS NULL OR R.ProjectId = @ProjectId)
GO
PRINT N'Altering [dbo].[BugNet_Role_GetRolesByUser]...';


GO
ALTER procedure [dbo].[BugNet_Role_GetRolesByUser] 
	@UserName       nvarchar(256)
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

SELECT	BugNet_Roles.RoleName,
		BugNet_Roles.ProjectId,
		BugNet_Roles.RoleDescription,
		BugNet_Roles.RoleId,
		BugNet_Roles.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN Users ON BugNet_UserRoles.UserId = Users.UserId
INNER JOIN BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId
WHERE  Users.UserId = @UserId
GO
PRINT N'Altering [dbo].[BugNet_Role_IsUserInRole]...';


GO
ALTER procedure [dbo].[BugNet_Role_IsUserInRole] 
	@UserName		nvarchar(256),
	@RoleId			int,
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

SELECT	UR.UserId,
		UR.RoleId
FROM	BugNet_UserRoles UR
INNER JOIN BugNet_Roles R ON UR.RoleId = R.RoleId
WHERE	UR.UserId = @UserId
AND		UR.RoleId = @RoleId
AND		R.ProjectId = @ProjectId
GO
PRINT N'Altering [dbo].[BugNet_Role_RemoveUserFromRole]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
	@UserName	nvarchar(256),
	@RoleId		Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM Users WHERE UserName = @UserName

DELETE BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId
GO
PRINT N'Altering [dbo].[BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId]
	@UserName	nvarchar(255),
 	@ProjectId	int,
 	@Columns nvarchar(255)
AS
DECLARE 
	@UserId UNIQUEIDENTIFIER	
SELECT @UserId = UserId FROM Users WHERE UserName = @UserName
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE BugNet_UserProjects
	SET [SelectedIssueColumns] = @Columns 
	WHERE UserId = @UserId AND ProjectId = @ProjectId;
	
END
GO
PRINT N'Altering [dbo].[BugNet_User_GetUserIdByUserName]...';


GO
ALTER PROCEDURE [dbo].[BugNet_User_GetUserIdByUserName]
	@UserName NVARCHAR(75),
	@UserId UNIQUEIDENTIFIER OUTPUT
AS

SET NOCOUNT ON

SELECT @UserId = UserId
FROM Users
WHERE UserName = @UserName
GO
PRINT N'Refreshing [dbo].[BugNet_User_GetUserNameByPasswordResetToken]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_User_GetUserNameByPasswordResetToken]';


GO
PRINT N'Refreshing [dbo].[BugNet_DefaultValues_GetByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_DefaultValues_GetByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueById]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueCategoryCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetOpenIssues]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetOpenIssues]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetRoadMapProgress]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetRoadMapProgress]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetCategoryById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetCategoryById]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetAllProjects]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetAllProjects]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetProjectByCode]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetProjectByCode]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetProjectById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetProjectById]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetPublicProjects]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetPublicProjects]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueTypeCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueTypeCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueUserCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueUserCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuePriorityCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueStatusCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueStatusCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_CloneProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_CloneProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAttachment_ValidateDownload]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAttachment_ValidateDownload]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [dbo].[BugNet_DefaultValues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_DefaultValues_Users];

ALTER TABLE [dbo].[BugNet_DefaultValues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_DefaultValues_Users1];

ALTER TABLE [dbo].[BugNet_IssueAttachments] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueAttachments_Users];

ALTER TABLE [dbo].[BugNet_IssueComments] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueComments_Users];

ALTER TABLE [dbo].[BugNet_IssueHistory] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueHistory_Users];

ALTER TABLE [dbo].[BugNet_IssueNotifications] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueNotifications_Users];

ALTER TABLE [dbo].[BugNet_Issues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Issues_Users];

ALTER TABLE [dbo].[BugNet_Issues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Issues_Users1];

ALTER TABLE [dbo].[BugNet_Issues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Issues_Users2];

ALTER TABLE [dbo].[BugNet_Issues] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Issues_Users3];

ALTER TABLE [dbo].[BugNet_IssueVotes] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueVotes_Users];

ALTER TABLE [dbo].[BugNet_IssueWorkReports] WITH CHECK CHECK CONSTRAINT [FK_BugNet_IssueWorkReports_Users];

ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] WITH CHECK CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_Users];

ALTER TABLE [dbo].[BugNet_ProjectNotifications] WITH CHECK CHECK CONSTRAINT [FK_BugNet_ProjectNotifications_Users];

ALTER TABLE [dbo].[BugNet_Projects] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Projects_Users];

ALTER TABLE [dbo].[BugNet_Projects] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Projects_Users1];

ALTER TABLE [dbo].[BugNet_Queries] WITH CHECK CHECK CONSTRAINT [FK_BugNet_Queries_Users];

ALTER TABLE [dbo].[BugNet_UserProjects] WITH CHECK CHECK CONSTRAINT [FK_BugNet_UserProjects_Users];

ALTER TABLE [dbo].[BugNet_UserRoles] WITH CHECK CHECK CONSTRAINT [FK_BugNet_UserRoles_Users];


GO

-- Removes all objects (in the correct order) added to 
-- SQL Server by the stock ASP.NET membership provider
drop table aspnet_Profile
drop table aspnet_SchemaVersions
drop table aspnet_UsersInRoles
drop table aspnet_Membership
drop table aspnet_Roles
drop table aspnet_Users
drop table aspnet_Applications
 
drop view vw_aspnet_Applications
drop view vw_aspnet_MembershipUsers
drop view vw_aspnet_Profiles
drop view vw_aspnet_Roles
drop view vw_aspnet_Users
drop view vw_aspnet_UsersInRoles
 
drop procedure aspnet_AnyDataInTables
drop procedure aspnet_Applications_CreateApplication
drop procedure aspnet_CheckSchemaVersion
drop procedure aspnet_Membership_ChangePasswordQuestionAndAnswer
drop procedure aspnet_Membership_CreateUser
drop procedure aspnet_Membership_FindUsersByEmail
drop procedure aspnet_Membership_FindUsersByName
drop procedure aspnet_Membership_GetAllUsers
drop procedure aspnet_Membership_GetNumberOfUsersOnline
drop procedure aspnet_Membership_GetPassword
drop procedure aspnet_Membership_GetPasswordWithFormat
drop procedure aspnet_Membership_GetUserByEmail
drop procedure aspnet_Membership_GetUserByName
drop procedure aspnet_Membership_GetUserByUserId
drop procedure aspnet_Membership_ResetPassword
drop procedure aspnet_Membership_SetPassword
drop procedure aspnet_Membership_UnlockUser
drop procedure aspnet_Membership_UpdateUser
drop procedure aspnet_Membership_UpdateUserInfo
drop procedure aspnet_Profile_DeleteInactiveProfiles
drop procedure aspnet_Profile_DeleteProfiles
drop procedure aspnet_Profile_GetNumberOfInactiveProfiles
drop procedure aspnet_Profile_GetProfiles
drop procedure aspnet_Profile_GetProperties
drop procedure aspnet_Profile_SetProperties
drop procedure aspnet_RegisterSchemaVersion
drop procedure aspnet_Roles_CreateRole
drop procedure aspnet_Roles_DeleteRole
drop procedure aspnet_Roles_GetAllRoles
drop procedure aspnet_Roles_RoleExists
drop procedure aspnet_Setup_RemoveAllRoleMembers
drop procedure aspnet_Setup_RestorePermissions
drop procedure aspnet_UnRegisterSchemaVersion
drop procedure aspnet_Users_CreateUser
drop procedure aspnet_Users_DeleteUser
drop procedure aspnet_UsersInRoles_AddUsersToRoles
drop procedure aspnet_UsersInRoles_FindUsersInRole
drop procedure aspnet_UsersInRoles_GetRolesForUser
drop procedure aspnet_UsersInRoles_GetUsersInRoles
drop procedure aspnet_UsersInRoles_IsUserInRole
drop procedure aspnet_UsersInRoles_RemoveUsersFromRoles
 
drop schema aspnet_Membership_FullAccess
drop schema aspnet_Membership_BasicAccess
drop schema aspnet_Membership_ReportingAccess
drop schema aspnet_Profile_BasicAccess
drop schema aspnet_Profile_FullAccess
drop schema aspnet_Profile_ReportingAccess
drop schema aspnet_Roles_BasicAccess
drop schema aspnet_Roles_FullAccess
drop schema aspnet_Roles_ReportingAccess
 
drop role aspnet_Membership_FullAccess
drop role aspnet_Membership_BasicAccess
drop role aspnet_Membership_ReportingAccess
drop role aspnet_Profile_FullAccess
drop role aspnet_Profile_BasicAccess
drop role aspnet_Profile_ReportingAccess
drop role aspnet_Roles_FullAccess
drop role aspnet_Roles_BasicAccess
drop role aspnet_Roles_ReportingAccess

PRINT N'Update complete.';

GO
