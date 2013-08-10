CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]
 @ProjectId	    INT,
 @IssueTypeName NVARCHAR(50),
 @IssueTypeImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT IssueTypeId  FROM BugNet_ProjectIssueTypes WHERE LOWER(IssueTypeName)= LOWER(@IssueTypeName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectIssueTypes 
   	( 
		ProjectId, 
		IssueTypeName,
		IssueTypeImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@IssueTypeName,
		@IssueTypeImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN -1
