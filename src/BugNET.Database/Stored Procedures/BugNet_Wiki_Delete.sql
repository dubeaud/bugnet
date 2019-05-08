CREATE PROCEDURE [dbo].[BugNet_Wiki_Delete]
 @Id int
AS
	DELETE C FROM BugNet_WikiContent C
    JOIN BugNet_WikiTitle T ON T.Id = C.TitleId
    WHERE T.Id = @Id