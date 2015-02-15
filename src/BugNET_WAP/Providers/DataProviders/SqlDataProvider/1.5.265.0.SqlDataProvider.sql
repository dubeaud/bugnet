INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('de-DE', 'German (Germany)', 'en-US')
GO

IF NOT EXISTS(SELECT * FROM [dbo].[BugNet_HostSettings] WHERE [SettingName] = 'EnableGravatar')
BEGIN
    INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('EnableGravatar', 'False')
END
GO

ALTER PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
  @IssueId int,
  @FileName nvarchar(250),
  @FileSize Int,
  @ContentType nvarchar(50),
  @CreatorUserName nvarchar(255),
  @Description nvarchar(80),
  @Attachment Image
AS
-- Get Uploaded UserID
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM Users WHERE UserName = @CreatorUserName
INSERT BugNet_IssueAttachments
(
	IssueId,
	FileName,
	Description,
	FileSize,
	ContentType,
	DateCreated,
	UserId,
	Attachment
)
VALUES
(
	@IssueId,
	@FileName,
	@Description,
	@FileSize,
	@ContentType,
	GetDate(),
	@UserId,
	@Attachment
	
)
RETURN scope_identity()
GO