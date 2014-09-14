CREATE VIEW [dbo].[BugNet_ProjectsView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_Projects.ProjectId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, dbo.BugNet_Projects.ProjectDescription, 
                      dbo.BugNet_Projects.AttachmentUploadPath, dbo.BugNet_Projects.ProjectManagerUserId, dbo.BugNet_Projects.ProjectCreatorUserId, 
                      dbo.BugNet_Projects.DateCreated, dbo.BugNet_Projects.ProjectDisabled, dbo.BugNet_Projects.ProjectAccessType, Managers.UserName AS ManagerUserName, 
                      ISNULL(Managers.DisplayName, N'none') AS ManagerDisplayName, Creators.UserName AS CreatorUserName, ISNULL(Creators.DisplayName, 
                      N'none') AS CreatorDisplayName, dbo.BugNet_Projects.AllowAttachments, dbo.BugNet_Projects.AttachmentStorageType, dbo.BugNet_Projects.SvnRepositoryUrl, 
                      dbo.BugNet_Projects.AllowIssueVoting
FROM         dbo.BugNet_Projects INNER JOIN
                      dbo.AspNetUsers AS Managers ON Managers.Id = dbo.BugNet_Projects.ProjectManagerUserId INNER JOIN
                      dbo.AspNetUsers AS Creators ON Creators.Id = dbo.BugNet_Projects.ProjectCreatorUserId 
ORDER BY dbo.BugNet_Projects.ProjectName
