CREATE PROCEDURE [BugNet_IssueQuery]
    @IssueId INT = NULL,
    @IssueTitle NVARCHAR(500) = NULL,
    @IssueDescription NVARCHAR(500) = NULL,
    @ProjectId INT = NULL,
    @ProjectCode NVARCHAR(50) = NULL,    
	@StatusId INT = NULL,
    @MilestoneId INT = NULL,
    @AffectedMilestoneId INT = NULL,
    @CategoryId INT = NULL,
    @TypeId INT = NULL,
    @PriorityId INT = NULL,
    @ResolutionId INT = NULL,    
    @AssignedUser NVARCHAR(75) = NULL,
    @CreatorUser NVARCHAR(75) = NULL, 
    @LastUpdatedUser NVARCHAR(75) = NULL,    
    @OwnerUser NVARCHAR(75) = NULL,
    @IsDisabled BIT = NULL,
    @IsClosed BIT = NULL,
        
	@SortField VARCHAR(150) = 'IssueId',
	@SortDirection VARCHAR(4) = 'ASC',
	@PageSize INT = NULL,
	@PageNumber INT = NULL
AS

SET NOCOUNT ON

DECLARE 
	@row_count INT,
	@AssignedUserId UNIQUEIDENTIFIER,
	@CreatorUserId UNIQUEIDENTIFIER,
	@OwnerUserId UNIQUEIDENTIFIER,
	@LastUpdatedUserId UNIQUEIDENTIFIER
	
DECLARE @Data TABLE
(
	[ROW_NUMBER] INT IDENTITY(1,1) NOT NULL,
	IssueId INT NOT NULL
)
	
IF(@SortDirection IS NOT NULL)
	SET @SortDirection = UPPER(LTRIM(RTRIM(@SortDirection)))
ELSE
	SET @SortDirection = 'ASC'
	
IF(@SortField IS NOT NULL)
	SET @SortField = LTRIM(RTRIM(@SortField))
ELSE
	SET @SortField = 'IssueId'

IF (LTRIM(RTRIM(@IssueTitle)) = '')
	SET @IssueTitle = NULL

IF (LTRIM(RTRIM(@IssueDescription)) = '')
	SET @IssueDescription = NULL
			
IF (LTRIM(RTRIM(@projectCode)) = '')
	SET @projectCode = NULL
		
IF (LTRIM(RTRIM(@AssignedUser)) = '')
	SET @AssignedUser = NULL

IF (LTRIM(RTRIM(@CreatorUser)) = '')
	SET @CreatorUser = NULL

IF (LTRIM(RTRIM(@LastUpdatedUser)) = '')
	SET @LastUpdatedUser = NULL

IF (LTRIM(RTRIM(@OwnerUser)) = '')
	SET @OwnerUser = NULL

EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @AssignedUser, @UserId = @AssignedUserId OUTPUT
EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @CreatorUser, @UserId = @CreatorUserId OUTPUT
EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @OwnerUser, @UserId = @OwnerUserId OUTPUT
EXEC dbo.BugNet_User_GetUserIdByUserName @UserName = @LastUpdatedUser, @UserId = @LastUpdatedUserId OUTPUT
	
