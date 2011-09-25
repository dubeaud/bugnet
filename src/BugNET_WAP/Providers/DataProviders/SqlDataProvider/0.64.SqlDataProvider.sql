ALTER PROCEDURE BugNet_Version_GetVersionByProjectId
 @ProjectId INT
AS
SELECT
	VersionId,
	ProjectId,
	Name
FROM 
	Version
WHERE
	ProjectId = @ProjectId
ORDER BY VersionId DESC
GO

ALTER PROCEDURE BugNet_Bug_GetBugVersionCountByProject
	@ProjectId int
AS
	SELECT v.Name, COUNT(nt.VersionID) AS Number, v.VersionID 
	FROM Version v 
	LEFT OUTER JOIN (SELECT VersionID  
	FROM Bug b  
	WHERE (b.StatusID <> 4) AND (b.StatusID <> 5)) nt ON v.VersionID = nt.VersionID 
	WHERE (v.ProjectID = @ProjectId) 
	GROUP BY v.Name, v.VersionID
	ORDER BY v.VersionID DESC
GO

ALTER PROCEDURE dbo.BugNet_Bug_GetBugsByCriteria
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
if @StatusId = 0 
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
    ((@StatusId IS NULL) OR (StatusId In (1,2,3))) AND
    ((@AssignedTo IS NULL) OR (AssignedTo = @AssignedTo)) AND
    ((@HardwareId IS NULL) OR (HardwareId = @HardwareId)) AND
    ((@OperatingSystemId IS NULL) OR (OperatingSystemId = @OperatingSystemId))
else
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


CREATE PROCEDURE BugNet_Bug_GetChangeLog 
	@ProjectId int
AS

Select * from BugsView WHERE ProjectId = @ProjectId  AND StatusID = 5
Order By VersionId DESC,ComponentName ASC, TypeName ASC, AssignedUserDisplayName ASC
GO