CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_UpdateStatus]
	@ProjectId int,
	@StatusId int,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@SortOrder int,
	@IsClosedState bit
AS

DECLARE @OldSortOrder int
DECLARE @OldStatusId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectStatus WHERE StatusId = @StatusId
SELECT @OldStatusId = StatusId FROM BugNet_ProjectStatus WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId
		
UPDATE BugNet_ProjectStatus SET
	ProjectId = @ProjectId,
	StatusName = @StatusName,
	StatusImageUrl = @StatusImageUrl,
	SortOrder = @SortOrder,
	IsClosedState = @IsClosedState
WHERE StatusId = @StatusId

UPDATE BugNet_ProjectStatus SET
	SortOrder = @OldSortOrder
WHERE StatusId = @OldStatusId