INSERT INTO @Data
SELECT IssueId
FROM BugNet_IssuesView   
WHERE
		((@IssueId IS NULL) OR ([IssueId] = @IssueId))
    AND
    	((@ProjectId IS NULL) OR ([ProjectId] = @ProjectId))
    AND
    	((@ProjectCode IS NULL) OR ([ProjectCode] = @ProjectCode))    			
	AND
    	((@StatusId IS NULL) OR ([IssueStatusId] = @StatusId))
    AND
    	((@MilestoneId IS NULL) OR ([IssueMilestoneId] = @MilestoneId))
    AND
    	((@AffectedMilestoneId IS NULL) OR ([IssueAffectedMilestoneId] = @AffectedMilestoneId))    	
    AND
    	((@CategoryId IS NULL) OR ([IssueCategoryId] = @CategoryId))
    AND
    	((@TypeId IS NULL) OR ([IssueTypeId] = @TypeId))
    AND
    	((@PriorityId IS NULL) OR ([IssuePriorityId] = @PriorityId))
    AND
    	((@ResolutionId IS NULL) OR ([IssueResolutionId] = @ResolutionId))
    AND
    	((@AssignedUserId IS NULL) OR ([IssueAssignedUserId] = @AssignedUserId)) 
    AND
    	((@CreatorUserId IS NULL) OR ([IssueCreatorUserId] = @CreatorUserId))    	
    AND
    	((@OwnerUserId IS NULL) OR ([IssueOwnerUserId] = @OwnerUserId)) 
    AND
    	((@LastUpdatedUserId IS NULL) OR ([LastUpdateUserId] = @LastUpdatedUserId))     	   	
    AND
    	((@IsDisabled IS NULL) OR ([Disabled] = @IsDisabled)) 
    AND
    	((@IsClosed IS NULL) OR ([IsClosed] = @IsClosed))     	   	   	
