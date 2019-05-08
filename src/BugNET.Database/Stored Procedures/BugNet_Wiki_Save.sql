CREATE PROCEDURE [dbo].[BugNet_Wiki_Save]
 @ProjectId int,
 @TitleId int,
 @Slug nvarchar(255),
 @Name nvarchar(255),
 @Source nvarchar(max),
 @CreatedByUserName NVarChar(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER
	DECLARE @ContentCount INT

	SELECT @ContentCount = (SELECT COUNT(*) FROM BugNet_WikiContent WHERE TitleId = T.Id) 
     FROM BugNet_WikiTitle T
     WHERE T.Id = @TitleId
	
	SELECT @UserId = UserId FROM Users WHERE UserName = @CreatedByUserName
    
	IF (@TitleId = 0) BEGIN
        INSERT INTO BugNet_WikiTitle (Name, Slug, ProjectId)
        VALUES (@Name, @Slug, @ProjectId)

        SELECT @TitleId = SCOPE_IDENTITY()
    END

    INSERT INTO BugNet_WikiContent (TitleId, Source, Version, VersionDate, UserId)
    VALUES (@TitleId, @Source, ISNULL(@ContentCount, 0) + 1, GETDATE(), @UserId)

    SELECT @TitleId