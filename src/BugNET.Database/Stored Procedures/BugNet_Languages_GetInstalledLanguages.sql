CREATE PROCEDURE [dbo].[BugNet_Languages_GetInstalledLanguages]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT CultureCode FROM BugNet_Languages
END
