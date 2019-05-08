
PRINT N'Altering [dbo].[BugNet_WikiContent]...';


GO
ALTER TABLE [dbo].[BugNet_WikiContent]
    ADD [UserId] UNIQUEIDENTIFIER NULL;


GO
PRINT N'Creating FK_BugNet_WikiContent_Users...';


GO
ALTER TABLE [dbo].[BugNet_WikiContent] WITH NOCHECK
    ADD CONSTRAINT [FK_BugNet_WikiContent_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);


GO
PRINT N'Altering [dbo].[BugNet_Wiki_GetById]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Wiki_GetById]
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
PRINT N'Altering [dbo].[BugNet_Wiki_GetBySlugAndTitle]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Wiki_GetBySlugAndTitle]
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
PRINT N'Altering [dbo].[BugNet_Wiki_GetByVersion]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Wiki_GetByVersion]
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
PRINT N'Altering [dbo].[BugNet_Wiki_GetHistory]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Wiki_GetHistory]
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
PRINT N'Altering [dbo].[BugNet_Wiki_Save]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Wiki_Save]
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
PRINT N'Altering [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]...';


GO
ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
  @IssueId int,
  @FileName nvarchar(250),
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
PRINT N'Altering [dbo].[BugNet_Project_CloneProject]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256),
  @CloningUserName VARCHAR(75) = NULL
)
AS

DECLARE
	@CreatorUserId UNIQUEIDENTIFIER

SET NOCOUNT OFF

SET @CreatorUserId = (SELECT ProjectCreatorUserId FROM BugNet_Projects WHERE ProjectId = @ProjectId)

IF(@CloningUserName IS NOT NULL OR LTRIM(RTRIM(@CloningUserName)) != '')
	EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @CloningUserName, @UserId = @CreatorUserId OUTPUT

-- Copy Project
INSERT BugNet_Projects
(
  ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  DateCreated,
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl 
)
SELECT
  @ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  GetDate(),
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  @CreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl
FROM 
  BugNet_Projects
WHERE
  ProjectId = @ProjectId
  
DECLARE @NewProjectId INT
SET @NewProjectId = SCOPE_IDENTITY()

-- Copy Milestones
INSERT BugNet_ProjectMilestones
(
  ProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  DateCreated
)
SELECT
  @NewProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  GetDate()
FROM
  BugNet_ProjectMilestones
WHERE
  ProjectId = @ProjectId  

-- Copy Project Members
INSERT BugNet_UserProjects
(
  UserId,
  ProjectId,
  DateCreated
)
SELECT
  UserId,
  @NewProjectId,
  GetDate()
FROM
  BugNet_UserProjects
WHERE
  ProjectId = @ProjectId

-- Copy Project Roles
INSERT BugNet_Roles
( 
	ProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
)
SELECT 
	@NewProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId

CREATE TABLE #OldRoles
(
  OldRowNumber INT IDENTITY,
  OldRoleId INT,
)

