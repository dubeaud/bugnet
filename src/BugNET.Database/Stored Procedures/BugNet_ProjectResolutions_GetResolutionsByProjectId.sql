CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]
		@ProjectId Int
AS
SELECT ResolutionId, ProjectId, ResolutionName,SortOrder, ResolutionImageUrl 
FROM BugNet_ProjectResolutions
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
