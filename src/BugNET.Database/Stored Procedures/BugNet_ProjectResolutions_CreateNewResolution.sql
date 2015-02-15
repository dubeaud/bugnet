CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CreateNewResolution]
 	@ProjectId INT,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50)
AS
IF NOT EXISTS(SELECT ResolutionId  FROM BugNet_ProjectResolutions WHERE LOWER(ResolutionName)= LOWER(@ResolutionName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectResolutions
	(
		ProjectId, 
		ResolutionName ,
		ResolutionImageUrl,
		SortOrder
	) VALUES (
		@ProjectId, 
		@ResolutionName,
		@ResolutionImageUrl,
		@SortOrder
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