INSERT #OldRoles
(
  OldRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId
ORDER BY 
	RoleId

CREATE TABLE #NewRoles
(
  NewRowNumber INT IDENTITY,
  NewRoleId INT,
)

INSERT #NewRoles
(
  NewRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @NewProjectId
ORDER BY 
	RoleId

INSERT BugNet_UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId = NewRoleId
FROM 
	#OldRoles 
INNER JOIN #NewRoles ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_UserRoles UR ON UR.RoleId = OldRoleId

-- Copy Role Permissions
INSERT BugNet_RolePermissions
(
   PermissionId,
   RoleId
)
SELECT Perm.PermissionId, NewRoles.RoleId
FROM BugNet_RolePermissions Perm
INNER JOIN BugNet_Roles OldRoles ON Perm.RoleId = OldRoles.RoleID
INNER JOIN BugNet_Roles NewRoles ON NewRoles.RoleName = OldRoles.RoleName
WHERE OldRoles.ProjectId = @ProjectId 
	  and NewRoles.ProjectId = @NewProjectId


-- Copy Custom Fields
INSERT BugNet_ProjectCustomFields
(
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
)
SELECT
  @NewProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
  
-- Copy Custom Field Selections
CREATE TABLE #OldCustomFields
(
  OldRowNumber INT IDENTITY,
  OldCustomFieldId INT,
)
INSERT #OldCustomFields
(
  OldCustomFieldId
)
SELECT
	CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
ORDER BY CustomFieldId

CREATE TABLE #NewCustomFields
(
  NewRowNumber INT IDENTITY,
  NewCustomFieldId INT,
)

INSERT #NewCustomFields
(
  NewCustomFieldId
)
SELECT
  CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @NewProjectId
ORDER BY CustomFieldId

INSERT BugNet_ProjectCustomFieldSelections
(
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
)
SELECT 
	CustomFieldId = NewCustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
FROM 
	#OldCustomFields 
INNER JOIN #NewCustomFields ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_ProjectCustomFieldSelections CFS ON CFS.CustomFieldId = OldCustomFieldId

-- Copy Project Mailboxes
INSERT BugNet_ProjectMailBoxes
(
  MailBox,
  ProjectId,
  AssignToUserId,
  IssueTypeId
)
SELECT
  Mailbox,
  @NewProjectId,
  AssignToUserId,
  IssueTypeId
FROM
  BugNet_ProjectMailBoxes
WHERE
  ProjectId = @ProjectId

-- Copy Categories
INSERT BugNet_ProjectCategories
(
  ProjectId,
  CategoryName,
  ParentCategoryId
)
SELECT
  @NewProjectId,
  CategoryName,
  ParentCategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId AND Disabled = 0 


CREATE TABLE #OldCategories
(
  OldRowNumber INT IDENTITY,
  OldCategoryId INT,
)

INSERT #OldCategories
(
  OldCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId AND Disabled = 0
ORDER BY CategoryId

CREATE TABLE #NewCategories
(
  NewRowNumber INT IDENTITY,
  NewCategoryId INT,
)

INSERT #NewCategories
(
  NewCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @NewProjectId AND Disabled = 0
ORDER BY CategoryId

UPDATE BugNet_ProjectCategories SET
  ParentCategoryId = NewCategoryId
FROM
  #OldCategories INNER JOIN #NewCategories ON OldRowNumber = NewRowNumber
WHERE
  ProjectId = @NewProjectId
  And ParentCategoryId = OldCategoryId 

-- Copy Status's
INSERT BugNet_ProjectStatus
(
  ProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
)
SELECT
  @NewProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
FROM
  BugNet_ProjectStatus
WHERE
  ProjectId = @ProjectId 
 
-- Copy Priorities
INSERT BugNet_ProjectPriorities
(
  ProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
FROM
  BugNet_ProjectPriorities
WHERE
  ProjectId = @ProjectId 

-- Copy Resolutions
INSERT BugNet_ProjectResolutions
(
  ProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
FROM
  BugNet_ProjectResolutions
WHERE
  ProjectId = @ProjectId
 
-- Copy Issue Types
INSERT BugNet_ProjectIssueTypes
(
  ProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
FROM
  BugNet_ProjectIssueTypes
WHERE
  ProjectId = @ProjectId

-- Copy Project Notifications
INSERT BugNet_ProjectNotifications
(
  ProjectId,
  UserId
)
SELECT
  @NewProjectId,
  UserId
FROM
  BugNet_ProjectNotifications
WHERE
  ProjectId = @ProjectId

RETURN @NewProjectId
GO
PRINT N'Altering [dbo].[BugNet_Project_DeleteProject]...';


GO

ALTER PROCEDURE [dbo].[BugNet_Project_DeleteProject]
    @ProjectIdToDelete int
AS

--Delete these first
DELETE FROM BugNet_IssueVotes WHERE BugNet_IssueVotes.IssueId in (SELECT B.IssueId FROM BugNet_Issues B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_Issues WHERE ProjectId = @ProjectIdToDelete

--Now Delete everything that was attached to a project and an issue
DELETE FROM BugNet_Issues WHERE BugNet_Issues.IssueCategoryId in (SELECT B.CategoryId FROM BugNet_ProjectCategories B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCategories WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_UserProjects WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMailBoxes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectIdToDelete

--now delete everything attached to the project
DELETE FROM BugNet_ProjectCustomFieldValues WHERE BugNet_ProjectCustomFieldValues.CustomFieldId in (SELECT B.CustomFieldId FROM BugNet_ProjectCustomFields B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Roles WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Queries WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectNotifications WHERE ProjectId = @ProjectIdToDelete

--now delete the project
DELETE FROM BugNet_Projects WHERE ProjectId = @ProjectIdToDelete
GO
PRINT N'Altering [dbo].[BugNet_ProjectCustomField_DeleteCustomField]...';


GO

ALTER PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN

	DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_ProjectCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT
GO
PRINT N'Altering [dbo].[BugNet_Query_GetSavedQuery]...';


GO

ALTER PROCEDURE [dbo].[BugNet_Query_GetSavedQuery] 
  @QueryId INT
AS

SELECT 
	BooleanOperator,
	FieldName,
	ComparisonOperator,
	FieldValue,
	DataType,
	CustomFieldId
FROM 
	BugNet_QueryClauses
WHERE 
	QueryId = @QueryId;
GO
PRINT N'Altering [dbo].[BugNet_Query_SaveQueryClause]...';


GO

ALTER PROCEDURE [dbo].[BugNet_Query_SaveQueryClause] 
  @QueryId INT,
  @BooleanOperator NVarChar(50),
  @FieldName NVarChar(50),
  @ComparisonOperator NVarChar(50),
  @FieldValue NVarChar(50),
  @DataType INT,
  @CustomFieldId INT = NULL
AS
INSERT BugNet_QueryClauses
(
  QueryId,
  BooleanOperator,
  FieldName,
  ComparisonOperator,
  FieldValue,
  DataType, 
  CustomFieldId
) 
VALUES (
  @QueryId,
  @BooleanOperator,
  @FieldName,
  @ComparisonOperator,
  @FieldValue,
  @DataType,
  @CustomFieldId
)
GO
PRINT N'Altering [dbo].[BugNet_Reports_IssueTrend]...';


GO
ALTER PROCEDURE [dbo].[BugNet_Reports_IssueTrend] 
 @i   int    = 0, 
 @Start  date   = '6/4/2008',
 @End  date   = '7/4/2012',
 @dayRange int    = 0,
 @ProjectId  int = 0,
 @MilestoneId int = NULL,
 @currentDay date   = '01/01/0001'
AS
BEGIN 
 DECLARE @IssueTrend TABLE ([Date] date, CumulativeOpened int, CumulativeClosed int, TotalActive int)
 SET @dayRange = DATEDIFF(DAY, @Start, @End)
    WHILE (@i <= @dayRange) 
 BEGIN
  SET NOCOUNT ON
    INSERT INTO @IssueTrend ([Date],  CumulativeOpened, CumulativeClosed, TotalActive) 
    SELECT @Start as Dte
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS Date) = @Start),0) as Opened 
     ,ISNULL((SELECT COUNT(*) FROM BugNet_IssuesView  
     WHERE BugNet_IssuesView.ProjectId = @ProjectId
		AND (@MilestoneId IS NULL OR BugNet_IssuesView.IssueMilestoneId = @MilestoneId)
		AND CAST(DateCreated AS Date) = @Start
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
LEFT JOIN BugNet_UserRoles UR
	ON U.UserId = UR.UserId 
LEFT JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId AND R.ProjectId = @ProjectId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1
	AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only')
ORDER BY DisplayName ASC
GO
PRINT N'Refreshing [dbo].[BugNet_Wiki_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Wiki_Delete]';


GO
ALTER TABLE [dbo].[BugNet_WikiContent] WITH CHECK CHECK CONSTRAINT [FK_BugNet_WikiContent_Users];

-- set all current wiki entries to the admin user
UPDATE BugNet_WikiContent SET UserId = (SELECT TOP 1 UserId FROM Users) 
GO

GO
PRINT N'Update complete.';


GO


