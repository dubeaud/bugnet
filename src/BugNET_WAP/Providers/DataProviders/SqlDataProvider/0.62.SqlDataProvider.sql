
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByVersion]
GO

DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsAssignedTo]
GO

DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByPriority]
GO

DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByComponent]
GO

DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByType]
GO

DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByStatus]
GO

ALTER TABLE [dbo].[Type] ADD
[ImageUrl] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

ALTER TABLE [dbo].[Priority] ADD
[ImageUrl] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

ALTER PROCEDURE BugNet_Priority_GetAllPriorities
AS
SELECT
	PriorityId,
	Name,
	ImageUrl
FROM 
	Priority

GO

ALTER PROCEDURE BugNet_Bug_GetBugTypeCountByProject
	@ProjectId int
AS
	SELECT     t.Name, COUNT(nt.TypeID) AS Number, t.TypeID, t.ImageUrl
	FROM  Type t 
	LEFT OUTER JOIN (SELECT TypeID, ProjectID 
	FROM Bug b WHERE (b.StatusID <> 4) 
	AND (b.StatusID <> 5)) nt 
	ON t.TypeID = nt.TypeID 
	AND nt.ProjectID = @ProjectId
	GROUP BY t.Name, t.TypeID,t.ImageUrl

GO

ALTER PROCEDURE BugNet_Type_GetTypeById
	@TypeId int
AS
SELECT
	TypeId,
	Name,
	ImageUrl
FROM 
	Type
WHERE
	TypeId = @TypeId

GO

ALTER PROCEDURE BugNet_Type_GetAllTypes
AS
SELECT
	TypeId,
	Name,
	ImageUrl
FROM 
	Type

GO

ALTER PROCEDURE BugNet_Priority_GetPriorityById
	@PriorityId int
AS
SELECT
	PriorityId,
	Name,
	ImageUrl
FROM 
	Priority
WHERE
	PriorityId = @PriorityId

GO

CREATE PROCEDURE dbo.BugNet_Bug_GetBugsByCriteria
(
    @ProjectId int = NULL,
    @ComponentId int = NULL,
    @VersionId int = NULL,
    @PriorityId int = NULL,
    @TypeId int = NULL,
    @ResolutionId int = NULL,
    @StatusId int = NULL,
    @AssignedTo int = NULL,
    @HardwareId int = NULL,
    @OperatingSystemId int = NULL
)
AS
SELECT
    *
FROM
    BugsView
WHERE
    ((@ProjectId IS NULL) OR (ProjectId = @ProjectId)) AND
    ((@ComponentId IS NULL) OR (ComponentId = @ComponentId)) AND
    ((@VersionId IS NULL) OR (VersionId = @VersionId)) AND
    ((@PriorityId IS NULL) OR (PriorityId = @PriorityId))AND
    ((@TypeId IS NULL) OR (TypeId = @TypeId)) AND
    ((@ResolutionId IS NULL) OR (ResolutionId = @ResolutionId)) AND
    ((@StatusId IS NULL) OR (StatusId = @StatusId)) AND
    ((@AssignedTo IS NULL) OR (AssignedTo = @AssignedTo)) AND
    ((@HardwareId IS NULL) OR (HardwareId = @HardwareId)) AND
    ((@OperatingSystemId IS NULL) OR (OperatingSystemId = @OperatingSystemId))
GO

UPDATE Type SET ImageUrl = '~/Images/Any.gif' WHERE TypeID = 1
UPDATE Type SET ImageUrl = '~/Images/Bug.gif' WHERE TypeID = 2
UPDATE Type SET ImageUrl = '~/Images/NewFeature.gif' WHERE TypeID = 3
UPDATE Type SET ImageUrl = '~/Images/Task.gif' WHERE TypeID = 4
UPDATE Type SET ImageUrl = '~/Images/Improvement.gif' WHERE TypeID = 5

UPDATE Priority SET ImageUrl = '~/Images/Blocker.gif' WHERE PriorityID = 1
UPDATE Priority SET ImageUrl = '~/Images/Critical.gif' WHERE PriorityID = 2
UPDATE Priority SET ImageUrl = '~/Images/Major.gif' WHERE PriorityID = 3
UPDATE Priority SET ImageUrl = '~/Images/Minor.gif' WHERE PriorityID = 4
UPDATE Priority SET ImageUrl = '~/Images/Trivial.gif' WHERE PriorityID =5