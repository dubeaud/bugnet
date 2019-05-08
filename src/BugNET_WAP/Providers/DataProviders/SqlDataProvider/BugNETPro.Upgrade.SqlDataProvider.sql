/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
BEGIN TRAN
GO

/****** Object:  StoredProcedure [dbo].[BugNet_Reports_Burndown]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_Burndown] 
 @i   int    = 0, 
 @Start  datetime   = '6/4/2012',
 @End  datetime   = '7/4/2012',
 @dayRange int    = 0,
 @ProjectId  int = 0,
 @MilestoneId int = 0,
 @currentDay datetime   = '01/01/1753'
AS
BEGIN
 DECLARE @Burndown TABLE ([Date] datetime, Remaining float, Ideal float)
 SET @dayRange = DATEDIFF(DAY, @Start, @End)
    WHILE (@i <= @dayRange) 
 BEGIN
  SET NOCOUNT ON
    INSERT INTO @Burndown ([Date], Remaining, Ideal) 
    SELECT @Start as Dte
     ,ISNULL((SUM(IssueEstimation) - ISNULL((SELECT SUM(TimeLogged)FROM BugNet_IssuesView RIGHT JOIN BugNet_IssueWorkReports ON BugNet_IssuesView.IssueId = BugNet_IssueWorkReports.IssueId  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND BugNet_IssuesView.IssueMilestoneId = @MilestoneId 
		AND WorkDate <= @Start),0)),0) as Rem 
     ,ISNULL((SUM(IssueEstimation) - ((SUM(IssueEstimation) / @dayRange) * @i)), 0) as Act 
     FROM BugNet_IssuesView
     WHERE
     BugNet_IssuesView.ProjectId = @ProjectId
     AND BugNet_IssuesView.IssueMilestoneId = @MilestoneId
     --AND (LastUpdate <= @Start AND LastUpdate >= @currentDay)
  SET @Start = DATEADD(day, 1, @Start) 
  SET @i = @i + 1 
  IF @Start >= GETDATE() SET @currentDay = @End 
 END 
 
SELECT * FROM @Burndown 
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_GetClosedIssueCountByDate]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_GetClosedIssueCountByDate] 
	@ProjectId int
AS
SELECT convert(char(10), LastUpdate, 120) as DateTime, COUNT(*) AS TotalClosed
FROM 
	BugNet_Issues
LEFT OUTER JOIN 
	BugNet_ProjectStatus PS ON IssueStatusId = PS.StatusId 
WHERE 
	 BugNet_Issues.ProjectId = @ProjectId
	 AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId) AND LastUpdate  >  DATEADD (dd , -30,GETDATE()) GROUP BY convert(char(10), LastUpdate, 120)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_GetOpenIssueCountByDate]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_GetOpenIssueCountByDate] 
	@ProjectId int
AS
SELECT convert(char(10), IV.DateCreated, 120) as DateTime, COUNT(*) AS TotalOpened
FROM 
	BugNet_IssuesView IV
WHERE 
	 IV.ProjectId = @ProjectId AND IV.DateCreated  >  DATEADD (dd , -30,GETDATE()) GROUP BY convert(char(10), IV.DateCreated, 120)
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_IssuesByPriority]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_IssuesByPriority] 
 @Start  datetime   = '6/4/2012',
 @End  datetime   = '7/4/2012',
 @ProjectId  int = 0,
 @MilestoneId int = NULL
AS
BEGIN

SELECT * FROM BugNet_IssuesView IV 
	WHERE IV.ProjectId = @ProjectId 
		AND (@MilestoneId IS NULL OR IssueMilestoneId = @MilestoneId) 
		AND IV.IsClosed = 0 
		AND IV.LastUpdate <= @End AND IV.LastUpdate >= @Start
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_IssueTrend]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_IssueTrend] 
 @i   int    = 0, 
 @Start  datetime   = '6/4/2008',
 @End  datetime   = '7/4/2012',
 @dayRange int    = 0,
 @ProjectId  int = 0,
 @MilestoneId int = NULL,
 @currentDay datetime   = '01/01/1753'
AS
BEGIN 
 DECLARE @IssueTrend TABLE ([Date] datetime, CumulativeOpened int, CumulativeClosed int, TotalActive int)
 SET @dayRange = DATEDIFF(DAY, @Start, @End)
    WHILE (@i <= @dayRange) 
 BEGIN
  SET NOCOUNT ON
    INSERT INTO @IssueTrend ([Date],  CumulativeOpened, CumulativeClosed, TotalActive) 
    SELECT @Start as Dte
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS DateTime) = @Start),0) as Opened 
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS DateTime) = @Start
		AND IsClosed = 1),0) as Closed
     ,COUNT(*)
     FROM BugNet_IssuesView
     WHERE
     BugNet_IssuesView.ProjectId = @ProjectId
     AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
     AND IsClosed = 0
     --AND (LastUpdate <= @Start AND LastUpdate >= @currentDay)
  SET @Start = DATEADD(day, 1, @Start) 
  SET @i = @i + 1 
  IF @Start >= GETDATE() SET @currentDay = @End 
 END 
 
SELECT * FROM @IssueTrend
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_MilestoneBurnup]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_MilestoneBurnup] 
	@ProjectId int
AS
SELECT SUM(IssueEstimation) - SUM(TimeLogged) AS TotalHours, SUM(TimeLogged) AS TotalComplete, BugNet_IssuesView.MilestoneName  FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM ON IssueMilestoneId = MilestoneId 
WHERE 
	BugNet_IssuesView.ProjectId= @ProjectId
GROUP BY BugNet_IssuesView.MilestoneName
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Reports_TimeLogged]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Reports_TimeLogged] 
 @Start  datetime   = '6/4/2008',
 @End  datetime   = '7/4/2012',
 @ProjectId  int = 0,
 @MilestoneId int = NULL,
 @AssignedUser nvarchar(256) = NULL
AS
BEGIN 
	SELECT SUM(Duration) as TotalHours, BugNet_UserProfiles.DisplayName, BugNet_IssueWorkReports.UserId, WorkDate, ProjectId  
	FROM BugNet_IssuesView 
	JOIN BugNet_IssueWorkReports ON BugNet_IssuesView.IssueId = BugNet_IssueWorkReports.IssueId 
	JOIN Users ON BugNet_IssueWorkReports.UserId = Users.UserId
	JOIN BugNet_UserProfiles ON Users.UserName = BugNet_UserProfiles.UserName
	WHERE 
		ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR IssueMilestoneId = @MilestoneId)
		AND WorkDate <= @End AND WorkDate >= @Start GROUP BY  BugNet_UserProfiles.DisplayName, WorkDate, BugNet_IssueWorkReports.UserId, ProjectId
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_Delete]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_Delete]
 @Id int
AS
	DELETE C FROM BugNet_WikiContent C
    JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
    WHERE T.Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_GetById]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_GetById]
 @Id int
AS
	SELECT TOP 1
        C.Id, C.Source, C.Version, C.VersionDate, C.TitleId, T.Name, T.Slug,
        (SELECT COUNT(*) FROM BugNet_WikiContent WHERE TitleId = T.Id), T.ProjectId, 
		C.UserId CreatorUserId,
		ISNULL(DisplayName,'') CreatorDisplayName
    FROM BugNet_WikiContent C
    JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
	JOIN Users U ON C.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
     WHERE T.Id = @Id
     ORDER BY C.Version DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_GetBySlugAndTitle]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_GetBySlugAndTitle]
 @Slug nvarchar(255),
 @Title nvarchar(255),
 @ProjectId int
AS
	SELECT TOP 1
        C.Id, C.Source, C.Version, C.VersionDate, C.TitleId, T.Name, T.Slug,
        (SELECT COUNT(*) FROM BugNet_WikiContent WHERE TitleId = T.Id), T.ProjectId, C.UserId CreatorUserId,
		ISNULL(DisplayName,'') CreatorDisplayName
     FROM BugNet_WikiContent C
     JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
	 JOIN Users U ON C.UserId = U.UserId
	 LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
     WHERE 
		(T.Slug = @Slug OR T.Name = @Title) AND T.ProjectId = @ProjectId
     ORDER BY C.Version DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_GetByVersion]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_GetByVersion]
 @Id int,
 @Version int
AS
	SELECT TOP 1
        C.Id, C.Source, C.Version, C.VersionDate, C.TitleId, T.Name, T.Slug,
        (SELECT COUNT(*) FROM BugNet_WikiContent WHERE TitleId = T.Id), T.ProjectId, 
		C.UserId CreatorUserId,
		ISNULL(DisplayName,'') CreatorDisplayName
     FROM BugNet_WikiContent C
     JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
	 JOIN Users U ON C.UserId = U.UserId
	 LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
     WHERE T.Id = @Id
     AND C.Version = @Version
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_GetHistory]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_GetHistory]
 @Id int
AS
	SELECT
        C.Id, C.Source, C.Version, C.VersionDate, C.TitleId, T.Name, T.Slug, 0, T.ProjectId, C.UserId CreatorUserId,
		ISNULL(DisplayName,'') CreatorDisplayName
     FROM BugNet_WikiContent C
     JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
	 JOIN Users U ON C.UserId = U.UserId
	 LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
     WHERE T.Id = @Id
     ORDER BY C.Version DESC
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Wiki_Save]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BugNet_Wiki_Save]
 @ProjectId int,
 @TitleId int,
 @Slug nvarchar(255),
 @Name nvarchar(255),
 @Source nvarchar(max),
 @CreatedByUserName NVarChar(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER
	DECLARE @ContentCount INT

	SELECT @ContentCount = (SELECT COUNT(*) FROM BugNet_WikiContent WHERE TitleId = T.Id) 
     FROM BugNet_WikiTitle T
     WHERE T.Id = @TitleId
	
	SELECT @UserId = UserId FROM Users WHERE UserName = @CreatedByUserName
    
	IF (@TitleId = 0) BEGIN
        INSERT INTO BugNet_WikiTitle (Name, Slug, ProjectId)
        VALUES (@Name, @Slug, @ProjectId)

        SELECT @TitleId = SCOPE_IDENTITY()
    END

    INSERT INTO BugNet_WikiContent (TitleId, Source, Version, VersionDate, UserId)
    VALUES (@TitleId, @Source, ISNULL(@ContentCount, 0) + 1, GETDATE(), @UserId)

    SELECT @TitleId
GO
/****** Object:  Table [dbo].[BugNet_WikiContent]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_WikiContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TitleId] [int] NOT NULL,
	[Source] [nvarchar](max) NOT NULL,
	[Version] [int] NOT NULL,
	[VersionDate] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_BugNet_WikiContent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[BugNet_WikiTitle]    Script Date: 2/17/2014 5:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugNet_WikiTitle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Slug] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_BugNet_WikiTitle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
ALTER TABLE [dbo].[BugNet_WikiContent] ADD  CONSTRAINT [DF_BugNet_WikiContent_Version]  DEFAULT ((1)) FOR [Version]
GO
ALTER TABLE [dbo].[BugNet_WikiContent] ADD  CONSTRAINT [DF_BugNet_WikiContent_VersionDate]  DEFAULT (getdate()) FOR [VersionDate]
GO
ALTER TABLE [dbo].[BugNet_WikiContent]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_WikiContent_BugNet_WikiTitle] FOREIGN KEY([TitleId])
REFERENCES [dbo].[BugNet_WikiTitle] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugNet_WikiContent] CHECK CONSTRAINT [FK_BugNet_WikiContent_BugNet_WikiTitle]
GO
ALTER TABLE [dbo].[BugNet_WikiContent]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_WikiContent_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BugNet_WikiContent] CHECK CONSTRAINT [FK_BugNet_WikiContent_Users]
GO


INSERT [BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES (200, N'ViewWiki', N'View wiki')
INSERT [BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES (201, N'EditWiki', N'Edit wiki')
INSERT [BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES (202, N'DeleteWiki', N'Delete wiki')
GO


INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('ProductName', 'BugNET Pro')
GO

COMMIT
