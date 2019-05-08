CREATE PROCEDURE [dbo].[BugNet_Wiki_GetHistory]
 @Id int
AS
	SELECT
        C.Id, C.Source, C.Version, C.VersionDate, C.TitleId, T.Name, T.Slug, 0, T.ProjectId, C.UserId CreatorUserId,
		ISNULL(DisplayName,'') CreatorDisplayName
     FROM BugNet_WikiContent C
     JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
	 JOIN Users U ON C.UserId = U.UserId
	 LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
     WHERE T.Id = @Id
     ORDER BY C.Version DESC