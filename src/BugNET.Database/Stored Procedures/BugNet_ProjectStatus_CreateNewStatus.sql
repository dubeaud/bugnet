CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CreateNewStatus]
 	@ProjectId INT,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@IsClosedState bit
AS
IF NOT EXISTS(SELECT StatusId  FROM BugNet_ProjectStatus WHERE LOWER(StatusName)= LOWER(@StatusName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectStatus
	(
		ProjectId, 
		StatusName ,
		StatusImageUrl,
		SortOrder,
		IsClosedState
	) VALUES (
		@ProjectId, 
		@StatusName,
		@StatusImageUrl,
		@SortOrder,
		@IsClosedState
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
