/****** Object:  Table [dbo].[BugNet_DefaultValues]    Script Date: 4/5/2013 11:17:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BugNet_DefaultValues](
	[ProjectId] [int] NOT NULL,
	[DefaultType] [int] NULL,
	[StatusId] [int] NULL,
	[IssueOwnerUserId] [uniqueidentifier] NULL,
	[IssuePriorityId] [int] NULL,
	[IssueAffectedMilestoneId] [int] NULL,
	[IssueAssignedUserId] [uniqueidentifier] NULL,
	[IssueVisibility] [int] NULL,
	[IssueCategoryId] [int] NULL,
	[IssueDueDate] [int] NULL,
	[IssueProgress] [int] NULL,
	[IssueMilestoneId] [int] NULL,
	[IssueEstimation] [decimal](5, 2) NULL,
	[IssueResolutionId] [int] NULL,
	[OwnedByNotify] [bit] NULL,
	[AssignedToNotify] [bit] NULL,
 CONSTRAINT [PK_BugNet_DefaultValues] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)) 

GO

ALTER TABLE [dbo].[BugNet_DefaultValues] ADD  CONSTRAINT [DF_BugNet_DefaultValues_OwnedByNotify]  DEFAULT ((1)) FOR [OwnedByNotify]
GO

ALTER TABLE [dbo].[BugNet_DefaultValues] ADD  CONSTRAINT [DF_BugNet_DefaultValues_AssignedTo]  DEFAULT ((1)) FOR [AssignedToNotify]
GO

ALTER TABLE [dbo].[BugNet_DefaultValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users] FOREIGN KEY([IssueOwnerUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[BugNet_DefaultValues] CHECK CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users]
GO

ALTER TABLE [dbo].[BugNet_DefaultValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users1] FOREIGN KEY([IssueAssignedUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

ALTER TABLE [dbo].[BugNet_DefaultValues] CHECK CONSTRAINT [FK_BugNet_DefaultValues_aspnet_Users1]
GO

ALTER TABLE [dbo].[BugNet_DefaultValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_DefaultValues_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[BugNet_DefaultValues] CHECK CONSTRAINT [FK_BugNet_DefaultValues_BugNet_Projects]
GO

/****** Object:  Table [dbo].[BugNet_DefaultValuesVisibility]    Script Date: 4/5/2013 11:17:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BugNet_DefaultValuesVisibility](
	[ProjectId] [int] NOT NULL,
	[StatusVisibility] [bit] NOT NULL,
	[OwnedByVisibility] [bit] NOT NULL,
	[PriorityVisibility] [bit] NOT NULL,
	[AssignedToVisibility] [bit] NOT NULL,
	[PrivateVisibility] [bit] NOT NULL,
	[CategoryVisibility] [bit] NOT NULL,
	[DueDateVisibility] [bit] NOT NULL,
	[TypeVisibility] [bit] NOT NULL,
	[PercentCompleteVisibility] [bit] NOT NULL,
	[MilestoneVisibility] [bit] NOT NULL,
	[EstimationVisibility] [bit] NOT NULL,
	[ResolutionVisibility] [bit] NOT NULL,
	[AffectedMilestoneVisibility] [bit] NOT NULL,
 CONSTRAINT [PK_Bugnet_DefaultValuesVisibility] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)) 

GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_StatusVisibility]  DEFAULT ((1)) FOR [StatusVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_OwnedByVisibility]  DEFAULT ((1)) FOR [OwnedByVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PriorityVisibility]  DEFAULT ((1)) FOR [PriorityVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AssignedToVisibility]  DEFAULT ((1)) FOR [AssignedToVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PrivateVisibility]  DEFAULT ((1)) FOR [PrivateVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_CategoryVisibility]  DEFAULT ((1)) FOR [CategoryVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_DueDateVisibility]  DEFAULT ((1)) FOR [DueDateVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_TypeVisibility]  DEFAULT ((1)) FOR [TypeVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PercentCompleteVisibility]  DEFAULT ((1)) FOR [PercentCompleteVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_MilestoneVisibility]  DEFAULT ((1)) FOR [MilestoneVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_EstimationVisibility]  DEFAULT ((1)) FOR [EstimationVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_ResolutionVisibility]  DEFAULT ((1)) FOR [ResolutionVisibility]
GO

ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] ADD  CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisivility]  DEFAULT ((1)) FOR [AffectedMilestoneVisibility]
GO


/****** Object:  StoredProcedure [dbo].[BugNet_DefaultValues_GetByProjectId]    Script Date: 4/5/2013 11:20:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BugNet_DefaultValues_GetByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_DefaultValView 
WHERE 
	ProjectId= @ProjectId
	
GO

/****** Object:  StoredProcedure [dbo].[BugNet_DefaultValues_Set]    Script Date: 4/5/2013 11:20:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BugNet_DefaultValues_Set]
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

SELECT @IssueOwnerUserId = UserId FROM aspnet_users WHERE UserName = @IssueOwnerUserName
SELECT @IssueAssignedUserId = UserId FROM aspnet_users WHERE UserName = @IssueAssignedUserName
BEGIN
	BEGIN TRAN
		DECLARE @defVisExists int
		SELECT @defVisExists = COUNT(*) 
		FROM Bugnet_DefaultValuesVisibility
			WHERE Bugnet_DefaultValuesVisibility.ProjectId = @ProjectId
				IF(@defVisExists>0)
					BEGIN
						UPDATE Bugnet_DefaultValuesVisibility
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
					INSERT INTO Bugnet_DefaultValuesVisibility
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

/****** Object:  View [dbo].[BugNet_DefaultValView]    Script Date: 4/5/2013 11:25:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[BugNet_DefaultValView]
AS
SELECT     dbo.BugNet_DefaultValues.DefaultType, dbo.BugNet_DefaultValues.StatusId, dbo.BugNet_DefaultValues.IssueOwnerUserId, 
                      dbo.BugNet_DefaultValues.IssuePriorityId, dbo.BugNet_DefaultValues.IssueAffectedMilestoneId, dbo.BugNet_DefaultValues.ProjectId, 
                      ISNULL(OwnerUsers.UserName, N'none') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
                      ISNULL(AssignedUsers.UserName, N'none') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
                      dbo.BugNet_DefaultValues.IssueAssignedUserId, dbo.BugNet_DefaultValues.IssueCategoryId, dbo.BugNet_DefaultValues.IssueVisibility, 
                      dbo.BugNet_DefaultValues.IssueDueDate, dbo.BugNet_DefaultValues.IssueProgress, dbo.BugNet_DefaultValues.IssueMilestoneId, 
                      dbo.BugNet_DefaultValues.IssueEstimation, dbo.BugNet_DefaultValues.IssueResolutionId, dbo.Bugnet_DefaultValuesVisibility.StatusVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.PriorityVisibility, dbo.Bugnet_DefaultValuesVisibility.OwnedByVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.AssignedToVisibility, dbo.Bugnet_DefaultValuesVisibility.PrivateVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.CategoryVisibility, dbo.Bugnet_DefaultValuesVisibility.DueDateVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.TypeVisibility, dbo.Bugnet_DefaultValuesVisibility.PercentCompleteVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.MilestoneVisibility, dbo.Bugnet_DefaultValuesVisibility.ResolutionVisibility, 
                      dbo.Bugnet_DefaultValuesVisibility.EstimationVisibility, dbo.Bugnet_DefaultValuesVisibility.AffectedMilestoneVisibility, 
                      dbo.BugNet_DefaultValues.OwnedByNotify, dbo.BugNet_DefaultValues.AssignedToNotify
FROM         dbo.BugNet_DefaultValues LEFT OUTER JOIN
                      dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_DefaultValues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_DefaultValues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.Bugnet_DefaultValuesVisibility ON dbo.BugNet_DefaultValues.ProjectId = dbo.Bugnet_DefaultValuesVisibility.ProjectId


GO

/****** Object:  StoredProcedure [dbo].[BugNet_User_GetUsersByProjectId]    Script Date: 4/14/2013 3:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int,
	@ExcludeReadonlyUsers bit
AS
SELECT DISTINCT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	aspnet_Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  aspnet_Membership M 
	ON U.UserId = M.UserId
JOIN BugNet_UserRoles UR
	ON U.UserId = UR.UserId
JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1 AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only' AND R.RoleName != 'Reporter')
ORDER BY DisplayName ASC

GO

INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('ro-RO', 'Romanian (Romania)', 'en-US')
GO

INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('fr-CA', 'French (Canadian)', 'en-US')
GO

DROP PROCEDURE [dbo].[BugNet_Project_GetChangeLog]
GO

DROP PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
GO

/****** Object:  StoredProcedure [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]    Script Date: 4/27/2013 2:08:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId int,
	@Revision int,
	@Repository nvarchar(400),
	@RevisionDate nvarchar(100),
	@RevisionAuthor nvarchar(100),
	@RevisionMessage ntext,
	@Changeset nvarchar(100),
	@Branch nvarchar(255)
AS

IF (NOT EXISTS(SELECT IssueRevisionId FROM BugNet_IssueRevisions WHERE IssueId = @IssueId AND Revision = @Revision 
	AND RevisionDate = @RevisionDate AND Repository = @Repository AND RevisionAuthor = @RevisionAuthor))
BEGIN
	INSERT BugNet_IssueRevisions
	(
		Revision,
		IssueId,
		Repository,
		RevisionAuthor,
		RevisionDate,
		RevisionMessage,
		Changeset,
		Branch,
		DateCreated
	) 
	VALUES 
	(
		@Revision,
		@IssueId,
		@Repository,
		@RevisionAuthor,
		@RevisionDate,
		@RevisionMessage,
		@Changeset,
		@Branch,
		GetDate()
	)

	RETURN scope_identity()
END
GO

/****** Object:  StoredProcedure [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]    Script Date: 4/27/2013 2:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS


SET NOCOUNT ON
DECLARE @DefaultCulture NVARCHAR(50)
SET @DefaultCulture = (SELECT ISNULL(SettingValue, 'en-US') FROM BugNet_HostSettings WHERE SettingName = 'ApplicationDefaultLanguage')

DECLARE @tmpTable TABLE (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUsername nvarchar(50), NotificationDisplayName nvarchar(50), NotificationEmail nvarchar(50), NotificationCulture NVARCHAR(50))
INSERT @tmpTable

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	M.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
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
	u.UserName NotificationUsername,
	IsNull(DisplayName,'') NotificationDisplayName,
	m.Email NotificationEmail,
	ISNULL(UP.PreferredLocale, @DefaultCulture) AS NotificationCulture
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	aspnet_Users u,
	aspnet_Membership m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT DISTINCT IssueId,NotificationUserId, NotificationUsername, NotificationDisplayName, NotificationEmail, NotificationCulture FROM @tmpTable ORDER BY NotificationDisplayName
GO
