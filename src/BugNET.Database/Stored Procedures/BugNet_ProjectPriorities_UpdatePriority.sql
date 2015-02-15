CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
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
