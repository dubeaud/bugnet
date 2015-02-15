CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]
		@ProjectId Int
AS
SELECT StatusId, ProjectId, StatusName,SortOrder, StatusImageUrl, IsClosedState
FROM BugNet_ProjectStatus
WHERE ProjectId = @ProjectId
ORDER BY SortOrder
