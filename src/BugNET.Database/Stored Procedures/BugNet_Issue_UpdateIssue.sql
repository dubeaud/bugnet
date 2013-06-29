CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
  @IssueId Int,
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @LastUpdateUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER
DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM Users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName
SELECT @LastUpdateUserId = UserId FROM Users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		IssueTitle = @IssueTitle,
		IssueCategoryId = @IssueCategoryId,
		ProjectId = @ProjectId,
		IssueStatusId = @IssueStatusId,
		IssuePriorityId = @IssuePriorityId,
		IssueMilestoneId = @IssueMilestoneId,
		IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
		IssueAssignedUserId = @IssueAssignedUserId,
		IssueOwnerUserId = @IssueOwnerUserId,
		IssueTypeId = @IssueTypeId,
		IssueResolutionId = @IssueResolutionId,
		IssueDueDate = @IssueDueDate,
		IssueVisibility = @IssueVisibility,
		IssueEstimation = @IssueEstimation,
		IssueProgress = @IssueProgress,
		IssueDescription = @IssueDescription,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
	
	/*EXEC BugNet_IssueHistory_CreateNewHistory @IssueId, @IssueCreatorId*/
COMMIT TRAN
