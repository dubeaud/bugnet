CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionById]
	@ResolutionId int
AS
SELECT
	ResolutionId,
	ProjectId,
	ResolutionName,
	SortOrder,
	ResolutionImageUrl
FROM 
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionId
