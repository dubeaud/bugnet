CREATE PROCEDURE [dbo].[BugNet_DefaultValues_Set]
	@Type nvarchar(50),
	@ProjectId Int,
	@StatusId Int,
	@IssueOwnerUserName NVarChar(255),
	@IssuePriorityId Int,
	@IssueAssignedUserName NVarChar(255),
	@IssueVisibility int,
	@IssueCategoryId Int,
	@IssueAffectedMilestoneId Int,
	@IssueDueDate int,
	@IssueProgress Int,
	@IssueMilestoneId Int,
	@IssueEstimation decimal(5,2),
	@IssueResolutionId Int,
	@StatusVisibility		 Bit,
	@OwnedByVisibility		 Bit,
	@PriorityVisibility		 Bit,
	@AssignedToVisibility	 Bit,
	@PrivateVisibility		 Bit,
	@CategoryVisibility		 Bit,
	@DueDateVisibility		 Bit,
	@TypeVisibility			 Bit,
	@PercentCompleteVisibility Bit,
	@MilestoneVisibility	Bit, 
	@EstimationVisibility	 Bit,
	@ResolutionVisibility	 Bit,
	@AffectedMilestoneVisibility Bit,
	@StatusEditVisibility		 Bit,
	@OwnedByEditVisibility		 Bit,
	@PriorityEditVisibility		 Bit,
	@AssignedToEditVisibility	 Bit,
	@PrivateEditVisibility		 Bit,
	@CategoryEditVisibility		 Bit,
	@DueDateEditVisibility		 Bit,
	@TypeEditVisibility			 Bit,
	@PercentCompleteEditVisibility Bit,
	@MilestoneEditVisibility	Bit, 
	@EstimationEditVisibility	 Bit,
	@ResolutionEditVisibility	 Bit,
	@AffectedMilestoneEditVisibility Bit,
	@OwnedByNotify Bit,
	@AssignedToNotify Bit
AS
DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName
SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
BEGIN
	BEGIN TRAN
		DECLARE @defVisExists int
		SELECT @defVisExists = COUNT(*) 
		FROM BugNet_DefaultValuesVisibility
			WHERE BugNet_DefaultValuesVisibility.ProjectId = @ProjectId
				IF(@defVisExists>0)
					BEGIN
						UPDATE BugNet_DefaultValuesVisibility
						SET 								
							StatusVisibility = @StatusVisibility,			
							OwnedByVisibility = @OwnedByVisibility,				
							PriorityVisibility = @PriorityVisibility,			
							AssignedToVisibility = @AssignedToVisibility,			
							PrivateVisibility= @PrivateVisibility,			
							CategoryVisibility= @CategoryVisibility,			
							DueDateVisibility= @DueDateVisibility,				
							TypeVisibility	= @TypeVisibility,				
							PercentCompleteVisibility = @PercentCompleteVisibility,		
							MilestoneVisibility	= @MilestoneVisibility,			
							EstimationVisibility = @EstimationVisibility,			
							ResolutionVisibility = @ResolutionVisibility,
							AffectedMilestoneVisibility = @AffectedMilestoneVisibility,
							StatusEditVisibility = @StatusEditVisibility,			
							OwnedByEditVisibility = @OwnedByEditVisibility,				
							PriorityEditVisibility = @PriorityEditVisibility,			
							AssignedToEditVisibility = @AssignedToEditVisibility,			
							PrivateEditVisibility= @PrivateEditVisibility,			
							CategoryEditVisibility= @CategoryEditVisibility,			
							DueDateEditVisibility= @DueDateEditVisibility,				
							TypeEditVisibility	= @TypeEditVisibility,				
							PercentCompleteEditVisibility = @PercentCompleteEditVisibility,		
							MilestoneEditVisibility	= @MilestoneEditVisibility,			
							EstimationEditVisibility = @EstimationEditVisibility,			
							ResolutionEditVisibility = @ResolutionEditVisibility,
							AffectedMilestoneEditVisibility = @AffectedMilestoneEditVisibility	
					WHERE ProjectId = @ProjectId							
					END
				ELSE
					BEGIN
					INSERT INTO BugNet_DefaultValuesVisibility
					VALUES 
					(
						@ProjectId				 ,  
						@StatusVisibility		 ,
						@OwnedByVisibility		 ,
						@PriorityVisibility		 ,
						@AssignedToVisibility	 ,
						@PrivateVisibility		 ,
						@CategoryVisibility		 ,
						@DueDateVisibility		 ,
						@TypeVisibility			 ,
						@PercentCompleteVisibility,
						@MilestoneVisibility	,	 
						@EstimationVisibility	 ,
						@ResolutionVisibility	,
						@AffectedMilestoneVisibility,
						@StatusEditVisibility		 ,
						@OwnedByEditVisibility		 ,
						@PriorityEditVisibility		 ,
						@AssignedToEditVisibility	 ,
						@PrivateEditVisibility		 ,
						@CategoryEditVisibility		 ,
						@DueDateEditVisibility		 ,
						@TypeEditVisibility			 ,
						@PercentCompleteEditVisibility,
						@MilestoneEditVisibility	,	 
						@EstimationEditVisibility	 ,
						@ResolutionEditVisibility	,
						@AffectedMilestoneEditVisibility	  					
					)
					END


		DECLARE @defExists int
		SELECT @defExists = COUNT(*) 
			FROM BugNet_DefaultValues
			WHERE BugNet_DefaultValues.ProjectId = @ProjectId
		
		IF (@defExists > 0)
		BEGIN
			UPDATE BugNet_DefaultValues 
				SET DefaultType = @Type,
					StatusId = @StatusId,
					IssueOwnerUserId = @IssueOwnerUserId,
					IssuePriorityId = @IssuePriorityId,
					IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
					IssueAssignedUserId = @IssueAssignedUserId,
					IssueVisibility = @IssueVisibility,
					IssueCategoryId = @IssueCategoryId,
					IssueDueDate = @IssueDueDate,
					IssueProgress = @IssueProgress,
					IssueMilestoneId = @IssueMilestoneId,
					IssueEstimation = @IssueEstimation,
					IssueResolutionId = @IssueResolutionId,
					OwnedByNotify = @OwnedByNotify,
					AssignedToNotify = @AssignedToNotify
				WHERE ProjectId = @ProjectId
		END
		ELSE
		BEGIN
			INSERT INTO BugNet_DefaultValues 
				VALUES (
					@ProjectId,
					@Type,
					@StatusId,
					@IssueOwnerUserId,
					@IssuePriorityId,
					@IssueAffectedMilestoneId,
					@IssueAssignedUserId,
					@IssueVisibility,
					@IssueCategoryId,
					@IssueDueDate,
					@IssueProgress,
					@IssueMilestoneId,
					@IssueEstimation,
					@IssueResolutionId,
					@OwnedByNotify,
					@AssignedToNotify 
				)
		END
	COMMIT TRAN
END
