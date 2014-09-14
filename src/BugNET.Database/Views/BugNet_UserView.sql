CREATE VIEW [dbo].[BugNet_UserView]
AS
SELECT  
	Id AS UserId, FirstName, LastName, DisplayName, UserName, Email, IsApproved, IssuesPageSize, PreferredLocale
FROM    
	dbo.AspNetUsers 
GROUP BY 
	Id, UserName, Email, IsApproved, FirstName, LastName, DisplayName, IssuesPageSize, PreferredLocale