ORDER BY 
	CASE WHEN @SortField = 'IssueId' AND @SortDirection = 'ASC' THEN IssueId END,
	CASE WHEN @SortField = 'IssueId' AND @SortDirection = 'DESC' THEN IssueId END DESC,
	CASE WHEN @SortField = 'ProjectName' AND @SortDirection = 'ASC' THEN ProjectName END,
	CASE WHEN @SortField = 'ProjectName' AND @SortDirection = 'DESC' THEN ProjectName END DESC,
	CASE WHEN @SortField = 'ProjectCode' AND @SortDirection = 'ASC' THEN ProjectCode END,
	CASE WHEN @SortField = 'ProjectCode' AND @SortDirection = 'DESC' THEN ProjectCode END DESC,
	CASE WHEN @SortField = 'Votes' AND @SortDirection = 'ASC' THEN IssueVotes END,
	CASE WHEN @SortField = 'Votes' AND @SortDirection = 'DESC' THEN IssueVotes END DESC,
	CASE WHEN @SortField = 'Title' AND @SortDirection = 'ASC' THEN IssueTitle END,
	CASE WHEN @SortField = 'Title' AND @SortDirection = 'DESC' THEN IssueTitle END DESC,
	CASE WHEN @SortField = 'Description' AND @SortDirection = 'ASC' THEN IssueDescription END,
	CASE WHEN @SortField = 'Description' AND @SortDirection = 'DESC' THEN IssueDescription END DESC,
	CASE WHEN @SortField = 'StatusName' AND @SortDirection = 'ASC' THEN StatusName END,
	CASE WHEN @SortField = 'StatusName' AND @SortDirection = 'DESC' THEN StatusName END DESC,
	CASE WHEN @SortField = 'IsClosed' AND @SortDirection = 'ASC' THEN IsClosed END,
	CASE WHEN @SortField = 'IsClosed' AND @SortDirection = 'DESC' THEN IsClosed END DESC,
	CASE WHEN @SortField = 'PriorityName' AND @SortDirection = 'ASC' THEN PriorityName END,
	CASE WHEN @SortField = 'PriorityName' AND @SortDirection = 'DESC' THEN PriorityName END DESC,
	CASE WHEN @SortField = 'TypeName' AND @SortDirection = 'ASC' THEN IssueTypeName END,
	CASE WHEN @SortField = 'TypeName' AND @SortDirection = 'DESC' THEN IssueTypeName END DESC,
	CASE WHEN @SortField = 'Visibility' AND @SortDirection = 'ASC' THEN IssueVisibility END,
	CASE WHEN @SortField = 'Visibility' AND @SortDirection = 'DESC' THEN IssueVisibility END DESC,
	CASE WHEN @SortField = 'Estimation' AND @SortDirection = 'ASC' THEN IssueEstimation END,
	CASE WHEN @SortField = 'Estimation' AND @SortDirection = 'DESC' THEN IssueEstimation END DESC,
	CASE WHEN @SortField = 'Progress' AND @SortDirection = 'ASC' THEN IssueProgress END,
	CASE WHEN @SortField = 'Progress' AND @SortDirection = 'DESC' THEN IssueProgress END DESC,
	CASE WHEN @SortField = 'DueDate' AND @SortDirection = 'ASC' THEN IssueDueDate END,
	CASE WHEN @SortField = 'DueDate' AND @SortDirection = 'DESC' THEN IssueDueDate END DESC,
	CASE WHEN @SortField = 'Disabled' AND @SortDirection = 'ASC' THEN [Disabled] END,
	CASE WHEN @SortField = 'Disabled' AND @SortDirection = 'DESC' THEN [Disabled] END DESC,
	CASE WHEN @SortField = 'CategoryId' AND @SortDirection = 'ASC' THEN IssueCategoryId END,
	CASE WHEN @SortField = 'CategoryId' AND @SortDirection = 'DESC' THEN IssueCategoryId END DESC,
	CASE WHEN @SortField = 'CategoryName' AND @SortDirection = 'ASC' THEN CategoryName END,
	CASE WHEN @SortField = 'CategoryName' AND @SortDirection = 'DESC' THEN CategoryName END DESC,
	CASE WHEN @SortField = 'ResolutionId' AND @SortDirection = 'ASC' THEN IssueResolutionId END,
	CASE WHEN @SortField = 'ResolutionId' AND @SortDirection = 'DESC' THEN IssueResolutionId END DESC,
	CASE WHEN @SortField = 'ResolutionName' AND @SortDirection = 'ASC' THEN ResolutionName END,
	CASE WHEN @SortField = 'ResolutionName' AND @SortDirection = 'DESC' THEN ResolutionName END DESC,
	CASE WHEN @SortField = 'MilestoneName' AND @SortDirection = 'ASC' THEN MilestoneName END,
	CASE WHEN @SortField = 'MilestoneName' AND @SortDirection = 'DESC' THEN MilestoneName END DESC,
	CASE WHEN @SortField = 'AffectedMilestoneName' AND @SortDirection = 'ASC' THEN AffectedMilestoneName END,
	CASE WHEN @SortField = 'AffectedMilestoneName' AND @SortDirection = 'DESC' THEN AffectedMilestoneName END DESC,
	CASE WHEN @SortField = 'CreatedOn' AND @SortDirection = 'ASC' THEN DateCreated END,
	CASE WHEN @SortField = 'CreatedOn' AND @SortDirection = 'DESC' THEN DateCreated END DESC,
	CASE WHEN @SortField = 'CreatedBy' AND @SortDirection = 'ASC' THEN CreatorDisplayName END,
	CASE WHEN @SortField = 'CreatedBy' AND @SortDirection = 'DESC' THEN CreatorDisplayName END DESC,
	CASE WHEN @SortField = 'AssignedTo' AND @SortDirection = 'ASC' THEN AssignedDisplayName END,
	CASE WHEN @SortField = 'AssignedTo' AND @SortDirection = 'DESC' THEN AssignedDisplayName END DESC,
	CASE WHEN @SortField = 'OwnedBy' AND @SortDirection = 'ASC' THEN OwnerDisplayName END,
	CASE WHEN @SortField = 'OwnedBy' AND @SortDirection = 'DESC' THEN OwnerDisplayName END DESC,	
	CASE WHEN @SortField = 'UpdatedOn' AND @SortDirection = 'ASC' THEN LastUpdate END,
	CASE WHEN @SortField = 'UpdatedOn' AND @SortDirection = 'DESC' THEN LastUpdate END DESC,
	CASE WHEN @SortField = 'UpdatedBy' AND @SortDirection = 'ASC' THEN LastUpdateDisplayName END,
	CASE WHEN @SortField = 'UpdatedBy' AND @SortDirection = 'DESC' THEN LastUpdateDisplayName END DESC

SET @row_count = (SELECT COUNT(*) FROM @Data)

SELECT *
FROM BugNet_IssuesView i
INNER JOIN @Data d ON d.IssueId = i.IssueId
WHERE ((@PageSize IS NULL) OR ([ROW_NUMBER] BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize))

RETURN @row_count