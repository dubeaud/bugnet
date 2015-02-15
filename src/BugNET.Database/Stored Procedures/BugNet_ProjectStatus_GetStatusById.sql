CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusById]
	@StatusId int
AS
SELECT
	StatusId,
	ProjectId,
	StatusName,
	SortOrder,
	StatusImageUrl,
	IsClosedState
FROM 
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusId
