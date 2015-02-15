CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
 @ProjectId	    INT,
 @PriorityName        NVARCHAR(50),
 @PriorityImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT PriorityId  FROM BugNet_ProjectPriorities WHERE LOWER(PriorityName)= LOWER(@PriorityName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectPriorities 
   	( 
		ProjectId, 
		PriorityName,
		PriorityImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@PriorityName,
		@PriorityImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN 0
