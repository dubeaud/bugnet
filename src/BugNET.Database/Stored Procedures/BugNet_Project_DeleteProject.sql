
CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProject]
    @ProjectIdToDelete int
AS

--Delete these first
DELETE FROM BugNet_IssueVotes WHERE BugNet_IssueVotes.IssueId in (SELECT B.IssueId FROM BugNet_Issues B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_Issues WHERE ProjectId = @ProjectIdToDelete

--Now Delete everything that was attached to a project and an issue
DELETE FROM BugNet_Issues WHERE BugNet_Issues.IssueCategoryId in (SELECT B.CategoryId FROM BugNet_ProjectCategories B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCategories WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_UserProjects WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectMailBoxes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectIdToDelete

--now delete everything attached to the project
DELETE FROM BugNet_ProjectCustomFieldValues WHERE BugNet_ProjectCustomFieldValues.CustomFieldId in (SELECT B.CustomFieldId FROM BugNet_ProjectCustomFields B WHERE B.ProjectId = @ProjectIdToDelete)
DELETE FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Roles WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_Queries WHERE ProjectId = @ProjectIdToDelete
DELETE FROM BugNet_ProjectNotifications WHERE ProjectId = @ProjectIdToDelete

--now delete the project
DELETE FROM BugNet_Projects WHERE ProjectId = @ProjectIdToDelete

