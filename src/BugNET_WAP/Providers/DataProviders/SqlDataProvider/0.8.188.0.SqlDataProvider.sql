/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: May 2nd, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

ALTER TABLE BugNet_ProjectMilestones
ADD MilestoneNotes NVARCHAR(MAX)
GO

ALTER TABLE BugNet_ProjectMilestones
ADD MilestoneCompleted bit NOT NULL DEFAULT 0
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
 	@ProjectId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted bit
AS
IF NOT EXISTS(SELECT MilestoneId  FROM BugNet_ProjectMilestones WHERE LOWER(MilestoneName)= LOWER(@MilestoneName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectMilestones 
	(
		ProjectId, 
		MilestoneName ,
		MilestoneImageUrl,
		SortOrder,
		MilestoneDueDate ,
		MilestoneReleaseDate,
		MilestoneNotes,
		MilestoneCompleted
	) VALUES (
		@ProjectId, 
		@MilestoneName,
		@MilestoneImageUrl,
		@SortOrder,
		@MilestoneDueDate,
		@MilestoneReleaseDate,
		@MilestoneNotes,
		@MilestoneCompleted
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO


ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
 @MilestoneId INT
AS
SELECT
	MilestoneId,
	ProjectId,
	MilestoneName,
	MilestoneImageUrl,
	SortOrder,
	MilestoneDueDate,
	MilestoneReleaseDate,
	MilestoneNotes,
	MilestoneCompleted
FROM 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneId
GO	

ALTER PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
	@ProjectId int,
	@PriorityId int,
	@PriorityName NVARCHAR(50),
	@PriorityImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldPriorityId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId
SELECT @OldPriorityId = PriorityId FROM BugNet_ProjectPriorities WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectPriorities SET
	ProjectId = @ProjectId,
	PriorityName = @PriorityName,
	PriorityImageUrl = @PriorityImageUrl,
	SortOrder = @SortOrder
WHERE PriorityId = @PriorityId

UPDATE BugNet_ProjectPriorities SET
	SortOrder = @OldSortOrder
WHERE PriorityId = @OldPriorityId
GO


ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
	@ProjectId INT,
	@MilestoneCompleted bit
AS
SELECT * FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId AND 
MilestoneCompleted = (CASE WHEN  @MilestoneCompleted = 1 THEN MilestoneCompleted ELSE @MilestoneCompleted END) ORDER BY SortOrder ASC
GO


ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT v.MilestoneName, COUNT(nt.IssueMilestoneId) AS Number, v.MilestoneId, v.MilestoneImageUrl
	FROM BugNet_ProjectMilestones v 
	LEFT OUTER JOIN 
(SELECT IssueMilestoneId
	FROM BugNet_Issues   
	WHERE 
		Disabled = 0 
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt 
	ON 
		v.MilestoneId = nt.IssueMilestoneId 
	WHERE 
		(v.ProjectId = @ProjectId) AND v.MilestoneCompleted = 0
	GROUP BY 
		v.MilestoneName, v.MilestoneId,v.SortOrder, v.MilestoneImageUrl
	ORDER BY 
		v.SortOrder ASC
END
GO

ALTER PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
	@ProjectId int,
	@MilestoneId int,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@SortOrder int,
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted bit
AS

DECLARE @OldSortOrder int
DECLARE @OldMilestoneId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId
SELECT @OldMilestoneId = MilestoneId FROM BugNet_ProjectMilestones WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectMilestones SET
	ProjectId = @ProjectId,
	MilestoneName = @MilestoneName,
	MilestoneImageUrl = @MilestoneImageUrl,
	SortOrder = @SortOrder,
	MilestoneDueDate = @MilestoneDueDate,
	MilestoneReleaseDate = @MilestoneReleaseDate,
	MilestoneNotes = @MilestoneNotes,
	MilestoneCompleted = @MilestoneCompleted
WHERE MilestoneId = @MilestoneId

UPDATE BugNet_ProjectMilestones SET
	SortOrder = @OldSortOrder
WHERE MilestoneId = @OldMilestoneId
GO

INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('CommonTerms','en','CompletedMilestone', 'Completed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('Administration/Projects/UserControls/ProjectMilestones.ascx','en','IsCompletedMilestone.Text', 'Is Completed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType],[cultureCode] ,[resourceKey],[resourceValue])VALUES
           ('CommonTerms','en','Notes', 'Notes')

COMMIT

SET NOEXEC OFF
GO