CREATE PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
  @IssueId int,
  @CreatedUserName nvarchar(255),
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatedUserName

	INSERT BugNet_IssueHistory
	(
		IssueId,
		UserId,
		FieldChanged,
		OldValue,
		NewValue,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN scope_identity()
