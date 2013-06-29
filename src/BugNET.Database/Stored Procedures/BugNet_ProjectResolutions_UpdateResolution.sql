CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_UpdateResolution]
	@ProjectId int,
	@ResolutionId int,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldResolutionId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId
SELECT @OldResolutionId = ResolutionId FROM BugNet_ProjectResolutions WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectResolutions SET
	ProjectId = @ProjectId,
	ResolutionName = @ResolutionName,
	ResolutionImageUrl = @ResolutionImageUrl,
	SortOrder = @SortOrder
WHERE ResolutionId = @ResolutionId

UPDATE BugNet_ProjectResolutions SET
	SortOrder = @OldSortOrder
WHERE ResolutionId = @OldResolutionId
